<projects_index>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class='row'>
      <h1>Your Projects</h1>
      <project_selector each={projects}></project_selector>
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
          console.error(getProjectsUrl, status, err.toString());
        }.bind(this)
      });
    };
    this.loadProjectsFromServer();
  </script>
</projects_index>

<project_selector>
  <div class='ui divided items'>
    <div class='ui grid'>
      <div class='one wide column'>
        <i class='circular user icon large'></i>
      </div>
      <div class='fifteen wide column'>
        <div class='content'>
          <a class='header' href={'#projects/' + id}>{title}</a>
          <div class='meta'>
            <span class='cinema'>created 5 minutes ago</span>
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