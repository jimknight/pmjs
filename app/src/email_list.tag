<email_selector>
  <div class='item'>
    <div class='ui grid'>
      <div class='two wide column'>
        <i class='circular user icon large'></i>
      </div>
      <div class='fourteen wide column'>
        <div class='content'>
          <a class='header'>{subject}</a>
          <div class='meta'>
            <span class='cinema'>from {sent_from} 5 minutes ago</span>
          </div>
          <div class='description'>
            <p>{bodyText(body_plain)}</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script>
    bodyText(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    };
  </script>

</email_selector>

<email_list>
  <div class='ui divided items'>
    <email_selector each={emails}></email_selector>
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

</email_list>