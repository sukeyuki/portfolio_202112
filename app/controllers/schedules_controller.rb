class SchedulesController < ApplicationController
  include SchedulesHelper
  require "csv"
  before_action :authenticate_user!, only: [:index]
  def index
    @user = current_user
    @first_day = start_at_params=={} ? Time.zone.today.beginning_of_day : Time.zone.parse(start_at_params[:start_at])
    @user_active_groups = Group.with_active_user(@user)
    @user_non_active_groups = Group.with_not_active_user(@user)
    # グループのチェックボックス処理用
    @groups_show_list = []
    unless group_show_params["checkbox"]==nil
      group_show_ids = group_show_params["checkbox"].split(",")
      group_show_ids.each do |id|
        @groups_show_list << id.to_i
      end
    end

    # CSV出力用処理
    respond_to do |format|
      format.html
      format.csv do
        send_csv_data(@user, @groups_show_list, displayed_schedules(@groups_show_list,@first_day))
      end
    end

    @wrong_schedule_id = session[:wrong_schedule_id]
    # フレンドリーフォーワーディング用。group_user#destroy実行後このurlにredirectする。
    session[:forwarding_url] = request.original_url if request.get?
    # debugger
  end

  def create
    schedule = Schedule.new(schedule_params)
    unless schedule.save
      flash[:create_schedule_error] = schedule.errors.full_messages
      # flash[:alert] = schedule.errors.full_messages
    end
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
  end

  def update
    schedule = Schedule.find(params[:id])
    # debugger
    unless schedule.update(schedule_params)
      flash[:update_schedule_error] = schedule.errors.full_messages
      session[:wrong_schedule_id] = params[:id]
    end
    # debugger
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
    # debugger
  end

  def destroy
    Schedule.find(params[:id]).destroy
    # フレンドリーフォワーディング
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
  end

  private
  def schedule_params
    params.require(:schedule).permit(:group_id, :title, :contents, :start_at, :end_at)
  end

  def start_at_params
    params.permit(:start_at)
  end

  def group_show_params
    params.permit(:checkbox)
  end

  # csv出力用
  def send_csv_data(user, groups_show_list, schedules)
    csv_data = CSV.generate do |csv|
      csv << ["user_info"]
      csv << ["user_name", "user_id", "user_email"]
      csv << [user.name, user.search_name, user.email]
      csv << []
      csv << ["checked groups info"]
      csv << ["name", "overview"] unless groups_show_list == []
      Group.where(id:[groups_show_list]).each do |group|
        csv << [group.name, group.overview]
      end
      csv << []
      csv << ["displayed schedules info"]
      csv << ["title", "content", "start_at", "end_at"] unless schedules == []
      schedules.each do |schedule|
        csv << [schedule.title, schedule.contents, schedule.start_at, schedule.end_at]
      end
    end
    send_data(csv_data, filename:"test.csv")
  end

end