$(document).ready(function() {
    $('#add_new').click(function() {
        $('#new_form').slideToggle("slow");
        $('#export_form').hide();
        $('#delete_form').hide();
    });
    $('#export_add').click(function() {
        $('#export_form').slideToggle("slow");
        $('#new_form').hide();
        $('#delete_form').hide();
    });
    $('#delete_add').click(function() {
        $('#delete_form').slideToggle("slow");
        $('#new_form').hide();
        $('#export_form').hide();
    });
});