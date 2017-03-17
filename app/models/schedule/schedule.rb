require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class Schedule

  attr_accessor :schedule, :schedule_count


  def initialize hash
    @details = Hashie::Mash.new(hash)
    build_schedule_summary if @details.present?
  end

  private

  def build_schedule_summary
    @schedule                 = get_schedule
    @schedule_count           = get_schedule_count
  end

  def get_schedule
    @details.data.data if @details.data.present? && @details.data.data.present? 
  end
  
  def get_schedule_count
    @details.data.data.count if @details.data.present? && @details.data.data.present? 
  end

end

