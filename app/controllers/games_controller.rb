require "json"
require "open-uri"

class GamesController < ApplicationController
  before_action :word, only: :score

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    raise
    if included?(word, @letters)
      if english_word?(params[:question].to_s)
        @answer = "Congratulations! #{params[:question].upcase} is a valid Enlish word!"
      else
        @answer = "Sorry but #{params[:question].upcase} does not seem to be a valid English word..."
      end
    else
      @answer = "Sorry but #{params[:question].upcase} can't be built out of #{@letters.each { |i| puts i }}!"
    end
  end

  private

  def included?(word, letters)
    word.split('').each do |char|
      letters.include?(char)
    end
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    # path = params[:question].to_s
    # full_url = base_url + path
    response = URI.open(url).read
    @showme = JSON.parse(response)
    @showme['found']
  end

  def word
    params[:question].to_s
  end
end
