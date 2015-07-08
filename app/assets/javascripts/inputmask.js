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

/* User no nested form de resultado */
function resultado_inputmask(){
    $(".inputmask_resultado").inputmask('numeric', {
        allowPlus: false,
        allowMinus: false,
        digits: 2,
        integerDigits: 8,
        radixPoint: ','});

    $('.chosen-select').chosen({
        allow_single_deselect: true,
        data_placeholder: 'llllll',
        no_results_text: 'Não encontrado:'});
}
