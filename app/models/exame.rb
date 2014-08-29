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
  def nome_unidade
    self.nome + (self.unidade.nil? ? '' : " (#{ self.unidade.nome })")
  end
  
  def valor_referencia_extenso(idade, sexo)
    retorno = ''
    valor = valor_referencia(idade, sexo)
    return retorno if valor.nil?

    retorno += "Idade inferior: #{ valor.idade_inferior.to_i } " if valor.idade_inferior
    retorno += "Idade superior: #{ valor.idade_superior.to_i } " if valor.idade_superior
    retorno += "Valor inferior: #{ valor.valor_inferior } " if valor.valor_inferior
    retorno += "Valor superior: #{ valor.valor_superior } " if valor.valor_superior
    retorno += "Sexo: #{ valor.sexo } " unless valor.sexo.blank?
    retorno += "Referência: #{ valor.referencia.nome } " unless valor.referencia.blank?

    retorno
  end

  def valor_referencia(idade, sexo)
    retorno = nil

    return retorno if idade.nil?

    self.valor.each do |valor|
      retorno ||= valor

      if valor.idade_inferior and valor.idade_superior
        if idade >= valor.idade_inferior and idade <= valor.idade_superior
          return valor if valida_sexo_e_referencia(valor, sexo)
        end
      elsif valor.idade_inferior and valor.idade_superior.nil?
        if idade >= valor.idade_inferior
          return valor if valida_sexo_e_referencia(valor, sexo)
        end
      elsif valor.idade_inferior.nil? and valor.idade_superior
        if idade <= valor.idade_superior
          return valor if valida_sexo_e_referencia(valor, sexo)
        end
      else
        return valor if valida_sexo_e_referencia(valor, sexo)
      end
    end

    retorno
  end

  private
    def valida_sexo_e_referencia(valor, sexo)
      if valor.sexo.blank? or valor.sexo == sexo
        if valor.referencia and
          (valor.referencia.nome == 'Limítrofe' or
          valor.referencia.nome == 'Suficiência')
          return true
        end
      end

      false
    end
end
