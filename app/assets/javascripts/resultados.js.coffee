jQuery ->
  $('#resultado_exame_nome').autocomplete
    minLength: 2
    source: $('#resultado_exame_nome').data('autocomplete-source')
