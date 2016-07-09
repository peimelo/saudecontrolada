class Contato < ApplicationRecord
  # validates :email, email_format: true
  validates :email, :mensagem, presence: true

  scope :listar, -> {
    select(:id, :created_at, :nome, :email, :telefones, :ip, :mensagem)
      .order(created_at: :desc)
  }
end

