# frozen_string_literal: true

require 'pry-byebug'

class Mastermind
  attr_accessor :guess 

  def initialize
    create_master
    @guess_number = 1
    @game_over = false
    puts 'Lets play a game.'
    play_game
  end

  private

  def play_game
    play_round until @game_over == true
  end
end

def create_master
  @master = 4.times.map { 1 + Random.rand(6) } # rubocop:disable Style/RandomWithOffset
end

def input_guess
  puts "Guess ##{@guess_number}:"
  current_guess = gets.chomp.split('')
  @guess = current_guess.map { |n| n.to_i }
end

def check_guess(master, guess)
  temp_master = master.clone
  temp_guess = guess.clone
  @right_place = exact(temp_master, temp_guess)
  @right_color = color_check(temp_master, temp_guess)
end

def exact(master, guess)
  exact_right = 0
  master.each_with_index do |_number, index|
    next unless _number == guess[index].to_i

    exact_right += 1
    master[index] = '*'
    guess[index] = '*'
  end
  exact_right
end

def color_check(master, guess)
  same_color = 0
  # binding.pry
  guess.each_index do |index|
    next unless guess[index] != '*' && master.include?(guess[index])

    same_color += 1
    remove = master.find_index(guess[index])
    master[remove] = '?'
    guess[index] = '?'
  end
  same_color
end

def check_win
  return unless @right_place == 4

  puts 'Winner, winner, chicken dinner!!!'
  puts "#{@master.join('   ')}"
  @game_over = true
end

def check_loss
  return unless @guess_number >= 12

  puts 'You lost! So sad :( '
  puts "Solution: #{@master.join('   ')}"
  @game_over = true
end

def play_round
  input_guess
  check_guess(@master, @guess)
  # binding.pry
  check_win
  check_loss
  @guess_number += 1
  display_result unless @game_over == true
end

def display_result
  puts "Your guess: #{@guess.join('   ')}"
  puts "Number in the right place: #{@right_place}"
  puts "Number of right color, but wrong place: #{@right_color}"
  puts "You have #{13 - @guess_number} guesses left."
end

game1 = Mastermind.new
