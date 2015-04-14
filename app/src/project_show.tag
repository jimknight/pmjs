<project_show>
  <div class="ui vertical segment" id="header">
      <div class="ui page grid">
        <div class='row'>
          <navigation></navigation>
        </div>
      </div>
    </div>
  </div>
  <br>
  <div class='ui page grid'>
    <div class='row'>
      <div class='four wide column'>
        <email_list></email_list>
      </div>
      <div class='eight wide column'>
        <displayed_email></displayed_email>
      </div>
      <div class='four wide column'>
        <div class="ui divided items" id="emailtasks">
          <email_tasks_list></email_tasks_list>
        </div>
      </div>
    </div>
  </div>

  <script>
    this.section = 'Projects';
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
        url: 'http://localhost:3000/api/v1/projects/' + this.globals.project_id + '/emails.json',
        dataType: 'json',
        success: function(data) {
          if (data.toString() == '') {
            this.globals.email_id = 0;
          } else {
            this.globals.emails = data;
            if (opts.email_id) {
              this.globals.email = this.findBy(data,'id',opts.email_id);
            } else {
              this.globals.email = data[0];
              this.globals.email_id = data[0].id;
            };
          }
          riot.update();
        }.bind(this),
        error: function(xhr, status, err) {
          console.error('http://localhost:3000/api/v1/projects/' + this.globals.project_id + '/emails.json', status, err.toString());
        }.bind(this)
      });
    };
    this.globals = {
      emails: [],
      email_id: opts.email_id,
      project_id: opts.project_id,
      email: {}
    };
    riot.route(function(projects, project_id, emails, email_id) {
      this.globals.email_id = email_id;
      this.globals.project_id = project_id;
      // console.log(email_id);
      this.globals.email = this.findBy(this.globals.emails,'id',email_id);
      // console.log(this.globals);
      riot.update();
    }.bind(this));
    this.loadEmailsFromServer();
  </script>

</project_show>