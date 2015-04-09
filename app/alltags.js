riot.tag('app', '', function(opts) {
    $.auth.configure({apiUrl: 'http://localhost:3000/api/v1'});
    riot.route( function(projects,project_id,emails,email_id) {
      if (emails == 'tasks') {
        console.log('tasks');
        $('app').html('<project_tasks_list></project_tasks_list>');
        riot.mount('project_tasks_list',{project_id: project_id});
      } else if (emails) {return false};
      if (projects == 'login') {
        $('app').html('<login></login>');
        riot.mount('login');
      };
      if (projects== 'projects') {
        $('app').html('<projects_index></projects_index>');
        riot.mount('projects_index');
      };
      if (project_id) {
        $('app').html('<project_show></project_show>');
        riot.mount('project_show',{project_id: project_id});
      }
    });
    riot.route.exec( function(projects,project_id,emails,email_id) {
      if (projects == 'login') {
        $('app').html('<login></login>');
        riot.mount('login');
      };
      if (emails == 'tasks') {
        console.log('tasks esec');
        $('app').html('<projects_tasks_list></projects_tasks_list>');
        riot.mount('projects_tasks_list',{project_id: project_id});
        return true;
      };
      if (!projects || projects== 'projects') {
        $('app').html('<projects_index></projects_index>');
        riot.mount('projects_index');
      };
      if (project_id) {
        $('app').html('<project_show></project_show>');
        riot.mount('project_show',{project_id: project_id});
      };
      if (emails) {
        $('app').html('<project_show></project_show>');
        riot.mount('project_show',{email_id: email_id,project_id: project_id});
      };
    });
  
});
riot.tag('displayed_email', '<div class="ui message dimmable" id="displayedemail"> <div class="ui inverted dimmer"> <new_task_form globals="{globals}"></new_task_form> </div> <div if="{ this.globals.email_id == 0 }" class="pop ui icon button" data-content="Create a task" onclick="{ createTaskBtn }"> <i class="plus icon"></i> </div> <div id="displayedemaildetails" if="{ this.globals.email_id > 0 }"> <table style="margin-bottom:10px;width:100%;"> <tr> <td style="padding-right:7px;width:30px"> <i class="user circular icon large" id="email-avatar"></i> </td> <td style="width:200px;"> {this.globals.email.sent_from} <br>{this.globals.email.created_at_pretty} </td> <td style="text-align:right;"> <div class="pop ui icon button" data-content="Create a task" onclick="{ createTaskBtn }"> <i class="plus icon"></i> </div> <div class="pop ui icon button trash" data-content="Delete this email" onclick="{ deleteEmail }"> <i class="trash icon"></i> </div> </td> </tr> </table> <div class="header"> {this.globals.email.subject} </div> <div class="content"> {this.globals.email.body_plain} </div> </div> <h4 class="ui horizontal header divider"> <i class="tasks icon"></i> Tasks </h4> <div class="ui divided items" id="emailtasks"> <email_tasks_list></email_tasks_list> </div> </div>', function(opts) {
    this.globals = this.parent.globals;
    this.on('mount', function() {
      var $node = $(this.root);
      $node.find('.pop').popup();
    });
    this.createTaskBtn = function() {
      $('.dimmable').dimmer('show');
    }.bind(this);
    this.findBy = function(arr, propName, propValue) {
      for (var i=0; i < arr.length; i++) {
        if (arr[i][propName] == propValue) {
          return arr[i];
        }
      }
      return arr[0];
    }.bind(this);
    this.deleteEmail = function() {

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

          riot.route('projects/' + this.globals.project_id);
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(postEmailUrl, status, err.toString());
        }
      });
    }.bind(this);
  
});

