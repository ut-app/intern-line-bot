class TrashDay

  TRASH_INFO_URL = "https://www.city.fujisawa.kanagawa.jp/kankyo-j/kurashi/gomi/shushubi/nittei/r23b.html"
  BASE_DAY_RECYCLABLE_WASTE = Date.new(2021, 1, 5).freeze
  BASE_DAY_PLASTIC_BOTTLE = Date.new(2021, 1, 8).freeze

  def self.get_trash_message
    <<~MESSAGE.chomp
      今日の収集品目：
      #{get_trash_of_today}\n
      各品目の収集日程はこちら：
      #{TRASH_INFO_URL}
    MESSAGE
  end

  def self.get_trash_of_today
    today = Time.zone.today
    case today.wday
    when 1, 4
      "可燃ごみ、ビン"
    when 2
      diff = today - BASE_DAY_RECYCLABLE_WASTE
      isEveryOtherWeek(diff) ? "資源" : "不燃ごみ、プラスチック、本、雑がみ"
    when 3
      "プラスチック、油、特定品目"
    when 5
      diff = today - BASE_DAY_PLASTIC_BOTTLE
      isEveryOtherWeek(diff) ? "ペットボトル" : "カン、なべ類"
    else
      "今日はゴミの回収はありません。"
    end
  end

  def self.isEveryOtherWeek(diff)
    diff % 14 == 0
  end
end