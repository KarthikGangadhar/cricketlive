module PlayerstatHelper
  
  
  def getTeamFlag(teamname)
    flag_url = ""
    base_url = "http://cdn.cricapi.com/country/Flag%20Of%20"
    flag_url = "#{base_url}#{teamname}.png"  
    return flag_url
  end
  
end
