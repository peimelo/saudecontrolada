class GenerateToken
  attr_reader :n

  def initialize(n=64)
    @n = n
  end

  def call
    SecureRandom.urlsafe_base64(n)
  end
end
