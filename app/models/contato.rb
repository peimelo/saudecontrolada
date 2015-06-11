class Contato < ActiveRecord::Base
  validates :email, email_format: true
  validates :email, :mensagem, presence: true
end