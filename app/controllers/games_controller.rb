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
  @time_submit = params[:time].to_i
  @time_now = Time.now.to_i
  @time_diff = @time_now - @time_submit
  @score = count_score(@word, @time_diff)
  @result = ""

  url = "https://wagon-dictionary.herokuapp.com/#{@word}"
  user_serialized = open(url).read
  user = JSON.parse(user_serialized)
  true_answer = user["found"]

  if @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
    if true_answer
      return @result = "Congratulations! #{@word} is a valid English word! Your score: #{@score}"
    else
      return @result = "Sorry but #{@word} does not seem to be a valid English word... Your score: #{@score = 0}"
    end
  else
    return @result = "Sorry but #{@word} can not be built out of #{@letters.join(", ")}. Your score: #{@score = 0}"
  end
end

private

def count_score(guess, time)
  time > 60 ? 0 : guess.size * (1 - time / 60)
end

end
