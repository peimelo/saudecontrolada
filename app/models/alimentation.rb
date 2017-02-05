class Alimentation < ApplicationRecord
  belongs_to :meal
  belongs_to :user
  has_many :alimentation_food, -> {
    includes(:food)
      .joins(:food)
      .order('foods.name')
  }, dependent: :delete_all
  # has_many :exam, through: :exam_alimentation
  # accepts_nested_attributes_for :exam_alimentation, allow_destroy: true, reject_if: :all_blank
  #
  # validates :date, :description, :user_id, presence: true
  # validates :date, uniqueness: { scope: :description, case_sensitive: false }
  # validates :description, uniqueness: { scope: :date }
  #
  # validate :uniqueness_of_exam_alimentation

  # scope :listar, -> (
  #   data_inicial = '',
  #   data_final = '',
  #   descricao = ''
  # ) {
  #   select(:id, :data, :descricao)
  #     .where('data >= ?', data_inicial.blank? ? '1000-01-01' : format_date_usa(data_inicial))
  #     .where('data <= ?', data_final.blank? ? '9999-12-31' : format_date_usa(data_final))
  #     .where('descricao LIKE ?', "%#{ descricao }%")
  #     .ordenado_por_data_desc
  # }

  scope :ordered, -> {
    select(:id, :date, :meal_id)
      .includes(:meal)
      .order(date: :desc)
  }

  # private
  #   def uniqueness_of_exam_alimentation
  #     hash = {}
  #     exam_alimentation.each do |exam_alimentation|
  #       if hash[exam_alimentation.exam_id]
  #         # This line is needed to form the parent to error out, otherwise the save would still happen
  #         errors.add(:'exam_alimentation.exame_id', 'duplicate error') if errors[:'exam_alimentation.exam_id'].blank?
  #         # This line adds the error to the child to view in your fields_for
  #         exam_alimentation.errors.add(:exam_id, :taken2)
  #       end
  #       hash[exam_alimentation.exam_id] = true
  #     end
  #   end
end
