<projects_index>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class='row'>
      <div class="eight wide column">
        <h1>Your Projects</h1>
        <project_selector each={projects}></project_selector>
      </div>
      <div class="eight wide column">
        <h1>What's happening?</h1>
        <feed></feed>
      </div>
    </div>
  </div>
  <script>
    this.projects = [];
    loadProjectsFromServer() {
      getProjectsUrl='http://localhost:3000/api/v1/projects.json';
      $.ajax({
        url: getProjectsUrl,
        dataType: 'json',
        success: function(data) {
          this.projects = data;
          this.update();
        }.bind(this),
        error: function(xhr, status, err) {
          // Login
          if (err.toString() == "Unauthorized") {
            riot.route('login');
          } else {
            console.error(getProjectsUrl, status, err.toString());
          }
        }.bind(this)
      });
    };
    this.loadProjectsFromServer();
  </script>
</projects_index>

<project_selector>
  <div class='ui divided items'>
    <div class='ui grid'>
      <div class='two wide column'>
        <i class='circular user icon large'></i>
      </div>
      <div class='fourteen wide column'>
        <div class='content'>
          <a class='header' href={'#projects/' + id}>{title}</a>
          <div class='meta'>
            <span class='cinema'>created {created_at_pretty}</span>
          </div>
          <div class='description'>
            <p>
              {shorten(description)}<br>
              <a href=mailto:{email}>{email}</a>
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script>
    shorten(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    };
  </script>
</project_selector>