<app>
  <script>
    riot.route( function(projects,project_id,emails,email_id) {
      if (emails) {return false;};
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
      if (projects== 'projects') {
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