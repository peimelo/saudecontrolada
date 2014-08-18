class Exame < ActiveRecord::Base
  include SearchModule
  
  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :unidade
  has_many :valor, dependent: :delete_all
  has_many :resultado, dependent: :restrict_with_error
  accepts_nested_attributes_for :valor, allow_destroy: true, reject_if: :all_blank

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }
  
  # methods ---------------------------------------------------------------------------------------
    def valor_inferior(idade)
      if self.valor.size == 1
        return self.valor[0].valor_inferior.round(2).to_f if valor.valor_inferior
      elsif self.valor.size > 1
        self.valor.each do |valor|
          if valor.idade_inferior and valor.idade_superior
            if idade >= valor.idade_inferior and idade <= valor.idade_superior
              return valor.valor_inferior.round(2).to_f if valor.valor_inferior
            end
          elsif valor.idade_inferior and valor.idade_superior.nil?
            if idade >= valor.idade_inferior
              return valor.valor_inferior.round(2).to_f if valor.valor_inferior
            end
          elsif valor.idade_inferior.nil? and valor.idade_superior
            if idade <= valor.idade_superior
              return valor.valor_inferior.round(2).to_f if valor.valor_inferior
            end
          end
        end
      end

      nil
    end

    def valor_superior(idade)
      if self.valor.size == 1
        return self.valor[0].valor_superior.round(2).to_f if valor.valor_superior
      elsif self.valor.size > 1
        self.valor.each do |valor|
          if valor.idade_inferior and valor.idade_superior
            if idade >= valor.idade_inferior and idade <= valor.idade_superior
              return valor.valor_superior.round(2).to_f if valor.valor_superior
            end
          elsif valor.idade_inferior and valor.idade_superior.nil?
            if idade >= valor.idade_inferior
              return valor.valor_superior.round(2).to_f if valor.valor_superior
            end
          elsif valor.idade_inferior.nil? and valor.idade_superior
            if idade <= valor.idade_superior
              return valor.valor_superior.round(2).to_f if valor.valor_superior
            end
          end
        end
      end

      nil
    end
end
