<navigation>
  <div class='ui menu inverted'>
    <a class={section == 'Home' ? 'item active' : 'item'} href='#projects'>
      <i class='home icon'></i> Home
    </a>
    <a class={section == 'Projects' ? 'item active' : 'item'} href='#projects'>
      <i class='list layout icon'></i> Projects
    </a>
    <div class="right menu">
        <div class="item">
          <div class="ui icon input">
            <input type="text" placeholder="Search...">
            <i class="search link icon"></i>
          </div>
        </div>
        <a if={ !jQuery.isEmptyObject($.auth.user) } class="ui item" onclick={ logOut } id="logoutBtn">
          Logout
        </a>
      </div>
  </div>
  <script>
    this.section = this.parent.section;
    logOut() {
      $.auth.signOut().then(function(){
        riot.route('#login');
      });
    };
  </script>
</navigation>