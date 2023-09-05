class ConsoleInterface
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"].
      sort.
      map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    puts <<~CURRENT_GAME_STATUS
      Слово #{word_to_show.colorize(:violet)}
      #{figure.colorize(color: :blue)}

      Количество ошибок #{@game.errors_made}, осталось ошибок #{@game.errors_allowed}
      Неправильные буквы: #{errors_to_show.colorize(:red)}

    CURRENT_GAME_STATUS

    if @game.won?
      puts "Вы выиграли".colorize(:green)
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово #{@game.word}".colorize(color: :red, background: :light_green)
    end
  end

  def figure
    FIGURES[@game.errors_made]
  end

  def word_to_show
    @game.letters_to_guess.map { |letter| letter || "__" }.join(" ")
  end

  def errors_to_show
    @game.errors.join(", ")
  end

  def get_input
    print "Введите следующую букву: ".colorize(color: :green, background: :grey)
    gets[0].upcase
  end
end
