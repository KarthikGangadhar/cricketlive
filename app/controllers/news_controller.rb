require './lib/cricket_api/request.rb'
require 'news/news.rb'

class NewsController < ApplicationController
  def show      
      cricApires = CricApi::Request.new('https://apecricket.herokuapp.com', 0)
      @news = News.new(cricApires.getNews)
  end
end

