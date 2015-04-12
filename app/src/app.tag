<app>
  <script>
    $.auth.configure({apiUrl: 'http://localhost:3000/api/v1'});
    riot.route( function(projects,project_id,emails,email_id) {
      if (projects == 'projects' && project_id == 'new') {
        $('app').html('<projects_new></projects_new>');
        riot.mount('projects_new');
        return true;
      };
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
      if (projects == 'projects' && project_id == 'new') {
        $('app').html('<projects_new></projects_new>');
        riot.mount('projects_new');
        return true;
      };
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
  </script>
</app>