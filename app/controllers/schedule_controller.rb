require './lib/cricket_api/request.rb'
require 'schedule/schedule.rb'

class ScheduleController < ApplicationController
  def show
    cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
    @matchCalendar = Schedule.new(cricApires.matchCalendar)
  end
end

