# frozen_string_literal: true
require 'pry-byebug'

class Mastermind
  attr_accessor :guess

  def initialize
    create_master
    @guess_number = 0
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
  @master = 4.times.map { 1 + Random.rand(6)} # rubocop:disable Style/RandomWithOffset
end

def input_guess
  puts "Guess ##{1 + @guess_number}:"
  @guess = gets.chomp.split('')
end

def check_guess # rubocop:disable Metrics/MethodLength
  @right_place = 0
  @right_color = 0
  @guess.each_with_index do |guess_number, guess_index|
      @master.each_with_index do |master_number, master_index|
        if master_number == guess_number.to_i
          if master_index == guess_index
            @right_place += 1
          else
            @right_color += 1
          end
        end
      end
  end
  @guess_number += 1
end

def check_win
  return unless @right_place == 4

  puts 'Winner, winner, chicken dinner!!!'
  @game_over = true
end

def check_loss
  return unless @guess_number >= 12

  puts 'You lost! So sad :( '
  @game_over = true
end

def play_round
  input_guess
  check_guess
  check_win
  check_loss
  display_result
end

def display_result
  puts "Your guess: #{@guess.join('   ')}"
  puts "Number in the right place: #{@right_place}"
  puts "Number of right color, but wrong place: #{@right_color}"
  puts "You have #{ 12 - @guess_number} guesses left."
end

game1 = Mastermind.new
