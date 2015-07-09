module Hierarquia
  extend ActiveSupport::Concern

  require 'will_paginate/array'

  included do
    belongs_to :pai, class_name: self, foreign_key: :parent_id
    has_many :filhos, class_name: self, foreign_key: :parent_id, dependent: :destroy

    scope :listar_com_hierarquia, ->(search = nil) {
      select(:id, :nome, :parent_id, :unidade_id)
        .search(search)
        .includes(:pai, :unidade)
        .sort{ |a,b| a.obter_hierarquia <=> b.obter_hierarquia }
    }

    scope :listar_possiveis_pais, -> {
       includes(:pai)
        .sort { |a,b| a.obter_hierarquia <=> b.obter_hierarquia }
    }
  end

  module ClassMethods
    def diferentes_de_mim(atual)
      retorno = []

      self.listar_possiveis_pais.each do |node|
        unless atual.id.nil?
          next if node.obter_hierarquia_por_id.scan(',' + atual.id.to_s + ',') != []
        end

        retorno << node
      end

      retorno
    end
  end

  def obter_hierarquia_por_id
    if self.pai
      self.pai.obter_hierarquia_por_id + self.id.to_s + ','
    else
      ',' + self.id.to_s + ','
    end
  end

  def obter_hierarquia
    if self.pai
      self.pai.obter_hierarquia + ' / ' + self.nome
    else
      self.nome
    end
  end

end
