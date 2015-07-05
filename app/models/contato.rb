# == Schema Information
#
# Table name: contatos
#
#  id         :integer          not null, primary key
#  nome       :string(255)
#  email      :string(255)      not null
#  telefones  :string(255)
#  mensagem   :text(65535)      not null
#  ip         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Contato < ActiveRecord::Base
  validates :email, email_format: true
  validates :email, :mensagem, presence: true

  scope :listar, -> {
    select(:id, :created_at, :nome, :email, :telefones, :ip, :mensagem)
      .order(created_at: :desc)
  }
end

