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
  away = game['vTeam']
  home = game['hTeam']
  puts 'Tipoff: ' + game['startTimeEastern']
  puts away['triCode'].to_s + '-' + away['score'].to_s + "#{'*' if away['score'].to_i > home['score'].to_i}"
  puts home['triCode'].to_s + '-' + home['score'].to_s + "#{'*' if home['score'].to_i > away['score'].to_i}"
  puts '---------------------------------------'
end
