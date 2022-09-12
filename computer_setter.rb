# frozen_string_literal: true
module HumanGuess
  def create_master_breaker
    @answer = 4.times.map { 1 + Random.rand(6) }.join # rubocop:disable Style/RandomWithOffset
  end

  def human_make_guess
    if @guesses >= 0
      puts "Score: #{@score}"
    else
      puts
    end
    puts "Guesses Remaining: #{12 - @guesses}"
    print 'Guess: '
    gets.chomp
  end
end
