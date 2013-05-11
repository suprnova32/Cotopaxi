/*
 Cotopaxi | Scrum Management Tool
 Copyright (C) 2012  MHM-Systemhaus GmbH

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
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
    $('#pastS').click(function(e){
        $('#pastSprints').load($path+"/past_sprints #fillWithThis");
    });
    $('.modalClose').click(function(){
        $('#manyForms').load($path+' #manyForms', function(){
            $('#assignChz').attr("class", "chzn-select");
            $('.chzn-select').chosen()});
    });
    $('#sprintTab').find('a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });
    $('.draggable').draggable({ cursor: "move", helper: "clone"});
    $('#dropZone').droppable({
        drop: function (event, ui){
            if(ui.draggable.attr('name') != 'droppedR'){
                var dragClone = $(ui.draggable).clone();
                dragClone.attr('class', 'cubic backDrag');
                dragClone.attr('name', 'droppedR');
                var featureID = dragClone.attr('id');
                var projectID = $('#project_id').attr('name');
                var sprintID = $('#dropZone').attr('name');
                $.ajax({
                    type: "POST",
                    url: "/projects/"+projectID+"/confirm_sprint.json",
                    data: {feature_id: featureID, sprint_id: sprintID},
                    success: function(){
                        $(ui.draggable).fadeOut();
                        $(ui.draggable).next('br').fadeOut();
                        $('#dropZone').append(dragClone);
                        $('.backDrag').draggable({ cursor: "move", helper: "clone"});
                    },
                    error: function(){
                        $('#topAlert').html('Something went wrong while saving the sprint. Please check your server logs.');
                        $('#topAlertCont').fadeIn();
                    }
                });
            }
        }
    });
    $('#backDropZone').droppable({
        drop: function (event, ui){
            if(ui.draggable.attr('name') == 'droppedR'){
                var dragClone = $(ui.draggable).clone();
                dragClone.attr('class', 'cubic backDrag');
                dragClone.attr('name', 'droppedL');
                var featureID = dragClone.attr('id');
                var projectID = $('#project_id').attr('name');
                var sprintID = 0;
                $.ajax({
                    type: "POST",
                    url: "/projects/"+projectID+"/confirm_sprint.json",
                    data: {feature_id: featureID, sprint_id: sprintID},
                    success: function(){
                        $(ui.draggable).fadeOut();
                        $(ui.draggable).next('br').fadeOut();
                        $('#backDropZone').append(dragClone);
                        $('.backDrag').draggable({ cursor: "move", helper: "clone"});
                    },
                    error: function(){
                        $('#topAlert').html('Something went wrong while saving the sprint. Please check your server logs.');
                        $('#topAlertCont').fadeIn();
                    }
                });
            }
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
    $('.feature_table').tableDnD({
        onDrop: function(table, row) {
            $('#loadingImage').show();
            var rows = table.tBodies[0].rows;
            var newOrder = new Array();
            for (var i=0; i<rows.length; i++) {
                newOrder[i] = rows[i].id;
            }
            var pathSort = window.location.pathname;
            $.post(pathSort+"/sort_features.json", {order: newOrder}, function(data, xhr){
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
    $("#feature_table").find("tr:even').addClass('tDnD_whileDrag')");
});

