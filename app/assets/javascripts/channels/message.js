
// console.log('hello');
// console.log(chat_id);
// alert(chat_id)
var initialized = false;
$(document).ready(function(){
    var chat_id = $('#messages').data('chat_id');
    // alert(chat_id);
    if (!initialized) {
        App.message = App.cable.subscriptions.create({channel: "MessageChannel", chat_id: chat_id},{
         
            connected: function(){
                // alert("Connected");
                
                
            },
            disconnected: function(){
                
            },
            notify: function(){
                alert("notify");
                
            },
            speak: function(data) {
                alert();
                // $(this).perform ('speak', {message: self })
                // $('#messages').append(data['message']);
                // body...
            },
            received: function(data) {
                // body...
                // alert(data);
                // $('#message_content').val('');
                $('#messages').append(data);
                // toastr.info('Are you the 6 fingered man?');
                var height = 10000000;
                $('.chat-form-c').animate({scrollTop: height});
                
            },
            send_message: function(message) {
                // @perform 'send_message', {message: message};
                
            }
          
        });
        initialized = true;
    }
        
});

