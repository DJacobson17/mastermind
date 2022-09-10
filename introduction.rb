# frozen_string_literal: true


module TextInstructions

  def instructions
    <<~HEREDOC


      'How to play Mastermind:'

      This is a 1-player game against the computer.
      You can choose to be the code setter or the code breaker.

      There are six different number/color combinations:

      1, 2, 3, 4, 5, 6

      The code maker will choose four to create a 'master code'. For example,

      4, 5, 2, 4
      As you can see, there can be more then one of the same number.
      In order to win, the code breaker needs to guess the 'master code' in 12 or less turns.

      It's time to play!
      Would you like to be the code MAKER or code BREAKER?

      Press '1' to be the code MAKER
      Press '2' to be the code BREAKER
    HEREDOC
  end

end
