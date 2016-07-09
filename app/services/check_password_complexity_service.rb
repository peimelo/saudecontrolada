class CheckPasswordComplexityService

  attr_reader :password, :required_complexity

  def initialize(password, required_complexity=4)
    @password = password
    @required_complexity = required_complexity
  end

  def valid?
    score = has_uppercase_letters? + has_digits? + has_extra_chars? + has_downcase_letters?
    score >= required_complexity
  end

  private

  def has_digits?
    password.match(/\d/) ? 1 : 0
  end

  def has_downcase_letters?
    password.match(/[a-z]{1}/) ? 1 : 0
  end

  def has_extra_chars?
    password.match(/[\W_]/) ? 1 : 0
  end

  def has_uppercase_letters?
    password.match(/[A-Z]/) ? 1 : 0
  end
end
