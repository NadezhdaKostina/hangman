class ConsoleInterface
  FIGURES =
      Dir[__dir__ + '/../data/figures/*.txt'].
      sort.
      map {|file_name| File.read(file_name)}

  def initialize(game)
    @game = game
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def figure
    FIGURES[@game.errors_made]
  end

  def get_input
    print "Please input next letter: "
    letter = STDIN.gets[0].upcase
    letter
  end

  def print_out
    puts <<~END
      Слово: #{word_to_show}
      #{figure}
      Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}
    END

    if @game.won?
      puts 'Congrats! You won!'
    elsif @game.lost?
      puts "You lost. The answer is: #{@game.word}"
    end
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter == nil
          '__'
        else
          letter
        end
      end
    result.join(' ')
  end
end
