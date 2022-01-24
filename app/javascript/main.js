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
    var start_at_disp = $(this).data("start-at");
    var end_at_disp = $(this).data("end-at");
    var id = $(this).data("id");
    var group = $(this).data("group");
    $("#schedule_overview_title").text(title);
    $("#schedule_overview_contents").text("内容:"+content);
    $("#schedule_overview_users").text("参加者:"+users);
    $("#schedule_overview_start_at").text("from:"+start_at_disp);
    $("#schedule_overview_end_at").text("to:"+end_at_disp);
    $("#schedule_overview_group").text("グループ:"+group);
    

    $("#schedule_edit").data("title",title);
    $("#schedule_edit").data("content",content);
    $("#schedule_edit").data("start_at",start_at_disp);
    $("#schedule_edit").data("end_at",end_at_disp);
    $("#schedule_edit").data("id",id);
    $("#schedule_edit").data("group",group);
    $("#schedule_edit").css("display", "block");
  });

  $("#schedule_edit").on('click',function(){
    $("#update_schedule_title").attr("value", $(this).data("title"));
    var start_at = $(this).data("start_at").split(" ");
    var end_at = $(this).data("end_at").split(" ");
    $("#update_schedule_start").attr("value", start_at[0]+"T"+start_at[1]);
    $("#update_schedule_end").attr("value", end_at[0]+"T"+end_at[1]);
    $("#update_schedule_content").text($(this).data("content"));
    $("#schedule_update_group").text($(this).data("group"));
    var id = $(this).data("id");
    $("#update_schedule_form").attr("action", "/schedules/"+id);
    var url = new URL(location);
    $("#schedule-delete").attr('href', url["origin"]+"/schedules/"+id);
  });

  $(".users_hide").each(function(index, element){
    // console.log($(element).data("users_count"));
    if ($(element).data("users_count")==1){
      $(element).css("display","none");
    };
  });
});

