# basic info
* what for<br>
&emsp;スケジュール管理webアプリ

* attributes<br>
&emsp;ruby 3.0.2p107<br>
&emsp;Rails 6.1.4.4<br>
&emsp;rspec 




# 操作方法
## メイン画面
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153842809-9fb34350-ed49-4405-be0e-db4e2f4ad2ff.png">


<br><br>

## グループの作成
グループの作成をクリックして下さい。<br>
モーダルが立ち上がるので、必要事項を入力し、createをクリックして下さい。
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153843095-1c55bc9e-8938-4baf-bc57-b8fa462d6ecb.png">



グループ一覧に新しいグループが作成されます。
![image](https://user-images.githubusercontent.com/90238545/153843289-86f9d6f9-852c-4d78-81ff-2024db86782d.png)
<br><br>

## グループ編集
グループ名をクリックすると、グループの詳細モーダルが立ち上がります。<br>
Editをクリックすると、グループeditページに遷移します。
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153843834-c2ff5808-e22e-4e61-a2e1-80c9c5df86b4.png">


グループeditページ
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153843933-22767835-2810-4e5c-9ac1-129d9993329e.png">



※グループの管理者ではない場合、グループeditページへ遷移できません。<br>
下記のようにEditボタンは表示されません。<br>代わりにQuitボタンが表示され、このボタンを押すことでグループを抜ける事ができます。
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153843669-11b9e07d-6fd2-489b-ac46-7b739500184b.png">
<br><br>

## 招待
誰かを招待するためには招待する人のidを知る必要があります。<br>
idを招待バーに打ち込みSearchをクリックすると、
検索されたuserが表示されます。
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153844077-a4d7996f-8ae1-4fd2-bf01-11d7570fc19d.png">



Invliteを押すと、userが招待されます。
![image](https://user-images.githubusercontent.com/90238545/153844312-90ffcd3f-30e3-4f43-994d-e4ebb2cc3fa1.png)

<br><br>

## 権限編集、追い出し
自分と、一般メンバーに対して強制追い出しと権限変更が可能です。<br>
また、招待中メンバーに対して強制追い出しが可能です。<br>
* to_admin:管理者へ変更<br>
* to_normal:一般メンバーへ変更<br>
* kick:強制追い出し<br>

<img width="1439" alt="image" src="https://user-images.githubusercontent.com/90238545/153844413-abc33806-5331-4989-9e7c-4d5d3a76a0bb.png">

※自分の権限変更と強制追い出しが不可能な場合があります。<br>
グループに１人以上の管理者が必要な為、管理者が自分のみの場合、権限変更と強制追い出しが出来ません。
![image](https://user-images.githubusercontent.com/90238545/153844701-00373ad8-65c0-4b94-8ed3-c3f4f2a228be.png)
<br><br>

## グループ参加
グループリクエストをクリックして下さい。<br>
誘われているグループ一覧が表示されます。<br>
参加する場合は承認を押してresponseをクリックして下さい。
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153844926-b8eaa8b1-372e-4657-9e71-d428681fc736.png">


参加グループが追加されます。

![image](https://user-images.githubusercontent.com/90238545/153845109-67bbf8f5-4031-45c0-b52c-bdf9f4585be1.png)

<br><br>

## スケジュール作成
create scheduleボタンをクリックして下さい。
モーダルが立ち上がりますので、情報を入力して下さい。

![image](https://user-images.githubusercontent.com/90238545/153838274-7606d377-9c9c-4dcb-8a5a-7ffbf96d1d40.png)

スケジュールが追加されます。

![image](https://user-images.githubusercontent.com/90238545/153845463-050577d1-0be5-45cd-a7a4-a5056f70d8c6.png)

<br><br>

## スケジュール編集
編集したいスケジュールをクリックし、edit scheduleボタンをクリックします。

![image](https://user-images.githubusercontent.com/90238545/153845631-364efe4d-0646-4ae8-a9c7-ac4b25f75353.png)


編集後updateをクリックして下さい。<br>
削除する場合、Deleteを押します。

<img width="1439" alt="image" src="https://user-images.githubusercontent.com/90238545/153845760-609d6b4b-c7c3-4c5b-96cb-da0877fb4a21.png">

<br><br>

## スケジュール詳細表示
画面下部分はスケジュールの詳細を表示する事ができます。<br>
家族でお出かけをクリックすると。。
![image](https://user-images.githubusercontent.com/90238545/153838510-62df0c2e-34cb-414e-a327-94a78d761dd7.png)

進捗会議をクリックすると。。
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153845899-f3d614df-0652-406a-94f4-632c5c42311c.png">

このように表示が変わります。
<br><br>

## スケジュール表示期間変更

スケジュール表の期間を変更する事ができます。<br>
表示日時から選択して下さい。
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153846009-4d53ff6b-4d05-4807-b9d6-d26376a37bf7.png">


例えば2/7をクリックすると、下記のように表示日時が変更されます。
<img width="1439" alt="image" src="https://user-images.githubusercontent.com/90238545/153846204-a736f714-c521-4f71-9591-f286e80ad914.png">


## スケジュール表示グループ変更

グループ横のチェックボックスで、画面に表示するスケジュールの表示と非表示を切り替える事ができます。

会社の予定のみ表示したい場合、
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153846311-1f35beb1-239b-4520-b534-e90b8cfc8194.png">

家族の予定と、会社の予定を表示したい場合
<img width="1440" alt="image" src="https://user-images.githubusercontent.com/90238545/153846392-eb7a0ec6-94e4-4e21-9100-5f56fb9a62e3.png">

<br><br>

## CSV出力
画面のCSV出力をクリックすると現在画面に表示されている情報をcsvで出力する事ができます。

![image](https://user-images.githubusercontent.com/90238545/153846591-74d7fd2f-9909-4623-999d-9146d3b96381.png)
