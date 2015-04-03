<app>
  <div id='container'>
    <a href="/#projects">Projects</a>
  </div>
  <script>
    riot.route( function(page,id) {
      if (page == 'projects') {
        $('#container').html('<projects_index></projects_index>');
        riot.mount('projects_index');
      };
      if (id) {
        $('#container').html('<project_show></project_show>');
        riot.mount('project_show',{project_id: id});
      }
    });
  </script>
</app>