# basic info
* what for<br>
&emsp;スケジュール管理webアプリ

* attributes<br>
&emsp;ruby 3.0.2p107<br>
&emsp;Rails 6.1.4.4<br>
&emsp;rspec 




# 操作方法
## メイン画面
![image](https://user-images.githubusercontent.com/90238545/153837221-68b5f6ba-c71b-46d0-8f15-225dae9a18ef.png)
<br><br>

## グループの作成
グループの作成をクリックして下さい。<br>
モーダルが立ち上がるので、必要事項を入力し、createをクリックして下さい。
![image](https://user-images.githubusercontent.com/90238545/153837326-e707e153-6dfd-4c89-874d-ad2667eb0bba.png)


グループ一覧に新しいグループが作成されます。
![image](https://user-images.githubusercontent.com/90238545/153837667-032f9d3a-f7f6-4da8-83b1-f1c6488aceb5.png)
<br><br>

## グループ編集
グループ名をクリックすると、グループの詳細モーダルが立ち上がります。<br>
Editをクリックすると、グループeditページに遷移します。
![image](https://user-images.githubusercontent.com/90238545/153837758-dfb433cf-3eb1-45a8-a5d8-ecb3872106af.png)

グループeditページ
![image](https://user-images.githubusercontent.com/90238545/153837817-d65ebe7c-cc91-47f2-a181-7df6534c8867.png)

※グループの管理者ではない場合、グループeditページへ遷移できません。<br>
下記のようにEditボタンは表示されません。<br>代わりにQuitボタンが表示され、このボタンを押すことでグループを抜ける事ができます。
![image](https://user-images.githubusercontent.com/90238545/153837886-589fa2af-7c2f-4c65-83d6-62f4218329dd.png)
<br><br>

## 招待
誰かを招待するためには招待する人のidを知る必要があります。<br>
idを招待バーに打ち込みSearchをクリックすると、
検索されたuserが表示されます。
![image](https://user-images.githubusercontent.com/90238545/153837943-b4d5ceac-24c1-4399-83ae-7bad3eef5e71.png)


Invliteを押すと、userが招待されます。
![image](https://user-images.githubusercontent.com/90238545/153837978-cce0dc41-13bd-4378-8cf0-931420348f4b.png)
<br><br>

## 権限編集、追い出し
自分と、一般メンバーに対して強制追い出しと権限変更が可能です。<br>
また、招待中メンバーに対して強制追い出しが可能です。<br>
* to_admin:管理者へ変更<br>
* to_normal:一般メンバーへ変更<br>
* kick:強制追い出し<br>

![image](https://user-images.githubusercontent.com/90238545/153838030-f05f2b09-e364-4b8f-9996-ac0a302d430b.png)

※自分の権限変更と強制追い出しが不可能な場合があります。<br>
グループに１人以上の管理者が必要な為、管理者が自分のみの場合、権限変更と強制追い出しが出来ません。
![image](https://user-images.githubusercontent.com/90238545/153838068-9292f75d-8b37-412a-bb53-651fe1492e8a.png)
<br><br>

## グループ参加
グループリクエストをクリックして下さい。<br>
誘われているグループ一覧が表示されます。<br>
参加する場合は承認を押してresponseをクリックして下さい。

![image](https://user-images.githubusercontent.com/90238545/153838169-603abef2-7e86-47e7-870b-28b5b280fc00.png)

参加グループが追加されます。

![image](https://user-images.githubusercontent.com/90238545/153838223-2bb2d457-af99-455f-b137-37dc42cd5fc0.png)
<br><br>

## スケジュール作成
create scheduleボタンをクリックして下さい。
モーダルが立ち上がりますので、情報を入力して下さい。

![image](https://user-images.githubusercontent.com/90238545/153838274-7606d377-9c9c-4dcb-8a5a-7ffbf96d1d40.png)

スケジュールが追加されます。

![image](https://user-images.githubusercontent.com/90238545/153838315-9849c2be-ae6b-4dd4-b667-f1c4d86825b5.png)
<br><br>

## スケジュール編集
編集したいスケジュールをクリックし、edit scheduleボタンをクリックします。

![image](https://user-images.githubusercontent.com/90238545/153838381-5a363ce9-dcb8-472b-b904-e043d4dfba6d.png)


編集後updateをクリックして下さい。<br>
削除する場合、Deleteを押します。

![image](https://user-images.githubusercontent.com/90238545/153838436-c0160107-e287-4380-bec0-8e25dd6c7ce8.png)
<br><br>

## スケジュール詳細表示
画面下部分はスケジュールの詳細を表示する事ができます。<br>
家族でお出かけをクリックすると。。
![image](https://user-images.githubusercontent.com/90238545/153838510-62df0c2e-34cb-414e-a327-94a78d761dd7.png)

進捗会議をクリックすると。。
![image](https://user-images.githubusercontent.com/90238545/153838563-67aa5875-12f4-4678-b4aa-c91fd736a9bc.png)

このように表示が変わります。
<br><br>

## スケジュール表示期間変更

スケジュール表の期間を変更する事ができます。<br>
表示日時から選択して下さい。
![image](https://user-images.githubusercontent.com/90238545/153838640-f3d5deb8-5358-4c86-966f-b310d4c4291d.png)

例えば2/14をクリックすると、下記のように表示日時が変更されます。
![image](https://user-images.githubusercontent.com/90238545/153838676-43799916-cfb5-4e52-90d2-dc27fa4b38df.png)


## スケジュール表示グループ変更

グループ横のチェックボックスで、画面に表示するスケジュールの表示と非表示を切り替える事ができます。

会社の予定のみ表示したい場合、
![image](https://user-images.githubusercontent.com/90238545/153838747-2517cbe9-d30f-4cb3-8ad9-3e238db5e4fc.png)

家族の予定と、会社の予定を表示したい場合
![image](https://user-images.githubusercontent.com/90238545/153838794-1452838c-40f7-4dab-8483-3e6c79ca98c2.png)
<br><br>

## CSV出力
画面のCSV出力をクリックすると現在画面に表示されている情報をcsvで出力する事ができます。

![image](https://user-images.githubusercontent.com/90238545/153838837-9bd025d9-080c-41be-b440-bc645c99b6b1.png)
