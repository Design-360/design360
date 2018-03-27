// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require bootstrap.min
//= require cocoon
//= require jasny-bootstrap.min
//= require toastr
//= require js-inspinia
//= require cable
//= require datatables.min



// $(document).on('turbolinks:load', function() {
//     $("templates").imagepicker();
// 
$( document ).ready(function() {
    console.log( "ready!" );
    
    $("#message_content").keydown(function(event) {
        if (event.keyCode === 13) {
        $("#submit_message").click();
        }
    });
    
    $('.dataTables-example').DataTable({
        pageLength: 25,
        responsive: true,
        dom: '<"html5buttons"B>lTfgitp',
        buttons: [{
                extend: 'copy'
            },
            {
                extend: 'csv'
            },
            {
                extend: 'excel',
                title: 'ExampleFile'
            },
            {
                extend: 'pdf',
                title: 'ExampleFile'
            },

            {
                extend: 'print',
                customize: function(win) {
                    $(win.document.body).addClass('white-bg');
                    $(win.document.body).css('font-size', '10px');

                    $(win.document.body).find('table')
                        .addClass('compact')
                        .css('font-size', 'inherit');
                }
            }
        ]

    });
});

$( document ).ready(function() {
var height = 10000000;
    $('.chat-form-c').animate({scrollTop: height});
$(".answer-btn-1").click(function() {
    $("#doc").click();
});
$("#doc").change(function() {
    $(".answer-btn-2").click();
});
$(".notifications").click(function(){
   window.location=$(this).find("a").attr("href"); 
   return false;
  });
  
});



   
