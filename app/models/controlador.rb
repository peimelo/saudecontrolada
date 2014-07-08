class Controlador < ActiveRecord::Base
  # relacionamentos -------------------------------------------------------------------------------
  has_many :recurso, dependent: :restrict_with_error

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }

  # methods ---------------------------------------------------------------------------------------
  private

  def self.search(search)
    if search
      where('nome LIKE ?', "%#{search}%")
    else
      all
    end
  end
end