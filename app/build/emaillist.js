riot.tag('leftcol', '<div class="ui divided items"> <div class="item"> <div class="ui grid"> <div class="two wide column"> <i class="circular user icon large"></i> </div> <div class="fourteen wide column"> <div class="content"> <a class="header">FW: Please perform this task</a> <div class="meta"> <span class="cinema">From Wayne Scarano 5 minutes ago</span> </div> <div class="description"> <p>Jim, please take care of this item for me asap...</p> </div> </div> </div> </div> </div> <div class="item"> <div class="ui grid"> <div class="two wide column"> <i class="circular user icon large"></i> </div> <div class="fourteen wide column"> <div class="content"> <a class="header">FW: Please perform this task</a> <div class="meta"> <span class="cinema">From Wayne Scarano 5 minutes ago</span> </div> <div class="description"> <p>Jim, please take care of this item for me asap...</p> </div> </div> </div> </div> </div> </div>', function(opts) {

  this.loadEmailsFromServer = function() {

    $.ajax({
      url: 'http://localhost:3000/projects/23/emails.json',
      dataType: 'json',
      success: function(data) {
        this.update({ emails: data });
        console.log(data);
      }.bind(this),
      error: function(xhr, status, err) {
        console.error('http://localhost:3000/projects/23/emails.json', status, err.toString());
      }.bind(this)
    });
  }.bind(this);

  this.emails = [];
  this.loadEmailsFromServer();

  
});