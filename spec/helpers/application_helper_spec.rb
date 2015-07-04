RSpec.describe ApplicationHelper do
  describe '#corrigir_erros' do
    it 'gera partial para exibir mensagem de erro' do
      expect(helper.corrigir_erros(true)).to render_template 'layouts/_alert_model_error'
    end
  end

  describe '#data_formatada' do
    it 'diferente de false retorna o icone correspondente' do
      time = Time.now
      expect(helper.data_formatada(nil)).to eq ''
      expect(helper.data_formatada(time)).to eq time.strftime('%d/%m/%Y')
    end
  end

  describe '#imagem_true' do
    it 'diferente de false retorna o icone correspondente' do
      expect(helper.imagem_true(false)).to eq nil
      expect(helper.imagem_true(true)).to_not be_nil
    end
  end

  describe '#label_valor' do
    it 'mostra label em negrito e depois o valor' do
      %w[strong Label: valor].each do |item|
        expect(helper.label_valor('Label: ', 'valor')).to include(item)
      end
    end
  end

  describe '#limpar_filtro' do
    it 'sem parametro retorna nulo' do
      params = Hash.new

      expect(helper.limpar_filtro('qq', params)).to eq nil
    end

    it 'com parametros mostra link de limpar filtro' do
      params = Hash.new
      params[:nome] = 'nome'

      expect(helper.limpar_filtro('qq', params)).to_not be_nil
    end
  end

  describe '#numero_formatado' do
    it 'retorna o numero formatado com a unidade' do
      resultados = ['0,00', '15,00', '15,10ml', '15,21', '1.500,00ml']
      unidades = ['', '', 'ml', '', 'ml']
      valores = [0, 15, 15.1, 15.21, 1500]

      resultados.each_with_index do |resultado, i|
        expect(helper.numero_formatado(valores[i], unidades[i])).to eq resultado
      end
    end
  end

  describe '#situacao_resultado_exame' do
    it 'retorna a situacao baseada no resultado do exame' do
      valor_inferior = create(:valor, valor_inferior: 10)
      valor_inferior_superior = create(:valor, valor_inferior: 10, valor_superior: 20)
      valor_superior = create(:valor, valor_superior: 20)

      resultados = ['', 'OK', 'Abaixo', 'Acima', 'OK', 'Abaixo', 'OK', 'Acima', '']
      valores = [0, 15, 9, 21, 15, 9, 15, 21, 0]
      valores_referencia = [
        nil,
        valor_inferior_superior,
        valor_inferior_superior,
        valor_inferior_superior,
        valor_inferior,
        valor_inferior,
        valor_superior,
        valor_superior,
        create(:valor)
      ]

      resultados.each_with_index do |resultado, i|
        expect(helper.situacao_resultado_exame(valores[i], valores_referencia[i])).to eq resultado
      end
    end
  end

  describe '#titulo' do
    it 'retorna o titulo com a tag especifica' do
      expect(helper.titulo('Titulo')).to eq '<h3>Titulo</h3>'
      expect(raw(helper.titulo('</i> Titulo'))).to eq '<h3>&lt;/i&gt; Titulo</h3>'
    end
  end
end
