class MigrarResultados < ActiveRecord::Migration
  def change
    exames_resultados = ExameResultado.order(:user_id, :data)

    user = nil
    resultado = nil
    data = nil

    exames_resultados.each do |exame_resultado|
      if exame_resultado.user_id != user or exame_resultado.data != data
        user = exame_resultado.user_id
        data = exame_resultado.data

        resultado = Resultado.create(
          user_id: user,
          data: data,
          descricao: "Resultado do dia #{data.strftime '%d/%m/%Y'}"
        )

        exame_resultado.resultado = resultado
        exame_resultado.save
      else
        exame_resultado.resultado = resultado
        exame_resultado.save
      end
    end
  end
end
