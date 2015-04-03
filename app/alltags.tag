<app>
  <div id='container'>
    <a href="/#projects">Projects</a>
  </div>
  <script>
    riot.route( function(projects,project_id,emails,email_id) {
      if (emails) {return false;};
      if (projects== 'projects') {
        $('#container').html('<projects_index></projects_index>');
        riot.mount('projects_index');
      };
      if (project_id) {
        $('#container').html('<project_show></project_show>');
        riot.mount('project_show',{project_id: project_id});
      }
    });
  </script>
</app>
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
          {this.globals.email.sent_from}
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
      {this.globals.email.subject}
    </div>
    <div class="content">
      {this.globals.email.body_plain}
      <h4 class="ui horizontal header divider">
        <i class="tasks icon"></i>
        Tasks
      </h4>
      <div class="ui divided items" id="emailtasks">
        <email_tasks_list></email_tasks_list>
      </div>
    </div>
  </div>
  <script>
    this.globals = this.parent.globals;
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
              content: data.content };
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
<email_list>
  <div class='ui divided items' id="emaillist">
    <email_selector each={this.globals.emails} data="{ this }"></email_selector>
  </div>
  <script>
    this.globals = this.parent.globals;
  </script>
</email_list>

<email_selector>
  <div class={this.globals.email_id == id ? 'item active' : 'item'}>
    <div class='ui grid'>
      <div class='two wide column'>
        <i class='circular user icon large'></i>
      </div>
      <div class='fourteen wide column'>
        <div class='content'>
          <a class='header' href={'#projects/23/emails/' + id}>{subject}</a>
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
    this.globals = opts.data.parent.globals;
    bodyText(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    };
  </script>
</email_selector>
<email_tasks_list>
  <div class="ui item">
    <email_task each={this.globals.email.tasks} data={ this }></email_task>
  </div>
  <script>
    this.globals = this.parent.globals;
  </script>
</email_tasks_list>

<email_task>
  <!-- Display -->
  <i class="circle thin icon red large"></i>
  <div class="actionbuttons">
    <email_task_action_buttons></email_task_action_buttons>
  </div>
  <div class="header">
    {title} {status}
  </div>
  <div class="meta">Created 3 days ago</div>
  <div class="content">
    {content}
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
          "_method":"delete"
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
<navigation>
  <div class='ui menu inverted'>
    <a class='active item'>
      <i class='home icon'></i> Home
    </a>
    <a class='item' href='#projects'>
      <i class='list layout icon'></i> Projects
    </a>
    <div class='right menu'>
      <div class='item'>
        <div class='ui transparent icon input'>
          <input type='text' placeholder='Search...'>
          <i class='search link icon'></i>
        </div>
      </div>
    </div>
  </div>
</navigation>
<project_show>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class='row'>
      <div class='six wide column'>
        <email_list></email_list>
      </div>
      <div class='ten wide column'>
        <displayed_email></displayed_email>
      </div>
    </div>
  </div>

  <script>
    findBy (arr, propName, propValue) {
      for (var i=0; i < arr.length; i++) {
        if (arr[i][propName] == propValue) {
          return arr[i];
        }
      }
      return arr[0];
    };
    loadEmailsFromServer() {
      $.ajax({
        url: 'http://localhost:3000/api/v1/projects/' + this.globals.project_id + '/emails.json',
        dataType: 'json',
        success: function(data) {
          this.globals.emails = data;
          this.globals.email = data[0];
          this.update();
        }.bind(this),
        error: function(xhr, status, err) {
          console.error('http://localhost:3000/api/v1/projects/' + this.globals.project_id + '/emails.json', status, err.toString());
        }.bind(this)
      });
    };
    // addNewTask(task) {
    //   this.globals.email.tasks.unshift(task);
    //   this.update();
    // };
    // deleteTask(task_id) {
    //   task = this.findBy(this.globals.email.tasks,'id',task_id);
    //   var index = this.globals.email.tasks.indexOf(task);
    //   this.globals.email.tasks.splice(index, 1);
    //   this.update();
    // };
    this.globals = {
      emails: [],
      email_id: opts.email_id,
      project_id: opts.project_id,
      email: {}
    };
    riot.route(function(projects, project_id, emails, email_id) {
      this.globals.email_id = email_id;
      this.globals.project_id = project_id;
      // console.log(email_id);
      this.globals.email = this.findBy(this.globals.emails,'id',email_id);
      // console.log(this.globals);
      riot.update();
    }.bind(this));
    this.loadEmailsFromServer();
  </script>

</project_show>
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
<riot-tabs>
  <h2>Tabs</h2>
  <ul>
    <li class={ tabItem: true }>Tab 1</li>
    <li class={ tabItem: true }>Tab 2</li>
    <li class={ tabItem: true }>Tab 3</li>
  </ul>
</riot-tabs>
<todo>

  <h3>{ opts.title }</h3>

  <ul>
    <li each={ items.filter(filter) }>
      <label class={ completed: done }>
        <input type="checkbox" checked={ done } onclick={ parent.toggle }> { title }
      </label>
    </li>
  </ul>

  <form onsubmit={ add }>
    <input name="input" onkeyup={ edit }>
    <button disabled={ !text }>Add #{ items.filter(filter).length + 1 }</button>
  </form>

  <!-- this script tag is optional -->
  <script>
    this.items = opts.items

    edit(e) {
      this.text = e.target.value
    }

    add(e) {
      if (this.text) {
        this.items.push({ title: this.text })
        this.text = this.input.value = ''
      }
    }

    // an example how to filter items on the list
    filter(item) {
      return !item.hidden
    }

    toggle(e) {
      var item = e.item
      item.done = !item.done
      return true
    }
  </script>

</todo>
