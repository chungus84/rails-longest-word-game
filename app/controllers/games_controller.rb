# frozen_string_literal: true

require 'open-uri'
  require 'json'

class GamesController < ApplicationController


  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }

  end

  def score
    @answer = (params[:answer] || "").upcase
    @letters = params[:letters].split
    @included = included?(@answer, @letters)
    @api_answer = check_api(@answer)
  end

  def included?(word, letters)
    word.chars.all? { |char| word.count(char) <= letters.count(char)}
  end

  def check_api(word)
    @data = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    JSON.parse(@data)["found"]
  end
end
