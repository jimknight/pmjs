<projects_new>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class='row'>
      <div class="eight wide column">
        <h1>New Project</h1>
        <form class="ui form segment" id="newprojectform" onsubmit={saveBtn}>
          <div class="ui error message"></div>
          <div class="ui corner labeled input field">
            <input type="text" name="title" placeholder="Project title">
            <div class="ui corner label">
              <i class="asterisk icon red"></i>
            </div>
          </div>
          <div class="ui corner labeled input field">
            <input type="email" name="email" placeholder="Project email address">
            <div class="ui corner label">
              <i class="asterisk icon red"></i>
            </div>
          </div>
          <div class="field">
            <textarea name="description" placeholder="Project description"></textarea>
          </div>
          <input class="ui button primary" type="submit" value="Save">
          <button class="ui button" onclick={cancelBtn}>Cancel</button>
        </form>
      </div>
    </div>
  </div>
  <script>
    cancelBtn() {
      history.back();
    };
    saveBtn() {
      $('#newprojectform')
        .form({
          title: {
            identifier: 'title',
            rules: [{type: 'empty',prompt: 'Project title is required'}]
          },
          email: {
            identifier: 'email',
            rules: [{type: 'empty',prompt: 'Project email is required'}]
          }
        });
      if ($('#newprojectform').form('validate form')) {
        postProjectUrl = "http://localhost:3000/api/v1/projects";
        $.ajax({
          url: postProjectUrl,
          dataType: 'json',
          type: 'POST',
          data: {
            project: {
              title: this.title.value,
              email: this.email.value,
              description: this.description.value
            }
          },
          success: function(data) {
            console.log(data);
            riot.route('#projects')
            // add new project
            // new_task = {
            //   id: data.id,
            //   mode: "read",
            //   status: "Open",
            //   title: data.title,
            //   content: data.content,
            //   created_at_pretty: data.created_at_pretty};
            // this.addNewTask(new_task);
          }.bind(this),
          error: function(xhr, status, err) {
            console.error(postProjectUrl, status, err.toString());
          }.bind(this)
        });
      } else {
        $('#newprojectform input').focus();
        return false;
      }
    };
  </script>
</projects_new>