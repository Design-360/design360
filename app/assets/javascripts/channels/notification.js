
$(document).ready(function(){
    var initialize = false;
    
    if (! initialize){
        var data = $('#iduser').data('user');
        // alert();
        // alert(data);
        App.notification = App.cable.subscriptions.create({channel: "NotificationChannel", user: data},{
         
            connected: function(){
                toastr.info('NotificationChannel connected');
                // alert("Connected");
                
                
            },
            disconnected: function(){
                
            },
            received: function(data) {
                // body...
                // alert(data);
                // $('#message_content').val('');
                // $('#messages').append(data);
                toastr.info('You have recieved a new notification');
                $('#notification_dropdown').prepend(data);
                
            },
        });
        initialize = true;
    }
});
