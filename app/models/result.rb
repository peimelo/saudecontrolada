class Result < ApplicationRecord
  # include DateModule

  belongs_to :user
  has_many :exame_resultado, dependent: :delete_all
  has_many :exame, through: :exame_resultado
  accepts_nested_attributes_for :exame_resultado, allow_destroy: true, reject_if: :all_blank

  validates :data, :descricao, :user_id, presence: true
  validates :data, uniqueness: { scope: :descricao, case_sensitive: false }
  validates :descricao, uniqueness: { scope: :data }

  validate :uniqueness_of_exame_resultado

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
    order(date: :desc)
  }

  private
    def uniqueness_of_exame_resultado
      hash = {}
      exame_resultado.each do |exame_result|
        if hash[exame_result.exame_id]
          # This line is needed to form the parent to error out, otherwise the save would still happen
          errors.add(:'exame_result.exame_id', 'duplicate error') if errors[:'exame_result.exame_id'].blank?
          # This line adds the error to the child to view in your fields_for
          exame_result.errors.add(:exame_id, :taken2)
        end
        hash[exame_result.exame_id] = true
      end
    end
end
