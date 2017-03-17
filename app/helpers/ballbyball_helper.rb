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
    binding.pry
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
  
end