riot.tag('new_task_form', '<div class="ui form segment" id="newtaskform"> <div class="ui corner labeled input field"> <input placeholder="Task title" type="text" name="title" autofocus> <div class="ui corner label"> <i class="asterisk icon red"></i> </div> </div> <div class="field"> <textarea placeholder="Task details" name="content"></textarea> </div> <div class="ui primary submit button" onclick="{ saveBtn }">Save</div> <div class="ui button" onclick="{ cancelBtn }">Cancel</div> </div>', function(opts) {
    this.globals = this.parent.globals;
    this.addNewTask = function(task) {
      this.globals.email.tasks.unshift(task);
      riot.update();
    }.bind(this);
    this.saveBtn = function() {
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
              email_id: this.globals.email_id,
              project_id: this.globals.project_id
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
    }.bind(this);
    this.cancelBtn = function() {
      $('.dimmable').dimmer('hide');
    }.bind(this);
  
});
riot.tag('email_list', '<div class="ui divided items" id="emaillist"> <div class="item" if="{ this.globals.email_id == 0 }"> No emails yet </div> <email_selector each="{this.globals.emails}" data="{ this }"></email_selector> </div>', function(opts) {
    this.globals = this.parent.globals;
  
});

riot.tag('email_selector', '<div class="{this.globals.email_id == id ? \'item active\' : \'item\'}"> <div class="ui grid"> <div class="two wide column"> <i class="circular user icon large"></i> </div> <div class="fourteen wide column"> <div class="content"> <a class="header" href="{\'#projects/\' + this.globals.project_id +\'/emails/\' + id}">{subject}</a> <div class="meta"> <span class="cinema">from {sent_from} 5 minutes ago</span> </div> <div class="description"> <p>{bodyText(body_plain)}</p> </div> </div> </div> </div> </div>', function(opts) {
    this.globals = opts.data.parent.globals;
    this.bodyText = function(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    }.bind(this);
  
});
riot.tag('email_tasks_list', '<email_task each="{this.globals.email.tasks}" data="{ this }"></email_task>', function(opts) {
    this.globals = this.parent.globals;
  
});

riot.tag('email_task', ' <div class="ui item"> <i if="{status==\'Open\'}" class="circle thin icon green large"></i> <i if="{status==\'Completed\'}" class="check circle thin icon green large"></i> <div class="actionbuttons"> <email_task_action_buttons></email_task_action_buttons> </div> <div class="header"> {title} </div> <div class="meta">created {created_at_pretty}<span if="{completion_time_pretty}">, completed {completion_time_pretty}</span></div> <div class="content"> {content} </div> </div> ', function(opts) {
    this.globals = opts.data.parent.globals;
  
});

