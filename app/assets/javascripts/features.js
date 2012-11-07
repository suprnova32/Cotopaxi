
function showLoaders(){
    $('#manyForms').fadeOut();
    $('#loader').fadeIn();
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
    $('.draggable').draggable({ cursor: "move", helper: "clone"});
    $('#dropZone').droppable({
        drop: function (event, ui){
            var dragClone = $(ui.draggable).clone();
            dragClone.attr('class', 'cubic ui-sortable');
            var featureID = dragClone.attr('id');
            var projectID = $('#project_id').attr('name');
            var sprintID = $('#dropZone').attr('name');
            $(ui.draggable).fadeOut();
            $('#dropZone').append(dragClone);
            $('#dropZone').append("<br/>");
            $.post("/projects/"+projectID+"/confirm_sprint.json", {feature_id: featureID, sprint_id: sprintID});
            //alert("Feature dropped with ID:"+ dragClone.attr('id'))
        }
    });
    $('#multiRoleAssign').click(function(){
        $('.bar').attr("style", "width: 0%;");
        $('.show').fadeOut();
        $('.hide4').fadeOut();
        showLoaders();
        $.post($ownerForm.attr('action'), $ownerForm.serializeArray(), function(data){
            if(data != null){
                var $response = $(data).find('#home').html();
                if($response == 'Current Projects'){
                    $('#loader').fadeOut();
                    $('.showError').fadeIn();
                    $('#manyForms').fadeIn();
                } else {
                    $('.bar').attr("style", "width: 33%;");
                    $.post($scrumForm.attr('action'), $scrumForm.serializeArray(), function(data){
                        if(data != null){
                            $('.bar').attr("style", "width: 66%;");
                            $.post($multiForm.attr('action'), $multiForm.serializeArray(), function(data){
                                $('.bar').attr("style", "width: 100%;");
                                $('#loader').delay(800).fadeOut();
                                $('.show').delay(1200).fadeIn();
                                $('#manyForms').delay(1500).fadeIn();
                                $('#assignAlert').fadeOut();
                            });
                        }
                    });
                }
            }
        });
    });
    $('.chzn-select').chosen();
    $('.disabled').attr('href', '#');
    $('.disabled').removeAttr('data-method');
    $('.notice').delay(5000).fadeOut();
    $('.prevent').click(function(event){
        return confirm('You still have open features. Are you sure you want to complete the project?')
    });
    $('#feature_table').tableDnD({
        onDrop: function(table, row) {
            $('#loadingImage').show();
            var rows = table.tBodies[0].rows;
            var project = $('#feature_table').attr("name");
            var newOrder = new Array();
            for (var i=0; i<rows.length; i++) {
                newOrder[i] = rows[i].id;
            }
            var pathSort = window.location.pathname;
            $.post(pathSort+"/sort_features.json", {order: newOrder, project_id: project}, function(data, xhr){
                if(xhr != 'success'){
                    $('#errorSort').html("An error has occurred. Please read the logs for more info.").fadeIn();
                } else {
                    var $response = $(data).find('#home').html();
                    if($response == 'Current Projects'){
                        $('#loadingImage').hide();
                        $('#errorSort').html("Sorry, you don't have permission to do that!").fadeIn();
                    } else {
                        $('#sorted').html("Priorities updated successfully!").fadeIn().delay(4000).fadeOut();
                        $('#loadingImage').delay().fadeOut();
                    }
                }
            });
        }
    });
    $("#feature_table tr:even').addClass('tDnD_whileDrag')");
});

