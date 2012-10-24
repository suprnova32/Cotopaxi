
$(document).ready(function(){
    $('.disabled').attr('href', '#');
    $('.alert').delay(5000).fadeOut();
    $('#feature_table').tableDnD({
        onDrop: function(table, row) {
            var rows = table.tBodies[0].rows;
            var debugStr = "Row dropped has ID: "+row.id+". New order: ";
            var newOrder = new Array();
            for (var i=0; i<rows.length; i++) {
                debugStr += rows[i].id+" ";
            }
            $('#debugArea').html(debugStr);

        },
        onDragStart: function(table, row) {
            $('#debugArea').html("Started dragging row "+row.id);
        }
    });
    $("#feature_table tr:even').addClass('tDnD_whileDrag')");

});

