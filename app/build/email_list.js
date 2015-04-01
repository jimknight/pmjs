riot.tag('email_selector', '<div class="item"> <div class="ui grid"> <div class="two wide column"> <i class="circular user icon large"></i> </div> <div class="fourteen wide column"> <div class="content"> <a class="header">{subject}</a> <div class="meta"> <span class="cinema">from {sent_from} 5 minutes ago</span> </div> <div class="description"> <p>{bodyText(body_plain)}</p> </div> </div> </div> </div> </div>', function(opts) {
    this.bodyText = function(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    }.bind(this);
  
});

riot.tag('email_list', '<div class="ui divided items"> <email_selector each="{emails}"></email_selector> </div>', function(opts) {

  this.loadEmailsFromServer = function() {

    $.ajax({
      url: 'http://localhost:3000/projects/23/emails.json',
      dataType: 'json',
      success: function(data) {
        this.update({ emails: data });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error('http://localhost:3000/projects/23/emails.json', status, err.toString());
      }.bind(this)
    });
  }.bind(this);

  this.emails = [];
  this.loadEmailsFromServer();

  
});