class Exame < ActiveRecord::Base
  include SearchModule
  
  # relacionamentos -------------------------------------------------------------------------------
  has_many :valores_referencias, dependent: :delete_all
  accepts_nested_attributes_for :valores_referencias,
                                # :reject_if => proc { |att| att['valor_superior'].blank? },
                                :allow_destroy => true

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }

  # before_save :mark_children_for_removal

  def mark_children_for_removal
    valores_referencias.each do |child|
      child.mark_for_destruction if child.idade_superior.blank?
    end
  end
end
