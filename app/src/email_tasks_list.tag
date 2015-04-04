<email_tasks_list>
  <email_task each={this.globals.email.tasks} data={ this }></email_task>
  <script>
    this.globals = this.parent.globals;
  </script>
</email_tasks_list>

<email_task>
  <!-- Display -->
  <div class="ui item">
    <i class="circle thin icon red large"></i>
    <div class="actionbuttons">
      <email_task_action_buttons></email_task_action_buttons>
    </div>
    <div class="header">
      {title} {status}
    </div>
    <div class="meta">created {created_at_pretty}</div>
    <div class="content">
      {content}
    </div>
  </div>
  <!-- Logic -->
  <script>
    this.globals = opts.data.parent.globals;
  </script>
</email_task>

<email_task_action_buttons>
  <div if={ this.parent.status=='Open' } class="ui icon button pop checkmark" onclick="{ markTaskComplete }" data-content="Mark task complete">
    <i class="checkmark icon"></i>
  </div>
<!--   <div class="ui icon button pop remove" data-content="Cancel task">
    <i class="remove icon"></i>
  </div> -->
  <div class="ui icon button pop trash" onclick={ deleteTask } data-content="Delete task">
    <i class="trash icon"></i>
  </div>
  <script>
    this.globals = this.parent.globals;
    findBy (arr, propName, propValue) {
      for (var i=0; i < arr.length; i++) {
        if (arr[i][propName] == propValue) {
          return arr[i];
        }
      }
      return arr[0];
    };
    deleteTask() {
      // delete the task from rails
      postTaskUrl = "http://localhost:3000/api/v1/tasks/" + this.parent.id;
      $.ajax({
        url: postTaskUrl,
        dataType: 'json',
        type: 'POST',
        data: {
          '_method':'delete',
          'id':this.parent.id
        },
        success: function(data) {
          task = this.findBy(this.globals.email.tasks,'id',this.parent.id);
          var index = this.globals.email.tasks.indexOf(task);
          this.globals.email.tasks.splice(index, 1);
          riot.update();
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(postTaskUrl, status, err.toString());
        }
      });
    }.bind(this);
    markTaskComplete() {
      postTaskUrl = "http://localhost:3000/api/v1/tasks/" + this.parent.id + "/completed";
      $.ajax({
        url: postTaskUrl,
        dataType: 'json',
        type: 'POST',
        data: {
          task: {
            status: 'Completed'
          }
        },
        success: function(data) {
          task = this.findBy(this.globals.email.tasks,'id',this.parent.id)
          task.status = 'Completed';
          riot.update();
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(postTaskUrl, status, err.toString());
        }.bind(this)
      });
    }.bind(this);
    this.on('mount', function() {
      var $node = $(this.root);
      $node.find('.pop').popup();
    });
  </script>
</email_task_action_buttons>