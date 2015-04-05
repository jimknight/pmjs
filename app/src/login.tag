<login>
  <div class='ui page grid'>
    <div class='row'>
      <navigation></navigation>
    </div>
    <div class="row">
      <div class="eight wide column">
        <form class="ui form">
          <div class="ui error message"></div>
          <h4 class="ui dividing header">Enter your credentials</h4>
          <p>If you don't have any credentials, contact Jim</p>
          <div class="field">
            <input type="email" name="email" placeholder="Email">
          </div>
          <div class="field">
            <input type="password" name="password" placeholder="Password">
          </div>
          <div class="ui submit primary button" onclick={ clickSubmitBtn }>Login</div>
        </form>
      </div>
    </div>
  </div>
  <script>
    clickSubmitBtn() {
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
    };
  </script>
</login>