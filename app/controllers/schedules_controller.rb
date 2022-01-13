class SchedulesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # before_action :correct_user
  def index
    #FIXME: root_urlにて動作させるとデータが入らない事がある。
    @user = current_user
    @new_group = Group.new
    @new_schedule = Schedule.new
    @group_user = GroupUser.new
    @group_users_all = GroupUser.all
    @users_all = User.all
    @first_day = params[:first_day] || Date.today
    # @groups_show ||= {}
    # @user.groups.each do |group|
    #   @groups_show[group.id] = false
    # end
    # @groups_show[1] = true
  end

  def create
    @schedule = Schedule.new(schedule_params)
    unless @schedule.save
      flash[:errors] = @schedule.errors.messages
    end
    redirect_to root_path
  end

  def update
    @schedule = Schedule.find(params[:id])
    @schedule.update(schedule_params)
    redirect_to action: :index
  end

  private
    def schedule_params
      params.require(:schedule).permit(:group_id, :title, :contents, :start_at, :end_at)
    end



  # def correct_user
  #   @user = User.find_by(id:params[:id])
  #   redirect_to("/users/#{current_user.id}") unless (current_user == @user)
  # end
end