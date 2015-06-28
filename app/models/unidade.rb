# == Schema Information
#
# Table name: unidades
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Unidade < ActiveRecord::Base
  include SearchModule

  # armazenamento de logs
  has_paper_trail

  has_many :exame, dependent: :nullify

  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
