require 'open-uri'

class GamesController < ApplicationController

  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @word = params[:word]
    @english = check_english?(@word)
    @letters = check_letters?(@word)
  end

  private

  def check_english?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

  def check_letters?(word)
    word_letters = word.chars
    new_letters = new
    word_letters.all? { |letter| new_letters.join.include?(letter) }
  end
end

