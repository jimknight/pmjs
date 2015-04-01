<project_show>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class='row'>
      <h2>{globals.email_id}</h2>
      <div class='six wide column'>
        <email_list globals={globals}></email_list>
      </div>
      <div class='ten wide column'>
        <displayed_email globals={globals}></displayed_email>
      </div>
    </div>
  </div>

  <script>
    findBy (arr, propName, propValue) {
      for (var i=0; i < arr.length; i++) {
        if (arr[i][propName] == propValue) {
          return arr[i];
        }
      }
      return arr[0];
    };
    loadEmailsFromServer() {
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
    };
    deleteTask(task_id) {
      task = this.findBy(this.globals.email.tasks,'id',task_id);
      var index = this.globals.email.tasks.indexOf(task);
      this.globals.email.tasks.splice(index, 1);
      this.update();
    };
    markTaskComplete(task_id) {
      task = this.findBy(this.globals.email.tasks,'id',task_id);
      task.status = "Complete"
      // do some ajax
      this.update();
    };
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
  </script>

</project_show>