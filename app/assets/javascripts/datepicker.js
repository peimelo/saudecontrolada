$(function() {
    $(".datepicker").datepicker({
        showOn: "button",
        showOtherMonths: true,
        changeMonth: true,
        changeYear: true,
        selectOtherMonths: true,
        dayNamesMin: ['Do','Seg','Ter','Qua','Qui','Sex','Sáb'],
        buttonText: "<i class='fa fa-calendar fa-lg'></i>"
    });
});
