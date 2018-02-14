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



// $(document).on('turbolinks:load', function() {
//     $("templates").imagepicker();
// 

$(document).on('turbolinks:load', function() {
    $(document).ready(function() {
        $('#input-email').on('focus', function() {
            $('.label-email').addClass('label-after');
            $('#input-email').css('border-color', '#4771FA');
        });
        $('#input-name').on('focus', function() {
            $('.label-name').addClass('label-after');
            $('#input-name').css('border-color', '#4771FA');
        });
        $('#input-pass').on('focus', function() {
            $('.label-pass').addClass('label-after');
            $('#input-pass').css('border-color', '#4771FA');
        });
        $('#input-pass-c').on('focus', function() {
            $('.label-pass-c').addClass('label-after');
            $('#input-pass-c').css('border-color', '#4771FA');
        });
        $('#input-email').on('focusout', function() {
            if ($('#input-email').val() == '') {
                $('.label-email').removeClass('label-after');
                $('#input-email').css('border-color', '#e5e6e7');

            } else if ($('#input-email').val() != '') {
                $('.label-email').addClass('label-after');
                $('#input-email').css('border-color', '#4771FA');
            }

        });
        $('#input-name').on('focusout', function() {
            if ($('#input-name').val() == '') {
                $('.label-name').removeClass('label-after');
                $('#input-name').css('border-color', '#e5e6e7');

            } else if ($('#input-name').val() != '') {
                $('.label-name').addClass('label-after');
                $('#input-name').css('border-color', '#4771FA');
            }

        });
        $('#input-pass').on('focusout', function() {
            if ($('#input-pass').val() == '') {
                $('.label-pass').removeClass('label-after');
                $('#input-pass').css('border-color', '#e5e6e7');

            } else if ($('#input-pass').val() != '') {
                $('.label-pass').addClass('label-after');
                $('#input-pass').css('border-color', '#4771FA');
            }

        });
        $('#input-pass-c').on('focusout', function() {
            if ($('#input-pass-c').val() == '') {
                $('.label-pass-c').removeClass('label-after');
                $('#input-pass-c').css('border-color', '#e5e6e7');

            } else if ($('#input-pass-c').val() != '') {
                $('.label-pass-c').addClass('label-after');
                $('#input-pass-c').css('border-color', '#4771FA');
            }

        });
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
    
    // Typing
    
    var TxtType = function(el, toRotate, period) {
        this.toRotate = toRotate;
        this.el = el;
        this.loopNum = 0;
        this.period = parseInt(period, 10) || 2000;
        this.txt = '';
        this.tick();
        this.isDeleting = false;
    };

    TxtType.prototype.tick = function() {
        var i = this.loopNum % this.toRotate.length;
        var fullTxt = this.toRotate[i];

        if (this.isDeleting) {
        this.txt = fullTxt.substring(0, this.txt.length - 1);
        } else {
        this.txt = fullTxt.substring(0, this.txt.length + 1);
        }

        this.el.innerHTML = '<span class="wrap">'+this.txt+'</span>';

        var that = this;
        var delta = 200 - Math.random() * 100;

        if (this.isDeleting) { delta /= 2; }

        if (!this.isDeleting && this.txt === fullTxt) {
        delta = this.period;
        this.isDeleting = true;
        } else if (this.isDeleting && this.txt === '') {
        this.isDeleting = false;
        this.loopNum++;
        delta = 500;
        }

        setTimeout(function() {
        that.tick();
        }, delta);
    };

    window.onload = function() {
        var elements = document.getElementsByClassName('typewrite');
        for (var i=0; i<elements.length; i++) {
            var toRotate = elements[i].getAttribute('data-type');
            var period = elements[i].getAttribute('data-period');
            if (toRotate) {
              new TxtType(elements[i], JSON.parse(toRotate), period);
            }
        }
        // INJECT CSS
        var css = document.createElement("style");
        css.type = "text/css";
        css.innerHTML = ".typewrite > .wrap { border-right: 0.08em solid #fff}";
        document.body.appendChild(css);
    };
    
    // Counter

    jQuery('.statistic-counter').counterUp({
        delay: 10,
        time: 2000
    });

    // Progress Bar 
    
    $(function() {
    	$('.progress').circliful();
    });
    //Note -- I removed the respondCanvas function from the circiful library
    /* PROGRESS CIRCLE COMPONENT */
    (function ($) {
    
        $.fn.circliful = function (options, callback) {
    
            var settings = $.extend({
                // These are the defaults.
                startdegree: 0,
                fgcolor: "#556b2f",
                bgcolor: "#eee",
                fill: false,
                width: 15,
                dimension: 200,
                fontsize: 15,
                percent: 50,
                animationstep: 1.0,
                iconsize: '20px',
                iconcolor: '#999',
                border: 'default',
                complete: null,
                bordersize: 10
            }, options);
    
            return this.each(function () {
    
                var customSettings = ["fgcolor", "bgcolor", "fill", "width", "dimension", "fontsize", "animationstep", "endPercent", "icon", "iconcolor", "iconsize", "border", "startdegree", "bordersize"];
    
                var customSettingsObj = {};
                var icon = '';
                var endPercent = 0;
                var obj = $(this);
                var fill = false;
                var text, info;
    
                obj.addClass('circliful');
    
                checkDataAttributes(obj);
    
                if (obj.data('text') != undefined) {
                    text = obj.data('text');
    
                    if (obj.data('icon') != undefined) {
                        icon = $('<i></i>')
                            .addClass('fa ' + $(this).data('icon'))
                            .css({
                                'color': customSettingsObj.iconcolor,
                                'font-size': customSettingsObj.iconsize
                            });
                    }
    
                    if (obj.data('type') != undefined) {
                        type = $(this).data('type');
    
                        if (type == 'half') {
                            addCircleText(obj, 'circle-text-half', (customSettingsObj.dimension / 1.45));
                        } else {
                            addCircleText(obj, 'circle-text', customSettingsObj.dimension);
                        }
                    } else {
                        addCircleText(obj, 'circle-text', customSettingsObj.dimension);
                    }
                }
    
                if ($(this).data("total") != undefined && $(this).data("part") != undefined) {
                    var total = $(this).data("total") / 100;
    
                    percent = (($(this).data("part") / total) / 100).toFixed(3);
                    endPercent = ($(this).data("part") / total).toFixed(3)
                } else {
                    if ($(this).data("percent") != undefined) {
                        percent = $(this).data("percent") / 100;
                        endPercent = $(this).data("percent")
                    } else {
                        percent = settings.percent / 100
                    }
                }
    
                if ($(this).data('info') != undefined) {
                    info = $(this).data('info');
    
                    if ($(this).data('type') != undefined) {
                        type = $(this).data('type');
    
                        if (type == 'half') {
                            addInfoText(obj, 0.9);
                        } else {
                            addInfoText(obj, 1.25);
                        }
                    } else {
                        addInfoText(obj, 1.25);
                    }
                }
    
                $(this).width(customSettingsObj.dimension + 'px');
    
                var canvas = $('<canvas></canvas>').attr({
                    width: customSettingsObj.dimension,
                    height: customSettingsObj.dimension
                }).appendTo($(this)).get(0);
    
                var context = canvas.getContext('2d');
                var container = $(canvas).parent();
                var x = canvas.width / 2;
                var y = canvas.height / 2;
                var degrees = customSettingsObj.percent * 360.0;
                var radians = degrees * (Math.PI / 180);
                var radius = canvas.width / 2.5;
                var startAngle = 2.3 * Math.PI;
                var endAngle = 0;
                var counterClockwise = false;
                var curPerc = customSettingsObj.animationstep === 0.0 ? endPercent : 0.0;
                var curStep = Math.max(customSettingsObj.animationstep, 0.0);
                var circ = Math.PI * 2;
                var quart = Math.PI / 2;
                var type = '';
                var fireCallback = true;
                var additionalAngelPI = (customSettingsObj.startdegree / 180) * Math.PI;
    
                if ($(this).data('type') != undefined) {
                    type = $(this).data('type');
    
                    if (type == 'half') {
                        startAngle = 2.0 * Math.PI;
                        endAngle = 3.13;
                        circ = Math.PI;
                        quart = Math.PI / 0.996;
                    }
                }
              
                /**
                 * adds text to circle
                 *
                 * @param obj
                 * @param cssClass
                 * @param lineHeight
                 */
                function addCircleText(obj, cssClass, lineHeight) {
                    $("<span></span>")
                        .appendTo(obj)
                        .addClass(cssClass)
                        .text(text)
                        .prepend(icon)
                        .css({
                            'line-height': lineHeight + 'px',
                            'font-size': customSettingsObj.fontsize + 'px'
                        });
                }
    
                /**
                 * adds info text to circle
                 *
                 * @param obj
                 * @param factor
                 */
                function addInfoText(obj, factor) {
                    $('<span></span>')
                        .appendTo(obj)
                        .addClass('circle-info-half')
                        .css(
                            'line-height', (customSettingsObj.dimension * factor) + 'px'
                        )
                        .text(info);
                }
    
                /**
                 * checks which data attributes are defined
                 * @param obj
                 */
                function checkDataAttributes(obj) {
                    $.each(customSettings, function (index, attribute) {
                        if (obj.data(attribute) != undefined) {
                            customSettingsObj[attribute] = obj.data(attribute);
                        } else {
                            customSettingsObj[attribute] = $(settings).attr(attribute);
                        }
    
                        if (attribute == 'fill' && obj.data('fill') != undefined) {
                            fill = true;
                        }
                    });
                }
    
                /**
                 * animate foreground circle
                 * @param current
                 */
                function animate(current) {
    
                    context.clearRect(0, 0, canvas.width, canvas.height);
    
                    context.beginPath();
                    context.arc(x, y, radius, endAngle, startAngle, false);
    
                    context.lineWidth = customSettingsObj.bordersize + 1;
    
                    context.strokeStyle = customSettingsObj.bgcolor;
                    context.stroke();
    
                    if (fill) {
                        context.fillStyle = customSettingsObj.fill;
                        context.fill();
                    }
    
                    context.beginPath();
                    context.arc(x, y, radius, -(quart) + additionalAngelPI, ((circ) * current) - quart + additionalAngelPI, false);
    
                    if (customSettingsObj.border == 'outline') {
                        context.lineWidth = customSettingsObj.width + 13;
                    } else if (customSettingsObj.border == 'inline') {
                        context.lineWidth = customSettingsObj.width - 13;
                    }
    
                    context.strokeStyle = customSettingsObj.fgcolor;
                    context.stroke();
    
                    if (curPerc < endPercent) {
                        curPerc += curStep;
                        requestAnimationFrame(function () {
                            animate(Math.min(curPerc, endPercent) / 100);
                        }, obj);
                    }
    
                    if (curPerc == endPercent && fireCallback && typeof(options) != "undefined") {
                        if ($.isFunction(options.complete)) {
                            options.complete();
    
                            fireCallback = false;
                        }
                    }
                }
    
                animate(curPerc / 100);
    
            });
        };
    }(jQuery));


});