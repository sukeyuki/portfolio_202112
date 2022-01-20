class ApplicationController < ActionController::Base
  require 'date'
  require 'time'


  def overlap_calc(arr,i)
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
  
    if same_start_list.min&.< i
      same_start_list.min
      same_start_list << i
      return overlap_calc(arr, same_start_list.min) + same_start_list.sort!.index(i)
    end
  
    if flag_id==[]
      return 1
    end
  
    pm_list = []
    flag_id.each do |id|
      pm_list << overlap_calc(arr,id)
    end
    att=(1..20).to_a
    pm_list.each do |pm|
      att.delete(pm)
    end
    return att.min
  end
  
end
