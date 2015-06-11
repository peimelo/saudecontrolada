class Unidade < ActiveRecord::Base
  include SearchModule

  # armazenamento de logs
  has_paper_trail

  has_many :exame, dependent: :nullify

  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
