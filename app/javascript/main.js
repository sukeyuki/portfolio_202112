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

  $('.show-group').on('click',function(){
    const url = new URL(location);
    $('.show-group').each(function(index, element){
      url.searchParams.delete($(element).attr('id'));
      if($(element).prop('checked')){
        url.searchParams.set($(element).attr('id'), "checked")
      };
    });
    window.location.href = url;


  });

  $('#schedule_start_at').on('change',function(){
    const url = new URL(location);
    url.searchParams.set("start_at",$(this).val());
    console.log(url.toString());
    window.location.href = url;
  });

  $('.schedule_block').on('click',function(){
    var title = $(this).data("title");
    var contents = "内容:"+$(this).data("contents");
    var users = "参加者:"+$(this).data("users");
    var start_at_disp = 'from:'+$(this).data("start-at");
    var end_at_disp = 'to:'+$(this).data("end-at");
    $("#schedule_overview_title").text(title);
    $("#schedule_overview_contents").text(contents);
    $("#schedule_overview_users").text(users);
    $("#schedule_overview_start_at").text(start_at_disp);
    $("#schedule_overview_end_at").text(end_at_disp);
  });


    // $('.schedule_block').each(function(index, element){
    //   var start_at = $(element).data("start-at")
    //   var end_at = $(element).data("end-at")
    //   console.log(start_at)
    //   console.log(end_at)

      // $(element).css({
      //   'top':'40px',
      //   'left':'50px'
      // });
    // });
});

