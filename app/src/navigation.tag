<navigation>
  <div class='ui menu inverted'>
    <a class='active item'>
      <i class='home icon'></i> Home
    </a>
    <a class='item' href='#projects'>
      <i class='list layout icon'></i> Projects
    </a>
    <div class="right menu">
        <div class="item">
          <div class="ui icon input">
            <input type="text" placeholder="Search...">
            <i class="search link icon"></i>
          </div>
        </div>
        <a if={ loggedIn } class="ui item" onclick={ logOut } id="logoutBtn">
          Logout
        </a>
      </div>
  </div>
  <script>
    this.loggedIn = !jQuery.isEmptyObject($.auth.user)
    logOut() {
      $.auth.signOut().then(function(){
        riot.route('#login');
      });
    };
  </script>
</navigation>