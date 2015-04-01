riot.tag('email_task_action_buttons', '<div if="{ opts.status==\'Open\' }" class="ui icon button pop checkmark" onclick="{ markTaskComplete }" data-content="Mark task complete"> <i class="checkmark icon"></i> </div> <div class="ui icon button pop remove" data-content="Cancel task"> <i class="remove icon"></i> </div> <div class="ui icon button pop trash" onclick="{ deleteTask }" data-content="Delete task"> <i class="trash icon"></i> </div>', function(opts) {
    this.project_show = this.parent.parent.parent.parent.parent;
    this.task_id = opts.id;
    this.markTaskComplete = function() {
      this.project_show.markTaskComplete(this.task_id);
    }.bind(this);
    this.deleteTask = function() {
      this.project_show.deleteTask(this.task_id);
    }.bind(this);
  
});

riot.tag('email_task', '<i class="circle thin icon red large"></i> <div class="actionbuttons"> <email_task_action_buttons id="{this.parent.id}" status="{this.parent.status}"></email_task_action_buttons> </div> <div class="header"> {title} {status} </div> <div class="meta">Created 3 days ago</div> <div class="content"> Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. </div>', function(opts) {
    this.markTaskComplete = function() {
      task_id = this.id;
      this.parent.parent.parent.parent.markTaskComplete(task_id);
    }.bind(this);


    this.on('mount', function() {
      var $node = $(this.root);
      $node.find('.pop').popup();
    });
  
});

riot.tag('email_tasks_list', '<div class="ui item"> <email_task each="{opts.globals.email.tasks}"></email_task> </div>', function(opts) {

});

riot.tag('displayed_email', '<div class="ui message dimmable"> <div class="ui inverted dimmer"> <div class="ui fluid form segment"> <div class="two fields"> <div class="field"> <label>First Name</label> <input placeholder="First Name" type="text"> </div> <div class="field"> <label>Last Name</label> <input placeholder="Last Name" type="text"> </div> </div> <div class="field"> <label>User Text</label> <textarea></textarea> </div> <div class="ui submit button">Submit</div> <div class="ui button">Cancel</div> </div> </div> <table style="margin-bottom:10px;width:100%;"> <tr> <td style="padding-right:7px;width:30px"> <i class="user circular icon large" id="email-avatar"></i> </td> <td style="width:200px;"> {opts.globals.email_id} {opts.globals.email.sent_from}  <br>sent 5 minutes ago </td> <td style="text-align:right;"> <div class="pop ui icon button" data-content="Create a task from this email" onclick="$(\'.dimmable\').dimmer(\'show\');return false;"> <i class="plus icon"></i> </div> <div class="pop ui icon button trash" data-content="Delete this email"> <i class="trash icon"></i> </div> </td> </tr> </table> <div class="header"> {opts.globals.email.subject} </div> <div class="content"> {opts.globals.email.body_plain} <h4 class="ui horizontal header divider"> <i class="tasks icon"></i> Tasks </h4> <div class="ui divided items" id="emailtasks"> <email_tasks_list globals="{opts.globals}"></email_tasks_list> </div> </div> </div>', function(opts) {
    this.on('mount', function() {
      var $node = $(this.root);
      $node.find('.pop').popup();
    });
  
});