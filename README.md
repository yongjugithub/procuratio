# 勤怠管理システム Procuratio
# Description
管理者は従業員の勤怠を管理するアプリ
従業員は勤務毎に勤務状況に対し、0~10の評価ポイントが与えられる。
評価結果は勤怠データベースに保存させる

# Requirements
- ruby '2.6.3'
- Rails 6系
- git はdevelopブランチで運用
- タイムゾーンは日本時間
- AWSで運用予定のため、datebaseは全ての開発環境でmysqlを採用する
- git add&commit 時に、rubocop を使用して常にgreenな状態に戻れるようにする
- テストはRspec
- デザインはbootstrap

# DB設計
employee [employee_id,name,admin,password_digest]
attendance [employee_id,もろもろの評価項目,point]

Association(モデルの関連)
employee
	|
has_many
attendances

# Note
ユーザー登録
employee_idとpasword
による認証方法。
employee_idに一意性を確保する

アクセス権限
入力者（通常職員）は変化するため、管理者権限を付与、剥奪可能にする必要がある。
従業員モデルが管理者権限をもつことにする（admin属性）

認可モデル
管理者ユーザー(admin_employee)のみが他の従業員の
[new,show,edit,destroy]が認可される

従業員のポイントを入力する画面が存在する（カメラチェック)
評価項目は１０個（項目名、数は変更の可能性あり）

# Author
Ji Yongju
