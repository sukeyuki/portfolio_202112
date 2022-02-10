class SchedulesController < ApplicationController
  include SchedulesHelper
  require "csv"
  before_action :authenticate_user!, only: [:index]

  # GET /schedules
  def index
    @user = current_user
    @user_active_groups = Group.with_active_user(@user)
    @user_non_active_groups = Group.with_not_active_user(@user)

    # 表示日時処理用
    if first_day_search_bool["first_day_search"] == "true"
      # index画面から選択した場合はその値を@first_dayに値を代入。空の場合は本日の日付。
      @first_day = start_at_params=={} ? Time.zone.today.beginning_of_day : Time.zone.parse(start_at_params[:start_at])
    elsif session[:first_day]
      # 他画面からの遷移の場合はsessionの値を代入。
      @first_day = Time.zone.parse(session[:first_day])
    else
      # ログイン直後の場合は本日の日付を代入。
      @first_day = Time.zone.today.beginning_of_day
    end

    # グループのチェックボックス処理用
    @groups_show_list = []
    if checkbox_search_bool["checkbox_search"] == "true"
      # index画面から選択した場合はその値を@groups_show_listに値を代入。
      @groups_show_list = group_show_params["checkbox"]&.split(",")&.map(&:to_i) || []
    else
      # 他画面からの遷移の場合はsessionの値を代入。ログイン直後の場合は空の配列を代入。
      @groups_show_list = session[:checkbox_list] || []
    end

    # CSV出力用処理
    respond_to do |format|
      format.html
      format.csv do
        send_csv_data(@user, @groups_show_list, displayed_schedules(@groups_show_list,@first_day))
      end
    end

    # 他画面からのリダイレクト対応用処理
    session[:checkbox_list] = @groups_show_list
    session[:first_day] = @first_day.strftime("%F")
  end

  # POST /schedules    ajax
  def create
    schedule = Schedule.new(schedule_params)
    unless schedule.save
      flash[:create_schedule_error] = schedule.errors.full_messages
    end
  end

  # PUT /schedules/:id     ajax
  def update
    schedule = Schedule.find(params[:id])
    unless schedule.update(schedule_params)
      flash[:update_schedule_error] = schedule.errors.full_messages
    end
  end

  # DELETE /schedules/:id
  def destroy
    Schedule.find(params[:id]).destroy
    redirect_to root_url
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

  def checkbox_search_bool
    params.permit(:checkbox_search)
  end

  def first_day_search_bool
    params.permit(:first_day_search)
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