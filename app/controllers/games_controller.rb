class GamesController < ApplicationController
  require './config/categories' 

  def index
    sort_by = params[:sort_by]
    @category = params[:category] 

    client = FreeToGameClient.new

    if sort_by.present?
      @games = client.games_by_sort(sort_by)  
    elsif @category.present?
      @games = client.games_by_category(@category) 
    else
      @games = client.games 
    end

  rescue => e
    Rails.logger.error "An error occurred while fetching games: #{e.message}"
    flash[:error] = "An error occurred while fetching games. Please try again later."
    @games = []
    end
end
