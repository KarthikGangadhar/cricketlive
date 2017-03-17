require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class CricketController < ApplicationController
  def show      
      request = CricApi::ProfessionalProfile.new().getResponseforHome
      @news = {
        :news => request[:news],
        :count => request[:news]['data']['data'].count
      }
      @matchCalendar = request[:matchcalendar]
      @cricket = request[:cricket]
      @matches = request[:matches]
      # @liveUpdate = CricApi::ProfessionalProfile.new().getLiveUpdates(@cricket , @matches)
      @liveUpdate = CricApi::ProfessionalProfile.new().getAllScore(@cricket)
  end
end
