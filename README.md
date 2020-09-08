# 勤怠管理システム Procuratio
# Description
- 現状: 従業員の毎勤務ごとにドライブレコーダーから勤務態度を記録している
- 概要: この業務をwebシステム化し管理するするのが目的

# ログインについて
- 従業員ID:  1
- パスワード: admin

# Requirements
- Ruby 2系
- Rails 6系
- データベースは開発、本番環境共にMYSQL
- テストフレームワーク:Rspec
- デザインフレームワーク:bootstrap

# Docker
- docker環境構築参照URL
- https://docs.docker.com/compose/rails/
- イメージからコンテナをビルドし、以下のコマンド等が使用できる
```
- docker-compose build
- docker-compose up
- docker-compose exec web rspec
- docker-compose exec web rubocop
```

# development policy
- gitの開発ブランチで開発をおこなう
- git diff --stat, add&commit 時にはrubocop,rspecが常にgreenかyelloの状態に戻れるようにする
- 開発ブランチからmasterブランチへPRををだすことで目視でも確認する
- masterブランチが開発ブランチをmargeし、masterブランチを本番環境へデプロイ

# DATABASE
- 従業員テーブルと勤怠テーブルが存在する
- employee [employee_id,name,admin,password_digest]
- attendance [employee_id,評価項目12ほど(評価基準の変更の可能性あり),point]

- Association(モデルの関連)
- 従業員テーブルが複数の勤怠モデルを持っている

# Note
- employee_idに一意性をもたせユーザー登録

- seedデータとして以下のユーザーを持たせる
初期ユーザー
admin user(admin:true,password:"admin",password_confirmation:"admin")

- 認証(authentication)
ログインは
employee_idとpasword
による認証方法。

- 認可 (authorization)
管理者権限、管理者ユーザーと一般ユーザーの存在
管理者ユーザー(admin_employee)が他のユーザーのページにアクセス可能にする

- 勤怠テーブル
入力はカメラチェックの評価を入力する形にする
評価項目は１０個ほど

# Author
Ji Yongju
