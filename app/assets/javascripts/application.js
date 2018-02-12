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
//= require cocoon
//= require turbolinks
//= require toastr
//= require datatables.min
//= require metisMenu
//= require inspinia
//= require bootstrap.min
//= require jasny-bootstrap.min


// $(document).on('turbolinks:load', function() {
//     $("templates").imagepicker();
// 

$(document).on('turbolinks:load', function() {
    $(document).ready(function () {
    $('#input-email').on('focus', function(){
        $('.label-email').addClass('label-after');
        $('#input-email').css('border-color','#4771FA');
    });
    $('#input-name').on('focus', function(){
        $('.label-name').addClass('label-after');
        $('#input-name').css('border-color','#4771FA');
    });
    $('#input-pass').on('focus', function(){
        $('.label-pass').addClass('label-after');
        $('#input-pass').css('border-color','#4771FA');
    });
    $('#input-pass-c').on('focus', function(){
        $('.label-pass-c').addClass('label-after');
        $('#input-pass-c').css('border-color','#4771FA');
    });
    $('#input-email').on('focusout', function(){
    if ( $('#input-email').val() == '' ) {
        $('.label-email').removeClass('label-after');
        $('#input-email').css('border-color','#e5e6e7');
            
    }
    else if ( $('#input-email').val() != '' ) {
       $('.label-email').addClass('label-after');
       $('#input-email').css('border-color','#4771FA');
    }
    
    });
    $('#input-name').on('focusout', function(){
    if ( $('#input-name').val() == '' ) {
        $('.label-name').removeClass('label-after');
        $('#input-name').css('border-color','#e5e6e7');
            
    }
    else if ( $('#input-name').val() != '' ) {
       $('.label-name').addClass('label-after');
       $('#input-name').css('border-color','#4771FA');
    }
    
    });
    $('#input-pass').on('focusout', function(){
    if ( $('#input-pass').val() == '' ) {
        $('.label-pass').removeClass('label-after');
        $('#input-pass').css('border-color','#e5e6e7');
            
    }
    else if ( $('#input-pass').val() != '' ) {
       $('.label-pass').addClass('label-after');
       $('#input-pass').css('border-color','#4771FA');
    }
    
    });
    $('#input-pass-c').on('focusout', function(){
    if ( $('#input-pass-c').val() == '' ) {
        $('.label-pass-c').removeClass('label-after');
        $('#input-pass-c').css('border-color','#e5e6e7');
            
    }
    else if ( $('#input-pass-c').val() != '' ) {
       $('.label-pass-c').addClass('label-after');
       $('#input-pass-c').css('border-color','#4771FA');
    }
    
    });
});


$('.dataTables-example').DataTable({
    pageLength: 25,
    responsive: true,
    dom: '<"html5buttons"B>lTfgitp',
    buttons: [
        { extend: 'copy'},
        {extend: 'csv'},
        {extend: 'excel', title: 'ExampleFile'},
        {extend: 'pdf', title: 'ExampleFile'},

        {extend: 'print',
         customize: function (win){
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
