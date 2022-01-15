$(function() {

  $('.group').on("click", function(){
    var name = $(this).data("name");
    var overview = $(this).data("overview");
    var group_edit = $(this).data("url");
    console.log(group_edit) 
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
    // console.log($(this).val());
    const url = new URL(location);
    // console.log(url.toString());
    // console.log(url.href);
    // console.log(url.hostname);
    // console.log(url.pathname);
    // console.log(url.protocol);
    // console.log(url.search);
    url.searchParams.set("start_at",$(this).val());
    console.log(url.toString());
    window.location.href = url;
    });    

});

