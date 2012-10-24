// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){
    $('.disabled').attr('href', '#');
    $('.alert').delay(5000).fadeOut();
    $('#feature_table').tableDnD({
        onDrop: function(table, row) {
            var rows = table.tBodies[0].rows;
            var debugStr = "Row dropped was "+row.id+". New order: ";
            for (var i=0; i<rows.length; i++) {
                debugStr += rows[i].id+" ";
            }
            $('#debugArea').html(debugStr);
        }
    });
    $("#feature_table tr:even').addClass('tDnD_whileDrag')");




    $('.tBTN').width(
        Math.max.apply(
            Math,
            $('.tBTN').map(function(){
                return $(this).outerWidth();
            }).get()
        )
    );

});


