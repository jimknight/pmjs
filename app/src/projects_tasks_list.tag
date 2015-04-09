<projects_tasks_list>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class='row'>
      <div class='six wide column'>
        <h1>{this.project_title} tasks</h1>
        <project_task each={this.project.tasks}></project_task>
      </div>
      <div class='ten wide column'>

      </div>
    </div>
  </div>
  <script>
    // go get all the tasks for the project
    this.section = 'Projects';
    this.projects = [];
    loadProjectsFromServer() {
      getProjectsUrl='http://localhost:3000/api/v1/projects/' + this.opts.project_id + '.json';
      $.ajax({
        url: getProjectsUrl,
        dataType: 'json',
        success: function(data) {
          console.log(data);
          this.project_title = data.title;
          this.project = data;
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
</projects_tasks_list>

<project_task>
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
              {shorten(content)}
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
</project_task>