require 'faraday'
require 'json'

class FreeToGameClient
  BASE_URL = "https://www.freetogame.com/api".freeze

  def games
    request(
      http_method: :get, 
      endpoint: "/games"
      )
  end

  def games_by_category(category)
    request(
      http_method: :get, 
      endpoint: "/games", 
      params: { category: category }
      )
  end
  
  def games_by_sort(sort_by)        
    request(
      http_method: :get, 
      endpoint: "/games", 
      params: { sortby: sort_by }
      )
  end

  private

  def request(http_method:, endpoint:, params: {})
    response = Faraday.public_send(http_method, "#{BASE_URL}#{endpoint}", params)
    handle_response(response)
  end

  def handle_response(response)
    if response.success?
      JSON.parse(response.body)
    else
      error_message = "Failed HTTP request: #{response.status} - #{response.reason_phrase}"
      raise StandardError, error_message
    end
  end
end
