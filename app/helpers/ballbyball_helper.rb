require 'net/http'

module BallbyballHelper
  
  def getPlayerName(teams, pid)
    player_name = ""
    teams.each do |team|
      team['player'].each do |player|
        if (player['player_id'] == pid || player['object_id'] == pid )
          player_name = player['known_as']
        end
      end
    end
    return player_name

  end
  
  def getTeamName(teams, tid)

    team_name = ""
    teams.each do |team|
        if team['team_id'] == tid
          team_name = team['team_filename']
        end
    end
    return team_name

  end
  
  def getPlayerForOverUpdate(teams, pid)
    player_name = ""
    teams.each do |team|
      team['player'].each do |player|
        if (player['player_id'] == pid || player['object_id'] == pid )
          player_name = player['card_short']
        end
      end
    end
    return player_name

  end
  
  def getPlayerUrl(pid) 
    image_url = PLAYER_URL + pid.to_s + ".jpg"
    url = URI.parse(image_url)
    req = Net::HTTP::Get.new(url.request_uri)
    res = Net::HTTP.start(url.host, url.port, 
        :use_ssl => url.scheme == 'https') {|http| 
          http.request req
        }
        
    if res.code  != "200"
      image_url = NO_PLAYER_URL
    end
    
    return image_url
  end
  
  def getPlayerStatUrl(pid) 
    player_stat_url = PLAYER_STAT_URL + pid
  end
end