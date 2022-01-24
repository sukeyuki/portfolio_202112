$(function() {
  $('.group').on("click", function(){
    var name = $(this).data("name");
    var overview = $(this).data("overview");
    var group_edit = $(this).data("url");
    $("#group-name").text(name);
    $("#group-overview").text(overview);
    $("#edit-button").attr(
      'onclick', 'location.href=\''+group_edit+'\''
    );
  });

  $('.group-checkbox').on('click',function(){
    const url = new URL(location);
    $('.group-checkbox').each(function(index, element){
      url.searchParams.delete($(element).attr('id'));
      if($(element).prop('checked')){
        url.searchParams.set($(element).attr('id'), "checked")
      };
    });
    window.location.href = url;
  });

  $('#display_start_at').on('change',function(){
    const url = new URL(location);
    url.searchParams.set("start_at",$(this).val());
    console.log(url.toString());
    window.location.href = url;
  });

  $('.schedule_block').on('click',function(){
    var title = $(this).data("title");
    var content = $(this).data("content");
    var users = $(this).data("users");
    var start_at = $(this).data("start-at");
    var end_at = $(this).data("end-at");
    var id = $(this).data("id");
    var group = $(this).data("group");
    start_at_arr  = start_at.split(" ");
    start_at_ymd  = start_at_arr[0].split("-");
    start_at_hms  = start_at_arr[1].split(":");
    end_at_arr    = end_at.split(" ");
    end_at_ymd    = end_at_arr[0].split("-");
    end_at_hms    = end_at_arr[1].split(":");
    // console.log(start_at_arr[1])
    $("#schedule_overview_title").text(title);
    $("#schedule_overview_contents").text("内容:"+content);
    $("#schedule_overview_users").text("参加者:"+users);

    if (start_at_ymd[2]!=end_at_ymd[2]){
      $("#schedule_overview_period").text(start_at_ymd[0]+'年 '+start_at_ymd[1]+"月 "+start_at_ymd[2]+"日 "+start_at_hms[0]+":"+start_at_hms[1]+"〜"+end_at_ymd[0]+"年 "+end_at_ymd[1]+"月 "+end_at_ymd[2]+"日 "+end_at_hms[0]+":"+end_at_hms[1]);      
    }else{
      $("#schedule_overview_period").text(start_at_ymd[0]+'年 '+start_at_ymd[1]+"月 "+start_at_ymd[2]+"日 "+start_at_hms[0]+":"+start_at_hms[1]+"〜"+end_at_hms[0]+":"+end_at_hms[1]);      
    };
    $("#schedule_overview_group").text("グループ:"+group);
    
    $("#schedule_edit").data("title",title);
    $("#schedule_edit").data("content",content);
    $("#schedule_edit").data("start_at",start_at);
    $("#schedule_edit").data("end_at",end_at);
    $("#schedule_edit").data("id",id);
    $("#schedule_edit").data("group",group);
    $("#schedule_edit").css("display", "block");
  });

  $("#schedule_edit").on('click',function(){
    $("#update_schedule_title").attr("value", $(this).data("title"));
    var start_at_arr = $(this).data("start_at").split(" ");
    var end_at_arr = $(this).data("end_at").split(" ");
    $("#update_schedule_start").attr("value", start_at_arr[0]+"T"+start_at_arr[1]);
    $("#update_schedule_end").attr("value", end_at_arr[0]+"T"+end_at_arr[1]);
    $("#update_schedule_content").text($(this).data("content"));
    $("#schedule_update_group").text($(this).data("group"));
    var id = $(this).data("id");
    $("#update_schedule_form").attr("action", "/schedules/"+id);
    var url = new URL(location);
    $("#schedule-delete").attr('href', url["origin"]+"/schedules/"+id);
  });

  $(".users_hide").each(function(index, element){
    if ($(element).data("users_count")==1){
      $(element).css("display","none");
    };
  });
  var color_arr = ["#fabea7", "#e1eec1", "#aeb5dc", "#fcc9ac", "#c3dcbe", "#b7aed6", "#ffe0b6", "#bad41d1", "#c5b2d6", "#fffac2", "#b4c1d1", "#e5b7be"]
  $('.schedule_block').each(function(index, element){
  console.log($(element).data("group_index"));
  console.log(color_arr[index%12]);
  index = $(element).data("group_index");
  color = color_arr[index%12]
  $(this).css(
    // "background-color", "#fabea7"

    "background-color", color
  );

  });
});

