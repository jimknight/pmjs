riot.tag('project_show', '<div class="ui page grid"> <div class="row"> <navigation></navigation> </div> <div class="row"> <h2>{globals.email_id}</h2> <div class="six wide column"> <email_list globals="{globals}"></email_list> </div> <div class="ten wide column"> <displayed_email globals="{globals}"></displayed_email> </div> </div> </div>', function(opts) {
    this.findBy = function(arr, propName, propValue) {
      for (var i=0; i < arr.length; i++) {
        if (arr[i][propName] == propValue) {
          return arr[i];
        }
      }
      return arr[0];
    }.bind(this);
    this.loadEmailsFromServer = function() {
      $.ajax({
        url: 'http://localhost:3000/projects/' + this.project_id + '/emails.json',
        dataType: 'json',
        success: function(data) {
          this.globals.emails = data;
          this.globals.email = data[0];
          this.update();
        }.bind(this),
        error: function(xhr, status, err) {
          console.error('http://localhost:3000/projects/' + this.project_id + '/emails.json', status, err.toString());
        }.bind(this)
      });
    }.bind(this);
    this.markTaskComplete = function(task_id) {
      task = this.findBy(this.globals.email.tasks,'id',task_id);
      task.status = "Complete"

      this.update();
    }.bind(this);
    this.globals = {
      emails: [],
      email_id: opts.email_id,
      email: {}
    };
    this.email_id   = opts.email_id;
    this.project_id = opts.project_id;
    this.loadEmailsFromServer();
    riot.route(function(projects, project_id, emails, email_id) {
      this.globals.email = this.findBy(this.globals.emails,'id',email_id);
      this.globals.email_id = email_id;
      this.update();
    }.bind(this));
  
});