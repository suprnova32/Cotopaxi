
$(document).ready(function(){
    $('.disabled').attr('href', '#');
    $('.disabled').removeAttr('data-method');
    $('.alert').delay(5000).fadeOut();
    $('#feature_table').tableDnD({
        onDrop: function(table, row) {
            var rows = table.tBodies[0].rows;
            var project = $('#feature_table').attr("name");
            var newOrder = new Array();
            for (var i=0; i<rows.length; i++) {
                newOrder[i] = rows[i].id;
            }
            $.post("/projects/sort_features.json", {order: newOrder, project_id: project}, function(data, status){$('#sorted').html("Priorities updated successfully!").fadeIn().delay(1500).fadeOut()});
        }
    });
    $("#feature_table tr:even').addClass('tDnD_whileDrag')");
});

