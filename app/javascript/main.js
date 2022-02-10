$(function() {
  // グループ名クリック処理
  $('.group').on("click", function(){
    // グループの詳細をモーダルに渡す
    var name = $(this).data("name");
    var overview = $(this).data("overview");
    var group_edit = $(this).data("url");
    var admin_users = $(this).data("admin_users")
    var normal_users = $(this).data("normal_users")
    var my_role = $(this).data("my_role")
    var my_group_user_id = $(this).data("my_group_user_id")
    var personal_bool = $(this).data("personal_bool")
    $("#group-name").text(name);
    $("#group-overview").text(overview);
    $("#group-admin-users").text(admin_users);
    $("#group-normal-users").text(normal_users);
    $("#edit-button").attr(
      'onclick', 'location.href=\''+group_edit+'\''
    );

    //current_userによって#create_group_modalのボタン表示と、参加user表示を切り替える。
    var url = new URL(location);
    $("#quit-button").attr('href', url["origin"]+"/group_users/"+my_group_user_id);
    if (my_role=="admin"){
      //adminはeditボタン
      $("#edit-button").css("display","block")
      $("#quit-button").css("display","none")
      $("#group-overview-users-info").css("display","block")
    }else{
      //normalはquitボタン
      $("#edit-button").css("display","none")
      $("#quit-button").css("display","block")
      $("#group-overview-users-info").css("display","block")
    }
    if (personal_bool==true){
      //personal_groupの場合はボタン表示無し。参加user表示も無し。
      $("#edit-button").css("display","none")
      $("#quit-button").css("display","none")
      $("#group-overview-users-info").css("display","none")
    }
  });

  // グループ表示用チェックボックスクリック処理
  $('.group-checkbox').on('click',function(){
    const url = new URL(location);
    url.searchParams.delete("checkbox");
    checkbox = []
    $('.group-checkbox').each(function(index, element){
      if($(element).prop('checked')){
        id = $(element).attr("id").split("-")[0];
        checkbox.push(id);
      };
    });
    // チェックされているグループのidをクエリメッセージとしてリクエスト送信
    // リダイレクト処理用にcheckbox_searchにtrueを代入。checkbox_search=trueの場合、他ページからのリダイレクトではなく、クエリメッセージと判断可能。
    url.searchParams.set("checkbox_search", true);
    url.searchParams.set("checkbox", checkbox);
    window.location.href = url;
  });

  // スケジュール表開始日選択処理
  $('#display_start_at').on('change',function(){
    const url = new URL(location);
    // 選択された日付をクエリメッセージとしてリクエスト送信
    // リダイレクト処理用にfirst_day_searchにtrueを代入。first_day_search=trueの場合、他ページからのリダイレクトではなく、クエリメッセージと判断可能。
    url.searchParams.set("first_day_search", true);
    url.searchParams.set("start_at",$(this).val());
    window.location.href = url;
  });

  // スケジュールブロッククリック処理
  $('.schedule_block').on('click',function(){
    // スケジュールの詳細を　schedule detailに渡し表示させる。
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
    $("#schedule_overview_title").text(title);
    $("#schedule_overview_contents").text("内容:"+content);
    $("#schedule_overview_users").text("参加者:"+users);
    $("#schedule_overview_group").text("グループ:"+group);

    // スケジュールが日を跨ぐ場合とそうでない場合で表示を切り替える。
    // ex) 
    // 2022年 02月 03日 18:00〜2022年 02月 04日 18:00
    // 2022年 02月 03日 18:00〜21:00
    if (start_at_ymd[2]!=end_at_ymd[2]){
      $("#schedule_overview_period").text(start_at_ymd[0]+'年 '+start_at_ymd[1]+"月 "+start_at_ymd[2]+"日 "+start_at_hms[0]+":"+start_at_hms[1]+"〜"+end_at_ymd[0]+"年 "+end_at_ymd[1]+"月 "+end_at_ymd[2]+"日 "+end_at_hms[0]+":"+end_at_hms[1]);      
    }else{
      $("#schedule_overview_period").text(start_at_ymd[0]+'年 '+start_at_ymd[1]+"月 "+start_at_ymd[2]+"日 "+start_at_hms[0]+":"+start_at_hms[1]+"〜"+end_at_hms[0]+":"+end_at_hms[1]);      
    };
    

    // #update_schedule_modalにスケジュールの詳細を反映させる。
    // schedule editボタンをクリックする事で、スケジュールの詳細が代入されたmordalで編集可能となる。
    $("#update_schedule_title").val(title);
    $("#update_schedule_content").val(content);
    var url = new URL(location);
    $("#schedule-delete").attr('href', url["origin"]+"/schedules/"+id);
    $("#update_schedule_form").attr("action", "/schedules/"+id);
    $("#schedule_update_group").text(group);

    var start_at_arr = start_at.split(" ");
    var end_at_arr = end_at.split(" ");
    $("#update_schedule_start").attr("value", start_at_arr[0]+"T"+start_at_arr[1]);
    $("#update_schedule_end").attr("value", end_at_arr[0]+"T"+end_at_arr[1]);

    // edit scheduleボタンを表示させる。
    $("#schedule_edit").css("display", "block");
  });

  // edit scheduleボタンクリック処理
  $("#schedule_edit").on('click',function(){
    // エラーを非表示にする。エラーは発生時にajaxで表示する。
    $("#errors_of_update_schedule").text(" ")
  });


  // "＜"クリック処理。userが一人の場合は表示しない。
  $(".users_hide").each(function(index, element){
    if ($(element).data("users_count")==1){
      $(element).css("display","none");
    };
  });

  // スケジュールブロックのグループ色分け処理
  // 表示順で色を固定
  var color_arr = ["#fabea7", "#e1eec1", "#aeb5dc", "#ffe0b6", "#bad4d1", "#c5b2d6", "#fffac2", "#b4c1d1", "#e5b7be"]
  $('.schedule_block').each(function(index, element){
    index = $(element).data("group_index");
    color = color_arr[index%9]
    $(this).css(
      "background-color", color
    );
  });

  // create_scheduleをクリックした際に、エラー表示を削除する。エラーは発生時にajaxで表示する。
  $("#create_schedule").on('click',function(){
    $("#errors_of_create_schedule").text(" ");
  });

  // create_groupをクリックした際に、エラー表示を削除する。エラーは発生時にajaxで表示する。
  $("#create_group").on('click',function(){
    $("#errors_of_create_group").text(" ");
  });
});