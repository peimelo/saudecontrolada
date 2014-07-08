class ErroStatus < ActiveRecord::Base
  # relacionamentos -------------------------------------------------------------------------------
  has_many :erro

  # validações ------------------------------------------------------------------------------------
  validates :classe, :classe_badge, :nome, presence: true
  validates :nome, uniqueness: { case_sensitive: false }
end
