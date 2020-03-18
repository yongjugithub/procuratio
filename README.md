従業員評価管理システム
概要：
従業員は勤務毎に勤務状況に対し、0~10の評価ポイントが与えられる。
それをWEB上から操作できるようにする

アクセス権限
管理者権限を持った従業員のみ。
従業員のポイントを入力する画面が存在する（カメラチェック)
評価項目は１０個（項目名、数は変更の可能性あり）

DB設計
:employee [employee_id,name,admin(:boolean , default: false)]
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
