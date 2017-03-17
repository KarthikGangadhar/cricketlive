require './lib/cricket_api/request.rb'
require 'cricapi_response.rb'

class News

  attr_accessor :news, :news_count


  def initialize hash
    @details = Hashie::Mash.new(hash)
    build_news_summary if @details.present?
  end

  private

  def build_news_summary
    @news                 = get_news
    @news_count           = get_news_count
  end

  def get_news
    @details.data.data if @details.data.present? && @details.data.data.present? 
  end
  
  def get_news_count
    @details.data.data.count if @details.data.present? && @details.data.data.present? 
  end

end

