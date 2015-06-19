class Exame < ActiveRecord::Base
  include SearchModule, Tree

  belongs_to :unidade
  has_many :resultado, dependent: :restrict_with_error
  has_many :valor, dependent: :delete_all
  accepts_nested_attributes_for :valor, allow_destroy: true, reject_if: :all_blank

  validates :nome, presence: true, uniqueness: { case_sensitive: false }

  def nome_unidade
    self.nome + (self.unidade.nil? ? '' : " (#{ self.unidade.nome })")
  end
  
  def valor_referencia_extenso(idade, sexo)
    retorno = '| '
    valor = valor_referencia(idade, sexo)
    return retorno if valor.nil?

    retorno += "Sexo: #{ valor.sexo } | " unless valor.sexo.blank?

    if valor.idade_inferior and valor.idade_superior
      retorno += "Idade: #{ valor.idade_inferior.to_i } ~ #{ valor.idade_superior.to_i } anos | "
    elsif valor.idade_inferior and !valor.idade_superior
      retorno += "Idade acima de: #{ valor.idade_inferior.to_i } anos | " 
    elsif !valor.idade_inferior and valor.idade_superior
      retorno += "Idade abaixo de: #{ valor.idade_superior.to_i } anos | " 
    end
    
    if valor.valor_inferior and valor.valor_superior
      retorno += "Valor: #{ valor.valor_inferior } ~ #{ valor.valor_superior } | "
    elsif valor.valor_inferior and !valor.valor_superior
      retorno += "Valor acima de: #{ valor.valor_inferior } | " 
    elsif !valor.valor_inferior and valor.valor_superior
      retorno += "Valor abaixo de: #{ valor.valor_superior } | " 
    end

    retorno += "Referência: #{ valor.referencia.nome } |" unless valor.referencia.blank?

    retorno == '| ' ? '' : retorno
  end

  def valor_referencia(idade, sexo)
    retorno = nil

    return retorno if idade.nil?

    self.valor.each do |valor|
      next if !valor.valido?

      if valor.idade_inferior and valor.idade_superior
        if idade >= valor.idade_inferior and idade <= valor.idade_superior
          return valor if valida_sexo(valor, sexo)
        end
      elsif valor.idade_inferior and valor.idade_superior.nil?
        if idade >= valor.idade_inferior
          return valor if valida_sexo(valor, sexo)
        end
      elsif valor.idade_inferior.nil? and valor.idade_superior
        if idade <= valor.idade_superior
          return valor if valida_sexo(valor, sexo)
        end
      else
        return valor if valida_sexo(valor, sexo)
      end
    end

    retorno
  end

  private
    def valida_sexo(valor, sexo)
      if valor.sexo.blank? or valor.sexo == sexo
        return true
      end

      false
    end
end
