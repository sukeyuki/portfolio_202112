class ApplicationController < ActionController::Base
  require 'date'
  require 'time'


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
      arr = []
      arr << index
      se_ar.each_with_index do |ar,i|
        unless i == index
          if se_ar[index][0]<=ar[1] and se_ar[index][1]>=ar[0]
            arr << i
          end
        end
      end
      return arr
    end
  
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

  # def overlap_calc(arr,i)
  #   flag_id = []
  #   same_start_list = []
  #   arr.each.with_index do |ele, index|
  #     unless  index == i
  #       if arr[i][0]== ele[0]
  #         same_start_list << index
  #       end
  #       if arr[i][0]>ele[0] and arr[i][0]<ele[1] 
  #         flag_id << index
  #       end
  #     end
  #   end
  
  #   if same_start_list.min&.< i
  #     same_start_list.min
  #     same_start_list << i
  #     return overlap_calc(arr, same_start_list.min) + same_start_list.sort!.index(i)
  #   end
  
  #   if flag_id==[]
  #     return 1
  #   end
  
  #   pm_list = []
  #   flag_id.each do |id|
  #     pm_list << overlap_calc(arr,id)
  #   end
  #   att=(1..20).to_a
  #   pm_list.each do |pm|
  #     att.delete(pm)
  #   end
  #   return att.min
  # end
  
end
