crumb :root do
  link 'Home', root_path
end

# -----------------------------------------------
crumb :exames do
  link t('activerecord.models.exame.other'), exames_path
end

crumb :edit_exame do |exame|
  link exame.nome, edit_exame_path(exame)
  parent :exames
end

crumb :new_exame do
  link t('views.new.titulo', model: Exame.model_name.human), new_exame_path
  parent :exames
end

# -----------------------------------------------
crumb :pesos do
  link t('activerecord.models.peso.other'), pesos_path
end

crumb :edit_peso do |peso|
  link l(peso.data), edit_peso_path(peso)
  parent :pesos
end

crumb :new_peso do
  link t('views.new.titulo', model: Peso.model_name.human), new_peso_path
  parent :pesos
end

# -----------------------------------------------
crumb :resultados do
  link t('activerecord.models.resultado.other'), resultados_path
end

crumb :edit_resultado do |resultado|
  link l(resultado.data), edit_resultado_path(resultado)
  parent :show_resultado, resultado.exame
end

crumb :show_resultado do |exame|
  link exame.nome, resultado_path(exame)
  parent :resultados
end

crumb :new_resultado do |exame|
  link t('views.new.titulo', model: Resultado.model_name.human), new_resultado_path
  parent :show_resultado, exame
end
