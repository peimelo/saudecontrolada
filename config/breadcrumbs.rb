crumb :root do
  link 'Home', root_path
end

# -----------------------------------------------------------------------------
crumb :contatos do
  link t('activerecord.models.contato.other'), contatos_path
end

# -----------------------------------------------------------------------------
crumb :exames do
  link t('activerecord.models.exame.other'), exames_path
end

crumb :new_exame do
  link t('views.new.titulo', model: Exame.model_name.human), new_exame_path
  parent :exames
end

crumb :edit_exame do |exame|
  link exame.nome, edit_exame_path(exame)
  parent :exames
end

# -----------------------------------------------------------------------------
crumb :pesos do
  link t('activerecord.models.peso.other'), pesos_path
end

crumb :new_peso do
  link t('views.new.titulo', model: Peso.model_name.human), new_peso_path
  parent :pesos
end

crumb :edit_peso do |peso|
  link l(peso.data), edit_peso_path(peso)
  parent :pesos
end

# -----------------------------------------------------------------------------
crumb :referencias do
  link t('activerecord.models.referencia.other'), referencias_path
end

crumb :new_referencia do
  link t('views.new.titulo', model: Referencia.model_name.human), new_referencia_path
  parent :referencias
end

crumb :edit_referencia do |referencia|
  link referencia.nome, edit_referencia_path(referencia)
  parent :referencias
end

# -----------------------------------------------------------------------------
crumb :resultados do
  link t('activerecord.models.resultado.other'), resultados_path
end
=begin
crumb :show_resultado do |exame|
  link exame.nome, resultado_path(exame) unless exame.nil?
  parent :resultados
end
=end
crumb :new_resultado do |exame|
  link t('views.new.titulo', model: Resultado.model_name.human), new_resultado_path
  parent :resultados
end

crumb :edit_resultado do |resultado|
  link l(resultado.data), edit_resultado_path(resultado)
  parent :resultados
end

# -----------------------------------------------------------------------------
crumb :unidades do
  link t('activerecord.models.unidade.other'), unidades_path
end

crumb :new_unidade do
  link t('views.new.titulo', model: Unidade.model_name.human), new_unidade_path
  parent :unidades
end

crumb :edit_unidade do |unidade|
  link unidade.nome, edit_unidade_path(unidade)
  parent :unidades
end

# -----------------------------------------------------------------------------
crumb :users do
  link t('activerecord.models.user.other'), users_path
end
