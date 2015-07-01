RSpec.describe PesosHelper do
  describe '#situacao_imc' do
    it 'retorna a situacao do imc' do
      resultados = [
        I18n.t('peso.imc.abaixo'),
        I18n.t('peso.imc.normal'),
        I18n.t('peso.imc.acima'),
        I18n.t('peso.imc.obesidade')
      ]
      valores = [18, 20, 26, 31]

      resultados.each_with_index do |resultado, i|
        expect(helper.situacao_imc(valores[i], false)).to eq resultado
      end
    end
  end
end
