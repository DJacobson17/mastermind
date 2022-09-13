require_relative 'introduction'
require_relative 'human_setter'
require_relative 'computer_setter'
require 'set'
require 'pry-byebug'

class Mastermind # rubocop:disable Style/Documentation
  include TextInstructions
  include ComputerGuess
  include HumanGuess
  attr_accessor :guess

  def initialize
    colors = '123456'.chars
    @all_answers = colors.product(*[colors] * 3).map(&:join)
    @all_scores = Hash.new { |h, k| h[k] = {} }

    @all_answers.product(@all_answers).each do |guess, answer|
      @all_scores[guess][answer] = calculate_score(guess, answer)
    end

    @all_answers = @all_answers.to_set
    puts instructions
    play_game
  end

  private

  def player_selection # rubocop:disable Metrics/MethodLength
    loop do
      @player = gets.chomp.to_i
      case @player
      when 1
        create_master_maker
        break
      when 2
        create_master_breaker
        break
      else
        puts 'Not a valid response.  Please choose 1 or 2.'
      end
    end
  end

  def play_game
    @guesses = 0
    player_selection
    @possible_scores = @all_scores.dup
    @possible_answers = @all_answers.dup
    while @guesses < 12
      @guess = make_guess
      if @all_answers.include?(@guess)
        @guesses += 1
        # binding.pry
        @score = calculate_score(@guess, @answer)
        if @score == 'BBBB'
          p [@guesses, @guess]
          break
        end
      end
    end
  end

  def make_guess
    if @player == 1
      computer_make_guess
    else
      human_make_guess
    end
  end

  def calculate_score(guess, answer) # rubocop:disable Metrics/MethodLength
    score = ''
    wrong_guess_pegs = []
    wrong_answer_pegs = []
    peg_pairs = guess.chars.zip(answer.chars)

    peg_pairs.each do |guess_peg, answer_peg|
      if guess_peg == answer_peg
        score << 'B'
      else
        wrong_guess_pegs << guess_peg
        wrong_answer_pegs << answer_peg
      end
    end
    wrong_guess_pegs.each do |peg|
      if wrong_answer_pegs.include?(peg)
        wrong_answer_pegs.delete(peg)
        score << 'W'
      end
    end
    score
  end
end
Mastermind.new
