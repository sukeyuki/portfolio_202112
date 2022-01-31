module SchedulesHelper

  def displayed_schedules(group_list,first_day)
    Schedule.where(group_id:group_list).where("end_at > ?", first_day).where("start_at < ?", first_day.since(6.days).end_of_day)
  end

  def displayed_schedules_params(schedules, first_day)
    #######パラメータ代入#######
    #HTMLの表の長さ一覧
    margin = 5
    w_time_disp = 50
    h_day_disp = 40
    w_one_hour = 200
    h_one_hour = 40
    #表示するスケジュールの位置を代入するハッシュ
    schedules_position_parameters = {}
    #########################

    #######スケジュール表示位置計算#######
    schedule_start_end_arr = []
    schedules.each do |schedule|
      schedule_start_end_arr << [schedule.start_at, schedule.end_at]
    end
    schedule_overlap_params = {}
    
    schedules.each.with_index do |schedule, index|
      schedule_overlap_params[schedule.id] = {}
      schedule_overlap_params[schedule.id][:overlap_count] = overlap_count(schedule_start_end_arr,true)[index]
      schedule_overlap_params[schedule.id][:position_calc] = position_calc(schedule_start_end_arr,index)
    end

    schedules.each do |schedule|
      day_diff = (schedule.end_at.to_date-schedule.start_at.to_date).to_i
      if day_diff >= 1
        #日を跨ぐ場合は、start_atからその日一日中の予定を入れる。
        #加えて、end_atがある日はその日の始まりからend_atまでの予定を入れる。
        schedules_position_parameters[schedule.id] = []      
        par = {}
        par[:top]    = h_day_disp + h_one_hour*((schedule.start_at - first_day).to_i%86400).to_f/(60*60).to_f
        par[:height] = h_one_hour*(schedule.start_at.end_of_day - schedule.start_at).to_f/(60*60).to_f
        par[:width]  = (w_one_hour-2*margin) / schedule_overlap_params[schedule.id][:overlap_count]
        par[:left]   = w_time_disp + w_one_hour*((schedule.start_at - first_day).to_i/86400) + par[:width] * (schedule_overlap_params[schedule.id][:position_calc]-1) + margin
        schedules_position_parameters[schedule.id] << par if schedule.start_at >= first_day
        par = {}
        par[:top]    = h_day_disp
        par[:height] = h_one_hour*(schedule.end_at - schedule.end_at.beginning_of_day).to_f/(60*60).to_f
        par[:width]  = (w_one_hour-2*margin) / schedule_overlap_params[schedule.id][:overlap_count]
        par[:left]   = w_time_disp + w_one_hour*((schedule.end_at - first_day).to_i/86400)  + par[:width] * (schedule_overlap_params[schedule.id][:position_calc]-1) + margin
        #表示範囲に入らない場合は配列に加えない
        schedules_position_parameters[schedule.id] << par  if schedule.end_at <= first_day.since(6.days).end_of_day

        if day_diff >= 2
          # 日を2日以上跨ぐ場合に一日中の予定を作成
          (day_diff-1).times do |n|
            par = {}
            par[:top]    = h_day_disp
            par[:height] = h_one_hour*24
            par[:width]  = (w_one_hour-2*margin) / schedule_overlap_params[schedule.id][:overlap_count]
            par[:left]   = w_time_disp + w_one_hour*(((schedule.start_at - first_day).to_i/86400)+n+1) + par[:width] * (schedule_overlap_params[schedule.id][:position_calc]-1) + margin
            #表示範囲に入らない場合は配列に加えない
            schedules_position_parameters[schedule.id] << par  if ((schedule.start_at - first_day).to_i/86400)+n+1 >= 0 and ((schedule.start_at - first_day).to_i/86400)+n+1 <= 6
          end
        end
      else
        #日を跨がない場合
        par = {}
        par[:top]    = h_day_disp + h_one_hour*((schedule.start_at - first_day).to_i%86400).to_f/(60*60).to_f
        par[:height] = h_one_hour*(schedule.end_at - schedule.start_at).to_f/(60*60).to_f
        par[:width]  = (w_one_hour-2*margin) / schedule_overlap_params[schedule.id][:overlap_count]
        par[:left]   = w_time_disp + w_one_hour*((schedule.start_at - first_day).to_i/86400) + par[:width] * (schedule_overlap_params[schedule.id][:position_calc]-1) + margin
        schedules_position_parameters[schedule.id] = [par]      
      end      
    end
    ##################################
    return schedules_position_parameters
  end


  def overlap_count(arr, begin_f)
    def calc_area_list(arr, index)
      new_arr = []
      arr.each_with_index do |ar,i|
        unless index == i
          if [arr[index][0],ar[0]].max < [arr[index][1], ar[1]].min
            new_arr << [[arr[index][0],arr[i][0]].max, [arr[index][1], arr[i][1]].min]
          end
        end
      end
      return new_arr
    end
  

    def chain_index(se_ar,index)
      rg = se_ar[index].dup
      arr = []
      arr << index
      se_ar.each_with_index do |ar,i|
        unless i == index
          if rg[0]<ar[1] and rg[1]>ar[0]
            rg[0] = [rg[0], ar[0]].min
            rg[1] = [rg[1], ar[1]].max
            if !arr.include?(i)
              arr << i
              redo
            end
          end
        end
      end
      return arr
    end

    # def chain_index(se_ar,index)
    #   arr = []
    #   arr << index
    #   se_ar.each_with_index do |ar,i|
    #     unless i == index
    #       if se_ar[index][0]<=ar[1] and se_ar[index][1]>=ar[0]
    #         arr << i
    #       end
    #     end
    #   end
    #   return arr
    # end
  
    if begin_f==true
      if arr.count == 0
        return [nil]
      elsif arr.count == 1
        return [1]
      end    
    end
  
    if arr.count == 0
      return 1
    elsif arr.count == 1
      return 2
    end
  
    count = []
    arr.each_with_index do |ar, index|
      count << overlap_count(calc_area_list(arr, index),false)
    end
  
    if begin_f==true
      return count.map.with_index do |c,i|
        chain_index(arr,i).map{|id|count[id]}.max
        # debugger
      end
    end
  
    return count.max+1
  end
  

  def position_calc(arr,i)
    flag_id = []
    same_start_list = []
    arr.each.with_index do |ele, index|
      unless  index == i
        if arr[i][0]== ele[0]
          same_start_list << index
        end
        if arr[i][0]>ele[0] and arr[i][0]<ele[1] 
          flag_id << index
        end
      end
    end
  
    if flag_id==[] and same_start_list==[]
      return 1
    end
  
    att=(1..20).to_a
    flag_id.each do |id|
      att.delete(position_calc(arr,id))
    end
  
    if same_start_list.min&.< i
      same_start_list << i
      att.delete(position_calc(arr, same_start_list.min))
      return att[same_start_list.sort!.index(i)-1]
    end
    return att.min
  end

  def id_with_index(groups)
    output = {}
    return nil if groups==nil
    groups.each.with_index do |group, index|
      output[group.id]=index
    end
    return output
  end
end


