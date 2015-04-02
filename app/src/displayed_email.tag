<displayed_email>
  <div class="ui message dimmable">
    <div class="ui inverted dimmer">
      <new_task_form globals={globals}></new_task_form>
    </div>
    <table style="margin-bottom:10px;width:100%;">
      <tr>
        <td style="padding-right:7px;width:30px">
          <i class="user circular icon large" id="email-avatar"></i>
        </td>
        <td style="width:200px;">
          {opts.globals.email.sent_from}
          <!-- {this.findEmail(this.globals.emails,'id',this.globals.email_id)} -->
          <br/>sent 5 minutes ago
        </td>
        <td style="text-align:right;">
          <div class="pop ui icon button" data-content="Create a task from this email" onclick="$('.dimmable').dimmer('show');return false;">
            <i class="plus icon"></i>
          </div>
          <div class="pop ui icon button trash" data-content="Delete this email">
            <i class="trash icon"></i>
          </div>
        </td>
      </tr>
    </table>
    <div class="header">
      {opts.globals.email.subject}
    </div>
    <div class="content">
      {opts.globals.email.body_plain}
      <h4 class="ui horizontal header divider">
        <i class="tasks icon"></i>
        Tasks
      </h4>
      <div class="ui divided items" id="emailtasks">
        <email_tasks_list globals={opts.globals}></email_tasks_list>
      </div>
    </div>
  </div>

  <script>
    this.on('mount', function() {
      var $node = $(this.root);
      $node.find('.pop').popup();
    });
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
    this.project_show = this.parent.parent;
    saveBtn() {
      $('#newtaskform')
      .form({
        name: {
          identifier  : 'title',
          rules: [
            {
              type   : 'empty',
              prompt : 'Title is required'
            }
          ]
        }
      });
      if ($('#newtaskform').form('validate form')) {
        // do the ajax here and get the response to add
        random_id = Math.floor((Math.random() * 1000) + 1);
        new_task = { id: random_id, mode: "read", status: "Open", title: $("#newtaskform input").val() };
        this.project_show.addNewTask(new_task);
        $('#newtaskform').form('reset');
        $('#newtaskform input').val("");
        $('#newtaskform textarea').val("");
        $('.dimmable').dimmer('hide');
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

<email_tasks_list>
  <div class="ui item">
    <email_task each={opts.globals.email.tasks}></email_task>
  </div>
</email_tasks_list>

<email_task>
  <i class="circle thin icon red large"></i>
  <div class="actionbuttons">
    <email_task_action_buttons id={this.parent.id} status={this.parent.status}></email_task_action_buttons>
  </div>
  <div class="header">
    {title} {status}
  </div>
  <div class="meta">Created 3 days ago</div>
  <div class="content">
    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
  </div>
  <script>
    markTaskComplete() {
      task_id = this.id;
      this.parent.parent.parent.parent.markTaskComplete(task_id);
    };
    // this.parent.parent.parent.parent.globals.emails[0].tasks[0].status="Closed";
    // this.update();
    this.on('mount', function() {
      var $node = $(this.root);
      $node.find('.pop').popup();
    });
  </script>
</email_task>

<email_task_action_buttons>
  <div if={ opts.status=='Open' } class="ui icon button pop checkmark" onclick={ markTaskComplete } data-content="Mark task complete">
    <i class="checkmark icon"></i>
  </div>
  <div class="ui icon button pop remove" data-content="Cancel task">
    <i class="remove icon"></i>
  </div>
  <div class="ui icon button pop trash" onclick={ deleteTask } data-content="Delete task">
    <i class="trash icon"></i>
  </div>
  <script>
    // this is crazy but only way I know how now
    this.project_show = this.parent.parent.parent.parent.parent;
    this.task_id = opts.id;
    markTaskComplete() {
      this.project_show.markTaskComplete(this.task_id);
    };
    deleteTask() {
      this.project_show.deleteTask(this.task_id);
    }
  </script>
</email_task_action_buttons>