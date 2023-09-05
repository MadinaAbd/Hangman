class Game
  TOTAL_ERRORS_ALLOWED = 7

  def self.normalize_letter(letter)
    case letter
    when "Й"
      "И"
    when "Ё"
      "Е"
    else
      letter
    end
  end

  def initialize(word)
    @letters = word.upcase.chars
    @user_guseses = []
  end

  def errors
    @user_guseses - normalized_letters
  end

  def errors_made
    errors.length
  end

  def errors_allowed
    TOTAL_ERRORS_ALLOWED - errors_made
  end

  def letters_to_guess
    @letters.map do |letter|
      letter if @user_guseses.include?(self.class.normalize_letter(letter))
    end
  end

  def lost?
    errors_allowed == 0
  end

  def over?
    won? || lost?
  end

  def play!(letter)
    normalized_letter = self.class.normalize_letter(letter)

    if !over? && !@user_guseses.include?(normalized_letter)
      @user_guseses << normalized_letter
    end
  end

  def word
    @letters.join
  end

  def won?
    (normalized_letters - @user_guseses).empty?
  end

  private

  def normalized_letters
    @letters.map { |letter| self.class.normalize_letter(letter) }
  end
end
