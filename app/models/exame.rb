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
    def valor_inferior(idade, sexo)
      if self.valor.size == 1
        return self.valor[0].valor_inferior.round(2).to_f if valor.valor_inferior and (valor.sexo.blank? or valor.sexo == sexo)
      elsif self.valor.size > 1
        self.valor.each do |valor|
          if valor.idade_inferior and valor.idade_superior
            if idade >= valor.idade_inferior and idade <= valor.idade_superior
              return valor.valor_inferior.round(2).to_f if valor.valor_inferior and (valor.sexo.blank? or valor.sexo == sexo)
            end
          elsif valor.idade_inferior and valor.idade_superior.nil?
            if idade >= valor.idade_inferior
              return valor.valor_inferior.round(2).to_f if valor.valor_inferior and (valor.sexo.blank? or valor.sexo == sexo)
            end
          elsif valor.idade_inferior.nil? and valor.idade_superior
            if idade <= valor.idade_superior
              return valor.valor_inferior.round(2).to_f if valor.valor_inferior and (valor.sexo.blank? or valor.sexo == sexo)
            end
          else
            return valor.valor_inferior.round(2).to_f if valor.valor_inferior and (valor.sexo.blank? or valor.sexo == sexo)
          end            
        end
      end

      nil
    end

    def valor_superior(idade, sexo)
      if self.valor.size == 1
        return self.valor[0].valor_superior.round(2).to_f if valor.valor_superior and (valor.sexo.blank? or valor.sexo == sexo)
      elsif self.valor.size > 1
        self.valor.each do |valor|
          if valor.idade_inferior and valor.idade_superior
            if idade >= valor.idade_inferior and idade <= valor.idade_superior
              return valor.valor_superior.round(2).to_f if valor.valor_superior and (valor.sexo.blank? or valor.sexo == sexo)
            end
          elsif valor.idade_inferior and valor.idade_superior.nil?
            if idade >= valor.idade_inferior
              return valor.valor_superior.round(2).to_f if valor.valor_superior and (valor.sexo.blank? or valor.sexo == sexo)
            end
          elsif valor.idade_inferior.nil? and valor.idade_superior
            if idade <= valor.idade_superior
              return valor.valor_superior.round(2).to_f if valor.valor_superior and (valor.sexo.blank? or valor.sexo == sexo)
            end
          else
            return valor.valor_superior.round(2).to_f if valor.valor_superior and (valor.sexo.blank? or valor.sexo == sexo)
          end
        end
      end

      nil
    end
end
