require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class Ballbyball

  attr_accessor :teams, :team1, :team2, :ball, :bowler, :batsman, :matchScore


  def initialize hash
    @details = Hashie::Mash.new(hash)
    if @details.present?
      @ballbyball = @details.ballbyball.data if @details.ballbyball.present? && @details.ballbyball.data.present?
      @cricketScore = @details.cricketScore.data if @details.cricketScore.present? && @details.cricketScore.data.present?
    end
    build_ballbyball_summary if @details.present?
  end

  private

  def build_ballbyball_summary
    @teams                = get_teams_data
    @team1                = get_team_one
    @team2                = get_team_two
    @ball                 = get_ball_data
    @batsman              = get_batsmen_data
    @bowler               = get_bowler_data
    @matchScore           = get_matchScore
    
  end

  def get_teams_data
    @ballbyball.team if @ballbyball.team.present?  
  end
  
  def get_team_one
    @ballbyball.team[0] if @ballbyball.team.present? 
  end
  
  def get_team_two
    @ballbyball.team[1] if @ballbyball.team.present? 
  end
  
  def get_ball_data
    @ballbyball.data if @ballbyball.data.present?
  end
  
  def get_batsmen_data
    if @ballbyball.data.present?
      @ballbyball.data.each do |ball|
        return ball.batsman if ball.batsman.present?
      end
    end
  end
  
  def get_bowler_data
    if @ballbyball.data.present?
      @ballbyball.data.each do |ball|
        return ball.bowler if ball.batsman.present?
      end
    end
  end
    
  def get_matchScore
    @cricketScore if @cricketScore.present?
  end
  
end

