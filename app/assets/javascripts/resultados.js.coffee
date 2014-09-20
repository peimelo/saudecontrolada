jQuery ->
  $('#resultado_exame_nome').autocomplete
    minLength: 2
    source: '/exames/autocomplete.json'
