//= require jquery
//= require jquery_ujs
//= require jquery.inputmask
//= require jquery.inputmask.date.extensions
//= require jquery.inputmask-multi
//= require jquery.inputmask.numeric.extensions
// require jquery.inputmask.extensions
// require jquery.inputmask.phone.extensions
// require jquery.inputmask.regex.extensions
//= require bootstrap-sprockets
//= require highcharts/highcharts
//= require highcharts/highcharts-more
//= require highcharts/modules/exporting
//= require highchart_config
// require_tree .

$(document).ready(function() {
    $("#user_date_of_birth").inputmask("d/m/y",{ "placeholder": "dd/mm/aaaa" });
    $("#peso_data").inputmask("d/m/y",{ "placeholder": "dd/mm/aaaa" });
    $("#peso_altura").inputmask({ "mask": "9,99" });
//    $("#peso_peso").inputmask({ "mask": ["9[,99]","99[,99]","999[,99]"] });
//    $("#peso_peso").inputmask({ "mask": ["99[9,99]"] });
});
