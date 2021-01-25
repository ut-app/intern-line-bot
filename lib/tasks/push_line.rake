namespace :push_line do
  desc "LINEBOT：今日のゴミ出し品目" 
  task push_line_message_trash: :environment do
    puts "push_lineが実行されました"
    message = {
      type: 'text',
      text: TrashDay.get_trash_message()
    }
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
    User.all.each do |user|
      client.push_message(user.user_id, message)
    end
  end
end
