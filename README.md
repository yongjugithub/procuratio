従業員評価管理システム
概要：
従業員は勤務毎に勤務状況に対し、0~10の評価ポイントが与えられる。
それをWEB上から操作できるようにする

ユーザー登録
employee_idとpasword
による認証方法。
employee_idに一意性をもたせて安全性を確保する

アクセス権限
入力者（通常職員）は変化するため、管理者権限を付与、剥奪可能にする必要がある。
従業員が管理者権限をもつことにする（admin属性）

従業員のポイントを入力する画面が存在する（カメラチェック)
評価項目は１０個（項目名、数は変更の可能性あり）

DB設計
:employee [employee_id,name,admin]
:attendance [employee_id,もろもろの評価項目,point]

employee
	|
has_many
attendances

その他仕様
ruby '2.6.3'
Rails 6系
git はdevelopブランチで運用
タイムゾーンは日本時間
AWSで運用予定のため、datebaseは全ての開発環境でmysqlを採用する
rubocop を使用して品質を保つ
https://github.com/rubocop-hq/rubocop-rails
テストはRspec
デザインはbootstrap
