require 'net/http'
require 'json'
require 'date'

date = ARGV[0]

if date == 'today'
  output = Date.today.strftime('%Y%m%d')
elsif date == 'yesterday'
  output = Date.today.prev_day.strftime('%Y%m%d')
else
  output = date
end

url = "https://data.nba.net/10s/prod/v1/#{output}/scoreboard.json"
uri = URI(url)
res = Net::HTTP.get(uri)
a = JSON.parse(res)

a.dig("games").each do |game|
  puts game['vTeam']['triCode'].to_s + '-' + game['vTeam']['score'].to_s
  puts game['hTeam']['triCode'].to_s + '-' + game['hTeam']['score'].to_s
  puts '---------------------------------------'
end