# frozen_string_literal: true
module ComputerGuess
  def create_master_maker
    loop do
      puts 'Please input 4 numbers, each between 1 and 6 with no spaces in between.'
      @answer = gets.chomp
      if !!(@answer =~ (/[1-6][1-6][1-6][1-6]/))
        break
      end
    end
  end

  def computer_make_guess
    if @guesses > 0
      @possible_answers.keep_if { |answer|
          @all_scores[@guess][answer] == @score
        }
      guesses = @possible_scores.map do |guess, scores_by_answer|
        scores_by_answer = scores_by_answer.select { |answer, _score|
          @possible_answers.include?(answer)
        }
        @possible_scores[guess] = scores_by_answer

        score_groups = scores_by_answer.values.group_by(&:itself)
        possibility_counts = score_groups.values.map(&:length)
        worst_case_possibilities = possibility_counts.max
        impossible_guess = @possible_answers.include?(guess) ? 0 : 1
        [worst_case_possibilities, impossible_guess, guess]
      end
      guesses.min.last
    else
      '1122'
    end
  end
end
