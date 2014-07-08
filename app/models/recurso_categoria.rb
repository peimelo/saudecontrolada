class RecursoCategoria < ActiveRecord::Base
  self.table_name = "recursos_categorias"

  has_many :recurso, dependent: :restrict_with_error

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }
  
  # methods ---------------------------------------------------------------------------------------
  def recursos
    @recursos
  end
  
  def recursos=(recursos)
    @recursos = recursos
  end
  
  private

  def self.search(search)
    if search
      where('nome LIKE ?', "%#{search}%")
    else
      all
    end
  end  
end