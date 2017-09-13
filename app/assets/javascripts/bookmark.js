$(document).on('ready', function(){

  var messageButton = $('.messages .alert button');
  var autoCloseMessage = function() {
    setTimeout(function() {
      $('.messages .alert button.close').click();
    }, 3000);
  };
  messageButton.attr('data-dismiss', '');
  messageButton.on('click', function(e) {
    var parent = $(this).parent();
    parent.removeClass('show');
    parent.addClass('hide');
    parent.fadeOut('hide');
  });
  autoCloseMessage();

  var showMessage = function(message, type) {
    type = type || 'info';
    var messageContainer = $('.messages .alert-'+ type);
    messageContainer.find('button').next('span').remove();
    messageContainer.find('button').after('<span>'+ message +'</span>');
    messageContainer.removeClass('hide');
    messageContainer.addClass('show');
    messageContainer.fadeIn('slow');
    autoCloseMessage();
  };

  if (typeof myMiradorInstance !== 'undefined') {
    myMiradorInstance.eventEmitter.subscribe('mainMenuInitialized', function() {
      $('.save').on('click', function(){
        var currentConfig = myMiradorInstance.saveController.currentConfig;
        var workspaceUpdateUrl = $('#viewer').data('workspace-update-url');

        var updateData = {
          "workspace": {
            "data": JSON.stringify(currentConfig, replacer)
          }
        };

        $.ajax({
          url: workspaceUpdateUrl,
          type: "PUT",
          data: updateData,
          beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
          success: function(data) {
            showMessage('Workspace saved.');
          },
          error: function(data) {
            showMessage('There was an error saving the current workspace.', 'danger');
          }
        });
      });
    });
  }
});

function simpleStringify (object){
    var simpleObject = {};
    for (var prop in object ){
        if (!object.hasOwnProperty(prop)){
            continue;
        }
        if (typeof(object[prop]) === 'object'){
            continue;
        }
        if (typeof(object[prop]) === 'function'){
            continue;
        }
        simpleObject[prop] = object[prop];
    }
    return JSON.stringify(simpleObject);
}

seen = [];

var replacer = function(key, value) {
    if (value !== null && typeof value === "object") {
        if (seen.indexOf(value) >= 0) {
            return;
        }
        seen.push(value);
    }
    return value;
};