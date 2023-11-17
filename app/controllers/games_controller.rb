require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score


    if @showme["found"] == true
      @answer = "Congratulations! #{params[:question].upcase} is a valid Enlish word!"
    elsif @showme["found"] == false
      @answer = "Sorry but #{params[:question].upcase} does not seem to be a valid English word..."
    end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # path = params[:question].to_s
    # full_url = base_url + path
    response = URI.open(url).read
    @showme = JSON.parse(response)
  end

end
