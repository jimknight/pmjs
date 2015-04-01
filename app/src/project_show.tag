<project_show>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class='row'>
      <div class='six wide column'>
        <email_list emails={emails}></email_list>
      </div>
      <div class='ten wide column'>
        <displayed_email></displayed_email>
      </div>
    </div>
  </div>

  <script>
    loadEmailsFromServer() {
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
    }
    this.emails = [];
    this.loadEmailsFromServer();
  </script>

</project_show>