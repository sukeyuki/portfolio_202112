class SchedulesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  # before_action :correct_user
  def index
    @user = current_user
    # @group_user = GroupUser.new
    # @group_users_all = GroupUser.all
    # @users_all = User.all
    # @first_day = start_at_params=={} ? Time.current : Time.zone.parse(start_at_params[:start_at])
    @first_day = start_at_params=={} ? Time.zone.today.beginning_of_day : Time.zone.parse(start_at_params[:start_at])
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

    # TODO: 他スケジュールが被った場合の対処

    #######パラメータ代入#######
    #HTMLの表の長さ一覧
    time_disp_width = 50
    day_disp_height = 40
    one_hour_width = 200
    one_hour_height = 40
    #チェックボックスにチェックされたグループのスケジュールで、表示範囲にかかっているスケジュール一覧 
    @show_schedules = Schedule.where(group_id:@groups_show_list).where("end_at > ?", @first_day).where("start_at < ?", @first_day.since(6.days).end_of_day)
    #表示するスケジュールの位置を代入するハッシュ
    @schedules_position_parameters = {}
    #########################


    #######スケジュール表示位置計算#######
    # schedule_ids = []
    schedule_start_end_arr = []
    @show_schedules.each do |schedule|
      # schedule_ids << schedule.id
      schedule_start_end_arr << [schedule.start_at, schedule.end_at]
    end
    schedule_overlap_params = {}
    @show_schedules.each.with_index do |schedule, index|
      schedule_overlap_params[schedule.id] = {}
      schedule_overlap_params[schedule.id][:overlap_count] = overlap_count(schedule_start_end_arr,true)[index]
      schedule_overlap_params[schedule.id][:position_calc] = position_calc(schedule_start_end_arr,index)
    end
  # debugger


    @show_schedules.each do |schedule|
      day_diff = (schedule.end_at.to_date-schedule.start_at.to_date).to_i
      if day_diff >= 1
        #日を跨ぐ場合は、start_atからその日一日中の予定を入れる。
        #加えて、end_atがある日はその日の始まりからend_atまでの予定を入れる。
        @schedules_position_parameters[schedule.id] = []      
        par = {}
        par[:top]    = day_disp_height + one_hour_height*((schedule.start_at - @first_day).to_i%86400).to_f/(60*60).to_f
        par[:height] = one_hour_height*(schedule.start_at.end_of_day - schedule.start_at).to_f/(60*60).to_f
        par[:width]  = one_hour_width / schedule_overlap_params[schedule.id][:overlap_count]
        par[:left]   = time_disp_width + one_hour_width*((schedule.start_at - @first_day).to_i/86400) + par[:width] * (schedule_overlap_params[schedule.id][:position_calc]-1)
        # par[:zindex] = schedule_z_index[schedule.id]
        @schedules_position_parameters[schedule.id] << par if schedule.start_at >= @first_day
        par = {}
        par[:top]    = day_disp_height
        par[:height] = one_hour_height*(schedule.end_at - schedule.end_at.beginning_of_day).to_f/(60*60).to_f
        par[:width]  = one_hour_width / schedule_overlap_params[schedule.id][:overlap_count]
        par[:left]   = time_disp_width + one_hour_width*((schedule.end_at - @first_day).to_i/86400)  + par[:width] * (schedule_overlap_params[schedule.id][:position_calc]-1)
        # par[:zindex] = schedule_z_index[schedule.id]
        #表示範囲に入らない場合は配列に加えない
        @schedules_position_parameters[schedule.id] << par  if schedule.end_at <= @first_day.since(6.days).end_of_day

        if day_diff >= 2
          # 日を2日以上跨ぐ場合に一日中の予定を作成
          (day_diff-1).times do |n|
            par = {}
            par[:top]    = day_disp_height
            par[:height] = one_hour_height*24
            par[:width]  = one_hour_width / schedule_overlap_params[schedule.id][:overlap_count]
            par[:left]   = time_disp_width + one_hour_width*(((schedule.start_at - @first_day).to_i/86400)+n+1) + par[:width] * (schedule_overlap_params[schedule.id][:position_calc]-1)
            # par[:zindex] = schedule_z_index[schedule.id]
            #表示範囲に入らない場合は配列に加えない
            @schedules_position_parameters[schedule.id] << par  if ((schedule.start_at - @first_day).to_i/86400)+n+1 >= 0 and ((schedule.start_at - @first_day).to_i/86400)+n+1 <= 6
          end
        end
      else
        #日を跨がない場合
        par = {}
        par[:top]    = day_disp_height + one_hour_height*((schedule.start_at - @first_day).to_i%86400).to_f/(60*60).to_f
        par[:height] = one_hour_height*(schedule.end_at - schedule.start_at).to_f/(60*60).to_f
        par[:width]  = one_hour_width / schedule_overlap_params[schedule.id][:overlap_count]
        par[:left]   = time_disp_width + one_hour_width*((schedule.start_at - @first_day).to_i/86400) + par[:width] * (schedule_overlap_params[schedule.id][:position_calc]-1)
        # par[:zindex] = schedule_z_index[schedule.id]
        @schedules_position_parameters[schedule.id] = [par]      
      end      
    end
    ##################################
    # フレンドリーフォーワーディング用。group_user#destroy実行後このurlにredirectする。
    session[:forwarding_url] = request.original_url if request.get?
  end

  def create
    @schedule = Schedule.new(schedule_params)
    unless @schedule.save
      flash[:errors] = @schedule.errors.messages
    end
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
    # redirect_to root_path
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
      params.permit(:start_at)
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