require 'open-uri'
require 'json'

class PlaysController < ApplicationController
  def game
    @grid = generate_grid(9)
  end

  def score
    @query = params[:query]
    @grid = params[:grid]
    @start_time = params[:start_time].to_i
    @end_time = Time.now.to_i
    run_game(@query, @grid, @start_time, @end_time)
  end

  def generate_grid(grid_size)
    grid = []
    grid_size.times do
       grid << ('A'..'Z').to_a.sample
    end
    return grid
  end

  def found?(query)
    url = "https://wagon-dictionary.herokuapp.com/#{query}"
    answer_json = open(url).read
    answer_hash = JSON.parse(answer_json)
    return answer_hash["found"]
  end

  def length(query)
    return query.size
  end

  def letter_in_grid?(query, grid)
    querry_as_array = query.upcase.split('')
    querry_as_array.all? do |letter|
      querry_as_array.count(letter) <= grid.count(letter)
    end
  end

  def run_game(query, grid, start_time, end_time)
  @time = end_time - start_time
    if found?(query)
      if letter_in_grid?(query, grid)
        @message = "Well done"
        score = query.length
      else @message = "Not in the grid"
      end
    else @message = "Not an english word"
    end
  end
end
