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

    #######スケジュール開始と終了を配列に入れる#######
    schedule_start_end_arr = []
    schedules.each do |schedule|
      schedule_start_end_arr << [schedule.start_at, schedule.end_at]
    end
    ############################################

    ##同時刻のスケジュールが被らないために何分割するか、どこに配置するかを計算##
    schedule_overlap_params = {}
    schedules.each.with_index do |schedule, index|
      schedule_overlap_params[schedule.id] = {}
      schedule_overlap_params[schedule.id][:overlap_count] = overlap_count(schedule_start_end_arr,index)
      # schedule_overlap_params[schedule.id][:overlap_count] = overlap_count(schedule_start_end_arr,true)[index]
      schedule_overlap_params[schedule.id][:position_calc] = position_calc(schedule_start_end_arr,index)
    end
    ###############################################################

    ######scheduleの配置位置を計算######
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

  

  ##スケジュールを何分割するかを求めるアルゴリズム
  def overlap_count(arr,index)

    def chain_index(arr, index)
      sorted = arr.sort
      range = [sorted[0]]
      pointer = 0
      sorted.each do |a|
        current_range = range[pointer]
        if current_range[1] <= a[0] || a[1] <= current_range[0]
          range << a
          pointer += 1
        else
          range[pointer] = [[current_range[0], a[0]].min, [current_range[1], a[1]].max]
        end
      end
      target_range = range.find{|v| !(v[1] <= arr[index][0] || arr[index][1] <= v[0]) }
      arr.size.times.select{|i| !(target_range[1] <= arr[i][0] || arr[i][1] <= target_range[0]) }
    end
    
    chain_schedules = chain_index(arr,index).map{|ind| arr[ind]}
    loop.with_index do |_, i|
      catch :done do
        comb = i+2
        chain_schedules.combination(comb) do |pair|
          latest_start = pair.map{|s|s[0]}.max
          earliest_end = pair.map{|s|s[1]}.min
          if latest_start < earliest_end
            throw :done
          end
        end
        return comb-1
      end
    end
  end


  ##スケジュールを何分割するかを求めるアルゴリズム
  ##本アルゴリズムは再帰を用いて実装している。begin_fはreturn直前の場合のみ処理を行うため実装している。return直前はtrue, それ以外はfalseが入る。
  def overlap_count_old(arr, begin_f)

    #指定したスケジュールと他のスケジュールの被っている範囲を出すアルゴリズム
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

    #被っているスケジュール一覧を求めるアルゴリズム
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
  
    #スケジュールが0個ならnilを返す。スケジュールが1個なら1を返す。
    if begin_f==true
      if arr.count == 0
        return [nil]
      elsif arr.count == 1
        return [1]
      end    
    end

    #再帰のベースケース
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
      end
    end
  
    return count.max+1
  end
  
  ##スケジュールどうしが被らない位置を計算するアルゴリズム
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

  def time_disp
    tag.div(id:"time_disp") do |tag|
      concat tag.div(class:"one_hour_disp")
      25.times do |time|
        concat tag.div(time.to_s+":00",class:"one_hour_disp")
      end
    end
  end

  def one_day(first_day, since)
    tag.div(class:"oneday_schedule") do |tag|
      concat tag.div(first_day.since(since.days).day.to_s + "日",class:"day_disp")
      24.times do
        concat tag.div(class:"one_hour")
      end
    end
  end
end


