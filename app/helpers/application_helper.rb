module ApplicationHelper
  # 属性がtrueのときのみ"◯"を表示する
  def display_circle(attr)
    if attr.present?
      return '◯'
    else
      return '×'
    end
  end
end
