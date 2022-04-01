# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# whenever 定期実行
#  rake 'ファイル名':タスク名'
# Rails.root(Railsメソッド)を使用するために必要
require File.expand_path(File.dirname(__FILE__) + '/environment')

# .zshrcとrbenvのパスを指定するrakeを定義
job_type :rake, "source /Users/docha/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

# cronを実行する環境変数(:development, :product, :test)
# 環境変数'RAILS_ENV'にセットされている変数またはdevelopmentを指定
# 自分の環境では'RAILS_ENV'はセットされていないのでnilです
rails_env = ENV['RAILS_ENV'] || :development

# cronを実行する環境変数をセット
# 今回はdevelopmentをセット
set :environment, rails_env

# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

every 1.day, :at => '12:00' do
  rake 'sitemap:refresh'
end
