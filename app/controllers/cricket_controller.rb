require './lib/cricket_api/request.rb'
require 'news/news.rb'
require 'livescore/livescore.rb'
require 'cricapi_response.rb'

class CricketController < ApplicationController
  def show      
      request = CricApi::ProfessionalProfile.new().getResponseforHome
      @news = News.new(request[:news])
      @matchCalendar = request[:matchcalendar]
      @matches = request[:matches]
      @cricket = Hashie::Mash.new(request[:cricket]) if request[:cricket].present? 
      if @cricket.present?
        match_ids = @cricket.data.data.map(&:unique_id) if @cricket.data.present? && @cricket.data.data.present? 
        livescores = CricApi::ProfessionalProfile.new().getAllScore(@cricket) 
        livescores[:match_id] = match_ids 
        match_update = LiveScore.new(livescores)  
        @liveUpdate = match_update.livescores
      end
  end
end
