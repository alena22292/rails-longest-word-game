# require 'open-uri'
# require 'json'

class GamesController < ApplicationController
   skip_before_action :verify_authenticity_token
  def new
# to display a new random grid and a form(POST)
    array_letter = ('A'..'Z').to_a
    @letters = array_letter.shuffle.take(10)
    @word = params[:word]
  end
  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase
    @result = ""

    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    true_answer = user["found"]

    if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
      if true_answer
        return @result = "Congratulations! #{@word} is a valid English word!"
      else
        return @result = "Sorry but #{@word} does not seem to be a valid English word..."
      end
    else
      return @result = "Sorry but #{@word} can not be built out of #{@letters.join(",")}"
    end
  end

  private

end
