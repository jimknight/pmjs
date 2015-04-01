<project_show>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class='row'>
      <h2>{this.email_id}</h2>
      <div class='six wide column'>
        <email_list emails={emails} email_id={email_id}></email_list>
      </div>
      <div class='ten wide column'>
        <displayed_email emails={emails} email_id={email_id}></displayed_email>
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
          this.update({ emails: data });
        }.bind(this),
        error: function(xhr, status, err) {
          console.error('http://localhost:3000/projects/' + this.project_id + '/emails.json', status, err.toString());
        }.bind(this)
      });
    };
    selectEmail(updated_email_id) {
      console.log(updated_email_id);
      this.update({email_id: 'jimbo'})
      // this.update({email_id: updated_email_id});
      // return true;
      console.log("parent");
    }
    this.emails     = [];
    this.email      = [];
    this.email_id   = opts.email_id;
    this.project_id = opts.project_id;
    this.loadEmailsFromServer();
  </script>

</project_show>