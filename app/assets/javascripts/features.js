
function showLoaders(){
    $('#manyForms').fadeOut();
    $('#loader').fadeIn();
}

function hideLoaders(){
    $('#loader').fadeOut();
    $('#manyForms').fadeIn();
}

$(document).ready(function(){
    $('#assignChz').attr("class", "chzn-select");
    $('#modalShow').click(function(){
        $('#assign_modal').modal({"backdrop": "static"});
    });
    $multiForm = $('#multiple-form');
    $scrumForm = $('#scrum_master_form');
    $ownerForm = $('#product_owner_form');
    $path = window.location.pathname;
    $('.modalClose').click(function(){
        $('#manyForms').load($path+' #manyForms', function(){
            $('#assignChz').attr("class", "chzn-select");
            $('.chzn-select').chosen()});
    });
    $('#multiRoleAssign').click(function(){
        $('.bar').attr("style", "width: 0%;");
        $('.show').fadeOut();
        $('.hide4').fadeOut();
        showLoaders();
        $.post($ownerForm.attr('action'), $ownerForm.serializeArray(), function(data){
            if(data != null){
                $('.bar').attr("style", "width: 33%;");
                $.post($scrumForm.attr('action'), $scrumForm.serializeArray(), function(data){
                    if(data != null){
                        $('.bar').attr("style", "width: 66%;");
                        $.post($multiForm.attr('action'), $multiForm.serializeArray(), function(data){
                            $('.bar').attr("style", "width: 100%;");
                            $('#loader').delay(800).fadeOut();
                            $('.show').delay(1200).fadeIn();
                            $('#manyForms').delay(1500).fadeIn();
                        });
                    }
                });
            }
        });
    });
    $('.chzn-select').chosen();
    $('.disabled').attr('href', '#');
    $('.disabled').removeAttr('data-method');
    $('.notice').delay(5000).fadeOut();
    $('.prevent').click(function(event){return confirm('You still have open features. Are you sure you want to complete the project?')});
    $('#feature_table').tableDnD({
        onDrop: function(table, row) {
            var rows = table.tBodies[0].rows;
            var project = $('#feature_table').attr("name");
            var newOrder = new Array();
            for (var i=0; i<rows.length; i++) {
                newOrder[i] = rows[i].id;
            }
            $.post("/projects/sort_features.json", {order: newOrder, project_id: project}, function(data, status){$('#sorted').html("Priorities updated successfully!").fadeIn().delay(2000).fadeOut()});
        }
    });
    $("#feature_table tr:even').addClass('tDnD_whileDrag')");
});

