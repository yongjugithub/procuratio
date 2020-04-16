module ApplicationHelper
  # 属性がtrueのときのみ"◯"を表示する
  def display_circle(attr)
    if attr.present?
      return '◯'
    else
      return '×'
    end
  end

  # 時間を指定した方法で表示する
  def display_JPtime(time)
    if time.present?
      return time.strftime('%m/%d-%H:%M')
    end
  end
end
