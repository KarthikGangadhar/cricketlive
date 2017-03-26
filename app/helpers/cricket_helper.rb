require './lib/cricket_api/request.rb'

module CricketHelper
  
  def get_team_flag(team)
      flag_url = ""
      cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
      team_flags = cricApires.jsonRead('./lib/cricket_api/json_data/team_flags.json')
      flags = Hashie::Mash.new(team_flags)
      team = team.split(' ').join('').downcase
      
      flags.teams.each do |flag|
        team_name = flag.split('.jpg').join('').downcase
        if team_name == team
          flag_url = TEAM_FLAGS_PATH + flag
          break;
        end
      end
      
      flag_url = DEFAULT_TEAM_FLAGS_PATH if flag_url.blank?
      
      return flag_url
  end
  
end
