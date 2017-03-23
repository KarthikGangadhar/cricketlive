require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class Schedule

  attr_accessor :schedule, :schedule_count, :teams_schedule, :teams, :schedule_by_month


  def initialize hash
    @details = Hashie::Mash.new(hash)
    build_schedule_summary if @details.present?
  end

  private

  def build_schedule_summary
    @schedule                 = get_schedule
    @schedule_count           = get_schedule_count
    @teams_schedule           = get_schedule_by_teams
    @teams                    = teamslist
    @schedule_by_month        = get_schedule_by_month
  end

  def get_schedule
    @details.data.data if @details.data.present? && @details.data.data.present? 
  end
  
  def get_schedule_count
    @details.data.data.count if @details.data.present? && @details.data.data.present? 
  end
  
  def teamslist
    teams = [
      "Afghanistan",
      "Australia",
      "Bangladesh",
      "England",
      "India",
      "Ireland",
      "New_Zealand",
      "Pakistan",
      "Sri_Lanka",
      "South_Africa",
      "West_Indies"
      ]
  end
  
  def get_schedule_by_teams
    schedule = get_schedule
    teams = teamslist
    
    team_schedule = { 
      "Afghanistan" => [],
      "Australia" => [],
      "Bangladesh" => [],
      "England" => [],
      "India" => [],
      "Ireland" => [],
      "New_Zealand" => [],
      "Pakistan" => [],
      "Sri_Lanka" => [],
      "South_Africa" => [],
      "West_Indies" => []
      } 
      
    if schedule.present? && teams.present?
      schedule.each do |sch|
        if sch.present? && sch.name.present?
          fst_split = sch.name.split(' at ')
          scd_split = fst_split[0].split(' v ')
          
          scd_split.each do |split_team|
            split_team = split_team.split(" ").join("_")
            teams.each do |team|
              if team == split_team
                team_schedule[split_team].push(sch)
                break;
              end
            end
          end
        end
      end
    end
    
    return Hashie::Mash.new(team_schedule)  
  end
  
  def get_schedule_by_month
    schedule = get_schedule
    schedule_by_month = {} 
     
    if schedule.present? && teams.present?
      schedule.each do |sch|
        if sch.present? && sch.date.present?
          date = sch.date.split(' ')
          if date.length == 3
            schedule_by_month[date[2]] = {} if schedule_by_month[date[2]].blank?
            schedule_by_month[date[2]][date[1]] = [] if schedule_by_month[date[2]][date[1]].blank?          
            schedule_by_month[date[2]][date[1]].push(sch)  
          end
        end
      end
    end
    
    return Hashie::Mash.new(schedule_by_month)  
  end
  
end

