require './lib/cricket_api/request.rb'

class ScheduleController < ApplicationController
  def show
    cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
    @matchCalendar = cricApires.matchCalendar
  end
end

