$(function() {
    $(".inputmask_data").inputmask("dd/mm/yyyy",{ "placeholder": "dd/mm/aaaa" });
});

$(function() {
    $(".inputmask_altura").inputmask('numeric', {
        allowPlus: false,
        allowMinus: false,
        digits: 2,
        integerDigits: 1,
        radixPoint: ','});
});

$(function() {
    $(".inputmask_idade").inputmask('numeric', {
        allowPlus: false,
        allowMinus: false,
        digits: 3,
        integerDigits: 3,
        radixPoint: ','});
});

$(function() {
    $(".inputmask_peso").inputmask('numeric', {
        allowPlus: false,
        allowMinus: false,
        digits: 2,
        integerDigits: 3,
        radixPoint: ','});
});

$(function() {
    $(".inputmask_resultado").inputmask('numeric', {
        allowPlus: false,
        allowMinus: false,
        digits: 2,
        integerDigits: 8,
        radixPoint: ','});
});

/* Aplicar mascara e estilo */
function resultado_inputmask(){
    $(".inputmask_resultado").inputmask('numeric', {
        allowPlus: false,
        allowMinus: false,
        digits: 2,
        integerDigits: 8,
        radixPoint: ','});
}

//$(function() {
//    $('.add_nested_fields_link').on('click', function(event){
        //Below $(this) refers to $('.add_fields'). I assume that is a button and is not what you want to apply the datepicker to.
        //$(this).datepicker({ dateFormat: 'yy-mm-dd', autoSize:true });
        //$(document).find('.inputmask_data').removeClass('datepicker');
        //$(document).find('.inputmask_data').removeClass('hasDatepicker');
        //console.log('valor');
        //console.log($(this));
        //console.log(event.field);
    //});
//});
