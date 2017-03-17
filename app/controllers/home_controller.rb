require './lib/cricket_api/request.rb'

class HomeController < ApplicationController
  def show
    cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
    isOffline = true
    if !isOffline
      @cricket = cricApires.cricket
      @matchCalendar = cricApires.matchCalendar
      @playerStats = cricApires.playerStats(35320)
      @commentry = cricApires.commentry(1034821)
      @news = cricApires.getNews
      @ballbyball = cricApires.ballByball(1034823)
      # @match_ids = cricApires.match_ids
      # @match_response = cricApires.match_response(@match_ids)
    else
      @cricket = cricApires.jsonRead('./lib/cricket_api/json_data/cricket.json')
      @matchCalendar = cricApires.jsonRead('./lib/cricket_api/json_data/schedule.json')
      @playerStats = cricApires.jsonRead('./lib/cricket_api/json_data/playerStat.json')
      @commentry = cricApires.jsonRead('./lib/cricket_api/json_data/commentary.json')
      @news = cricApires.jsonRead('./lib/cricket_api/json_data/news.json')
      @ballbyball = cricApires.jsonRead('./lib/cricket_api/json_data/ballbyball.json')
      # @match_ids = cricApires.match_ids
      # @match_response = cricApires.match_response(@match_ids)
    end
  end
end
