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
    @first_day = start_at_params=={} ? Date.today : Date.parse(start_at_params[:start_at])
    # debugger
    unless current_user.groups.find_by(personal:true)
      group = current_user.groups.new(name:"private", personal:true, overview:"my personal scuedule")
      group_user = GroupUser.new(user:current_user, group:group,role:10, activated: true)
      begin
        ActiveRecord::Base.transaction do
          group.save!
          group_user.save!
        end

      rescue
        flash[:errors] = []
        flash[:errors] << group.errors.messages
        flash[:errors] << group_user.errors.messages
      end
    end
    # debugger


    # @groups_show ||= {}
    # @user.groups.each do |group|
    #   @groups_show[group.id] = false
    # end
    # @groups_show[1] = true
  end

  def create
    debugger
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

    def start_at_params
      para = params.permit(:start_at)
    end



  # def correct_user
  #   @user = User.find_by(id:params[:id])
  #   redirect_to("/users/#{current_user.id}") unless (current_user == @user)
  # end
end