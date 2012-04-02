$(document).ready(function(){
    $(document).on('click', '.ui-widget-overlay', function(){
    	$('.ui-dialog .ui-dialog-content').dialog('close');
    });
});