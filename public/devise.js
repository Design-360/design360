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