riot.tag('email_task_action_buttons', '<div if="{ this.parent.status==\'Open\' }" class="ui icon button pop checkmark" onclick="{ markTaskComplete }" data-content="Mark task complete"> <i class="checkmark icon"></i> </div>  <div class="ui icon button pop trash" onclick="{ deleteTask }" data-content="Delete task"> <i class="trash icon"></i> </div>', function(opts) {
    this.globals = this.parent.globals;
    this.findBy = function(arr, propName, propValue) {
      for (var i=0; i < arr.length; i++) {
        if (arr[i][propName] == propValue) {
          return arr[i];
        }
      }
      return arr[0];
    }.bind(this);
    this.deleteTask = function() {

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
    this.markTaskComplete = function() {
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
          task.completion_time_pretty = data.completion_time_pretty;
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
  
});
riot.tag('feed', '<div class="ui feed"> <div class="event"> <div class="label"> </div> <div class="content"> <div class="summary"> <a class="user"> Elliot Fu </a> added you as a friend <div class="date"> 1 Hour Ago </div> </div> <div class="meta"> <a class="like"> <i class="like icon"></i> 4 Likes </a> </div> </div> </div> <div class="event"> <div class="label"> <i class="pencil icon"></i> </div> <div class="content"> <div class="summary"> You submitted a new post to the page <div class="date"> 3 days ago </div> </div> <div class="extra text"> I\'m having a BBQ this weekend. Come by around 4pm if you can. </div> <div class="meta"> <a class="like"> <i class="like icon"></i> 11 Likes </a> </div> </div> </div> <div class="event"> <div class="label"> </div> <div class="content"> <div class="date"> 4 days ago </div> <div class="summary"> <a>Helen Troy</a> added <a>2 new illustrations</a> </div> <div class="extra images"> </div> <div class="meta"> <a class="like"> <i class="like icon"></i> 1 Like </a> </div> </div> </div> <div class="event"> <div class="label"> </div> <div class="content"> <div class="summary"> <a class="user"> Jenny Hess </a> added you as a friend <div class="date"> 2 Days Ago </div> </div> <div class="meta"> <a class="like"> <i class="like icon"></i> 8 Likes </a> </div> </div> </div> <div class="event"> <div class="label"> </div> <div class="content"> <div class="summary"> <a>Joe Henderson</a> posted on his page <div class="date"> 3 days ago </div> </div> <div class="extra text"> Ours is a life of constant reruns. We\'re always circling back to where we\'d we started, then starting all over again. Even if we don\'t run extra laps that day, we surely will come back for more of the same another day soon. </div> <div class="meta"> <a class="like"> <i class="like icon"></i> 5 Likes </a> </div> </div> </div> <div class="event"> <div class="label"> </div> <div class="content"> <div class="date"> 4 days ago </div> <div class="summary"> <a>Justen Kitsune</a> added <a>2 new photos</a> of you </div> <div class="extra images"> </div> <div class="meta"> <a class="like"> <i class="like icon"></i> 41 Likes </a> </div> </div> </div> </div>', function(opts) {
    this.globals = this.parent.globals;
  
});
riot.tag('login', '<div class="ui page grid"> <div class="row"> <navigation></navigation> </div> <div class="row"> <div class="eight wide column"> <form class="ui form" onsubmit="{ clickSubmitBtn }"> <div class="ui error message"></div> <h4 class="ui dividing header">Enter your credentials</h4> <p>If you don\'t have any credentials, contact Jim</p> <div class="field"> <input type="email" name="email" placeholder="Email" value="jimknight@lavatech.com"> </div> <div class="field"> <input type="password" name="password" placeholder="Password" value="secret1234"> </div> <input class="ui submit primary button" onclick="{ clickSubmitBtn }" type="submit" value="Login"> </form> </div> </div> </div>', function(opts) {
    this.section = 'Home';
    this.clickSubmitBtn = function() {
      $('.ui.form').form({
        email: {
          identifier: 'email',
          rules: [
            {type: 'empty', prompt: 'Email is required'},
            {type: 'email', prompt: 'Please enter a valid e-mail'}
          ]
        },
        password: {
          identifier: 'password',
          rules: [
            {type: 'empty',prompt: 'Password is required'},
            {type: 'length[8]', prompt: 'Your password must be at least 8 characters'}
          ]
        }
      });
      if ($('.ui.form').form('validate form')) {
        var postLoginUrl = "http://localhost:3000/api/v1";
        $.auth.configure({apiUrl: postLoginUrl});
        $.auth.emailSignIn({
          email:    $('.ui.form input[name=email]').val(),
          password: $('.ui.form input[name=password]').val()
        })
        .then(function(){
          riot.route('projects');
        })
        .fail(function(resp){
          $("div.error").html(resp.reason).show();
          return false;
        });
      } else {
        return false;
      };
    }.bind(this);
  
});
riot.tag('navigation', '<div class="ui menu inverted"> <a class="{section == \'Home\' ? \'item active\' : \'item\'}" href="#projects"> <i class="home icon"></i> Home </a> <a class="{section == \'Projects\' ? \'item active\' : \'item\'}" href="#projects"> <i class="list layout icon"></i> Projects </a> <div class="right menu"> <div class="item"> <div class="ui icon input"> <input type="text" placeholder="Search..."> <i class="search link icon"></i> </div> </div> <a if="{ !jQuery.isEmptyObject($.auth.user) }" class="ui item" onclick="{ logOut }" id="logoutBtn"> Logout </a> </div> </div>', function(opts) {
    this.section = this.parent.section;
    this.logOut = function() {
      $.auth.signOut().then(function(){
        riot.route('#login');
      });
    }.bind(this);
  
});
riot.tag('project_show', '<div class="ui page grid"> <div class="row"> <navigation></navigation> </div> <div class="row"> <div class="six wide column"> <email_list></email_list> </div> <div class="ten wide column"> <displayed_email></displayed_email> </div> </div> </div>', function(opts) {
    this.section = 'Projects';
    this.findBy = function(arr, propName, propValue) {
      for (var i=0; i < arr.length; i++) {
        if (arr[i][propName] == propValue) {
          return arr[i];
        }
      }
      return arr[0];
    }.bind(this);
    this.loadEmailsFromServer = function() {
      $.ajax({
        url: 'http://localhost:3000/api/v1/projects/' + this.globals.project_id + '/emails.json',
        dataType: 'json',
        success: function(data) {
          if (data.toString() == '') {
            this.globals.email_id = 0;
          } else {
            this.globals.emails = data;
            if (opts.email_id) {
              this.globals.email = this.findBy(data,'id',opts.email_id);
            } else {
              this.globals.email = data[0];
              this.globals.email_id = data[0].id;
            };
          }
          riot.update();
        }.bind(this),
        error: function(xhr, status, err) {
          console.error('http://localhost:3000/api/v1/projects/' + this.globals.project_id + '/emails.json', status, err.toString());
        }.bind(this)
      });
    }.bind(this);
    this.globals = {
      emails: [],
      email_id: opts.email_id,
      project_id: opts.project_id,
      email: {}
    };
    riot.route(function(projects, project_id, emails, email_id) {
      this.globals.email_id = email_id;
      this.globals.project_id = project_id;

      this.globals.email = this.findBy(this.globals.emails,'id',email_id);

      riot.update();
    }.bind(this));
    this.loadEmailsFromServer();
  
});
riot.tag('projects_index', '<div class="ui page grid"> <div class="row"> <navigation></navigation> </div> <div class="row"> <div class="eight wide column"> <h1>Your Projects</h1> <project_selector each="{projects}"></project_selector> </div> </div> </div>', function(opts) {
    this.section = 'Projects';
    this.projects = [];
    this.loadProjectsFromServer = function() {
      getProjectsUrl='http://localhost:3000/api/v1/projects.json';
      $.ajax({
        url: getProjectsUrl,
        dataType: 'json',
        success: function(data) {
          this.projects = data;
          this.update();
        }.bind(this),
        error: function(xhr, status, err) {

          if (err.toString() == "Unauthorized") {
            riot.route('login');
          } else {
            console.error(getProjectsUrl, status, err.toString());
          }
        }.bind(this)
      });
    }.bind(this);
    this.loadProjectsFromServer();
  
});

riot.tag('project_selector', '<div class="ui divided items"> <div class="ui grid"> <div class="two wide column"> <i class="circular user icon large"></i> </div> <div class="fourteen wide column"> <div class="content"> <a class="header" href="{\'#projects/\' + id}">{title}</a> <div class="meta"> <span class="cinema">created {created_at_pretty}</span> </div> <div class="description"> <p> {shorten(description)}<br> <a href=mailto:{email}>{email}</a> </p> </div> </div> </div> </div> </div>', function(opts) {
    this.shorten = function(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    }.bind(this);
  
});
riot.tag('projects_tasks_list', '<div class="ui page grid"> <div class="row"> <navigation></navigation> </div> <div class="row"> <div class="six wide column"> <h1>{this.project_title} tasks</h1> <project_task each="{this.project.tasks}"></project_task> </div> <div class="ten wide column"> </div> </div> </div>', function(opts) {
    this.section = 'Projects';
    this.projects = [];
    this.loadProjectsFromServer = function() {
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

          if (err.toString() == "Unauthorized") {
            riot.route('login');
          } else {
            console.error(getProjectsUrl, status, err.toString());
          }
        }.bind(this)
      });
    }.bind(this);
    this.loadProjectsFromServer();
  
});

riot.tag('project_task', '<div class="ui divided items"> <div class="ui grid"> <div class="two wide column"> <i class="circular user icon large"></i> </div> <div class="fourteen wide column"> <div class="content"> <a class="header" href="{\'#projects/\' + id}">{title}</a> <div class="meta"> <span class="cinema">created {created_at_pretty}</span> </div> <div class="description"> <p> {shorten(content)} </p> </div> </div> </div> </div> </div>', function(opts) {
    this.shorten = function(longString) {
      return _.trunc(longString, {
        'length': 50,
        'separator': ' '
      });
    }.bind(this);
  
});