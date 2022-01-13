$(function() {



  $('.group').on("click", function(){
    var name = $(this).data("name");
    var overview = $(this).data("overview");
    // var users = $(this).data("users");
    var group_edit = $(this).data("url");
    console.log(group_edit) 
    // console.log(name);
    // console.log(overview);
    $("#group-name").text(name);
    $("#group-overview").text(overview);
    $("#edit-button").attr(
      'onclick', 'location.href=\''+group_edit+'\''
    );

  });


  // グループ表示の方法が未定のため保留
  $('.show-group').on('click',function(){
    $(this).attr(
      'checkbox', 'checked'
    )
    window.location.href='http://localhost:3000/'
    // $.post('http://localhost:3000/', "aaa")
  });

  $('#schedule_start_at').on('click', function(){
  });

  $('#schedule_start_at').on('click',function(){


    window.location.href='http://localhost:3000/schedules'
  
    });



});

