class Exame < ActiveRecord::Base
  include SearchModule
  
  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :unidade
  has_many :valor, dependent: :delete_all
  has_many :resultado, dependent: :restrict_with_error
  accepts_nested_attributes_for :valor, allow_destroy: true, reject_if: :all_blank

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
