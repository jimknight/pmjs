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
        <!-- <displayed_email emails={emails} email_id={email_id}></displayed_email> -->
      </div>
    </div>
  </div>

  <script>
    findEmail (arr, propName, propValue) {
      console.log("find");
      for (var i=0; i < arr.length; i++)
        if (arr[i][propName] == propValue)
          return arr[i];
        else
          return arr[0];
    };
    loadEmailsFromServer() {
      $.ajax({
        url: 'http://localhost:3000/projects/' + this.project_id + '/emails.json',
        dataType: 'json',
        success: function(data) {
          this.globals.emails = data;
          this.update();
        }.bind(this),
        error: function(xhr, status, err) {
          console.error('http://localhost:3000/projects/' + this.project_id + '/emails.json', status, err.toString());
        }.bind(this)
      });
    };
    this.globals = {
      emails: [],
      email_id: opts.email_id
    };
    this.email_id   = opts.email_id;
    this.project_id = opts.project_id;
    this.loadEmailsFromServer();
    riot.route(function(projects, project_id, emails, email_id) {
      this.globals.email_id = email_id;
      this.update();
    }.bind(this));
  </script>

</project_show>