<displayed_email>
  <div class="ui message dimmable" id="displayedemail">
    <div class="ui inverted dimmer">
      <new_task_form globals={globals}></new_task_form>
    </div>
    <div class="pop ui icon button" data-content="Create a task" onclick={ createTaskBtn }>
      <i class="plus icon"></i>
    </div>
    <div id="displayedemaildetails" if={ this.globals.email_id > 0 }>
      <table style="margin-bottom:10px;width:100%;">
        <tr>
          <td style="padding-right:7px;width:30px">
            <i class="user circular icon large" id="email-avatar"></i>
          </td>
          <td style="width:200px;">
            {this.globals.email.sent_from}
            <br/>{this.globals.email.created_at_pretty}
          </td>
          <td style="text-align:right;">
            <div class="pop ui icon button" data-content="Create a task" onclick={ createTaskBtn }>
              <i class="plus icon"></i>
            </div>
            <div class="pop ui icon button trash" data-content="Delete this email" onclick={ deleteEmail }>
              <i class="trash icon"></i>
            </div>
          </td>
        </tr>
      </table>
      <div class="header">
        {this.globals.email.subject}
      </div>
      <div class="content">
        {this.globals.email.body_plain}
      </div>
    </div>
    <h4 class="ui horizontal header divider">
      <i class="tasks icon"></i>
      Tasks
    </h4>
    <div class="ui divided items" id="emailtasks">
      <email_tasks_list></email_tasks_list>
    </div>
  </div>
  <script>
    this.globals = this.parent.globals;
    this.on('mount', function() {
      var $node = $(this.root);
      $node.find('.pop').popup();
    });
    createTaskBtn() {
      $('.dimmable').dimmer('show');
    };
    findBy (arr, propName, propValue) {
      for (var i=0; i < arr.length; i++) {
        if (arr[i][propName] == propValue) {
          return arr[i];
        }
      }
      return arr[0];
    };
    deleteEmail() {
      // TODO Are you sure?
      postEmailUrl = "http://localhost:3000/api/v1/emails/" + this.globals.email.id;
      $.ajax({
        url: postEmailUrl,
        dataType: 'json',
        type: 'POST',
        data: {
          '_method':'delete',
          'id': this.globals.email.id
        },
        success: function(data) {
          console.log(data);
          email = this.findBy(this.globals.emails,'id',this.globals.email.id);
          var index = this.globals.emails.indexOf(email);
          this.globals.emails.splice(index, 1);
          // TODO figure out the next email
          riot.route('projects/' + this.globals.project_id);
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(postEmailUrl, status, err.toString());
        }
      });
    }.bind(this);
  </script>
</displayed_email>

<new_task_form>
  <div class="ui form segment" id="newtaskform">
    <div class="ui corner labeled input field">
      <input placeholder="Task title" type="text" name="title" autofocus>
      <div class="ui corner label">
        <i class="asterisk icon red"></i>
      </div>
    </div>
    <div class="field">
      <textarea placeholder="Task details" name="content"></textarea>
    </div>
    <div class="ui primary submit button" onclick={ saveBtn }>Save</div>
    <div class="ui button" onclick={ cancelBtn }>Cancel</div>
  </div>
  <script>
    this.globals = this.parent.globals;
    addNewTask(task) {
      this.globals.email.tasks.unshift(task);
      riot.update();
    };
    saveBtn() {
      $('#newtaskform')
        .form({
          name: {
            identifier: 'title',
            rules: [{type: 'empty',prompt: 'Title is required'}]
          }
        });
      if ($('#newtaskform').form('validate form')) {
        postTaskUrl = "http://localhost:3000/api/v1/tasks";
        $.ajax({
          url: postTaskUrl,
          dataType: 'json',
          type: 'POST',
          data: {
            task: {
              title: $('#newtaskform input').val(),
              content: $('#newtaskform textarea').val(),
              status: 'Open',
              email_id: this.globals.email_id
            }
          },
          success: function(data) {
            new_task = {
              id: data.id,
              mode: "read",
              status: "Open",
              title: data.title,
              content: data.content,
              created_at_pretty: data.created_at_pretty};
            this.addNewTask(new_task);
            $('.dimmable').dimmer('hide');
            $('#newtaskform').form('reset');
            $('#newtaskform input').val("");
            $('#newtaskform textarea').val("");
          }.bind(this),
          error: function(xhr, status, err) {
            console.error(postTaskUrl, status, err.toString());
          }.bind(this)
        });
      } else {
        $('#newtaskform input').focus();
        return false;
      }
    };
    cancelBtn() {
      $('.dimmable').dimmer('hide');
    };
  </script>
</new_task_form>