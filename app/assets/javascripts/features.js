
$(document).ready(function(){
    $('.disabled').attr('href', '#');
    $('.disabled').removeAttr('data-method');
    $('.alert').delay(5000).fadeOut();
    $('#feature_table').tableDnD({
        onDrop: function(table, row) {
            var rows = table.tBodies[0].rows;
            var project = $('#feature_table').attr("name");
            //var debugStr = "Project ID: "+project+" Row dropped has ID: "+row.id+". New order: ";
            var newOrder = new Array();
            for (var i=0; i<rows.length; i++) {
                newOrder[i] = rows[i].id;
                //debugStr += newOrder[i]+" ";
            }
            //debugStr += "Type of New Order: "+ newOrder;
            //$('#debugArea').html(debugStr);
            $.post("/projects/sort_features.json", {order: newOrder, project_id: project}, function(data, status){$('#sorted').html("Priorities updated successfully!").fadeIn().delay(1500).fadeOut()});

        }//,
        /*onDragStart: function(table, row) {
            $('#debugArea').html("Started dragging item with ID: "+row.id);
        }*/
    });
    $("#feature_table tr:even').addClass('tDnD_whileDrag')");

});

