class Contato < ActiveRecord::Base
  # validações ------------------------------------------------------------------------------------
  validates :email, email_format: true
  validates :email, :mensagem, presence: true
end