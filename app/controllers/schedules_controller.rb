class SchedulesController < ApplicationController
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
    # フレンドリーフォーワーディング用。group_user#destroy実行後このurlにredirectする。
    session[:forwarding_url] = request.original_url if request.get?
  end

  def create
    schedule = Schedule.new(schedule_params)
    unless schedule.save
      flash[:errors] = schedule.errors.messages
    end
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
  end

  def update
    schedule = Schedule.find(params[:id])
    schedule.update(schedule_params)
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
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
end