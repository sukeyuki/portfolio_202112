class SchedulesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # before_action :correct_user
  def index
    @user = current_user
    @new_group = Group.new
    @new_schedule = Schedule.new
    @group_user = GroupUser.new
    @group_users_all = GroupUser.all
    @users_all = User.all
    # @first_day = start_at_params=={} ? Date.today : Date.parse(start_at_params[:start_at])
    @first_day = start_at_params=={} ? Time.current : Time.zone.parse(start_at_params[:start_at])
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

    # グループのチェックボックス処理用
    @groups_show_list = []
    group_show_params.each do |key, *|
      @groups_show_list << key.delete("-checkbox").to_i
    end

    # TODO: チェックされたグループのスケジュールで、かつ表示範囲にかかっているスケジュールを抜き出す。
    # TODO: その後、インスタンス変数に代入する。（スケジュールの集合？id？）

    @show_schedules
    # debugger
    Schedule.where(group_id:@groups_show_list).each do
    end



    # フレンドリーフォーワーディング用。group_user#destroy実行後このurlにredirectする。
    session[:forwarding_url] = request.original_url if request.get?
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

    def start_at_params
      para = params.permit(:start_at)
    end

    def group_show_params
      # group名と"-checked"を組み合わせてsymbol化する。
      group_syms = current_user.groups.map {|group| (group.id.to_s+"-checkbox").to_sym}
      params.permit(*group_syms)
    end



  # def correct_user
  #   @user = User.find_by(id:params[:id])
  #   redirect_to("/users/#{current_user.id}") unless (current_user == @user)
  # end
end