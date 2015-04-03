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