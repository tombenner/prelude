@module 'app', ->
  class @LoginDialog
  
    @create_dialog_ui: () =>
      $('.sign-up-username').bind 'input keyup', () ->
        input = $(this)
        delay = 1000
        clearTimeout(input.data('timer'))
        input.data('timer', setTimeout ->
          input.removeData('timer')
          username = input.val()
        , delay)
      $('#si_user_login').focus()
    
    @open: (message='') =>
      if message
        message = '<div class="login-in-message">'+message+'</div>'
      redirect_path = window.location.pathname+window.location.hash
      html = '''
        <div class="modal-body">
          '''+message+'''
          <div class="sign-up-form">
            <h3>Sign up for an account</h3>
      	    <form accept-charset="UTF-8" action="/" class="user_new" id="su_user_new" method="post">
              <label for="su_user_username">Username</label>
              <input id="su_user_username" name="user[username]" size="30" type="text" />
      
              <label for="su_user_email">Email</label>
              <input id="su_user_email" name="user[email]" size="30" type="email" value="" />
      
              <label for="su_user_password">Password</label>
              <input id="su_user_password" name="user[password]" size="30" type="password" />
      
              <label for="su_user_password_confirmation">Password confirmation</label>
              <input id="su_user_password_confirmation" name="user[password_confirmation]" size="30" type="password" />
          	'''+app.Utilities.csrf_input()+'''
          	<input type="submit" value="Sign up" />
            </form>
          </div>
          <div class="sign-in-form">
            <h3>Sign in</h3>
        	<form accept-charset="UTF-8" action="/login" class="user_new" id="si_user_new" method="post">
        	  <label for="si_user_login">Username</label>
        	  <input id="si_user_login" name="user[login]" size="30" type="text" />
        	  <label for="si_user_password">Password</label>
        	  <input id="si_user_password" name="user[password]" size="30" type="password" />
        	  '''+app.Utilities.csrf_input()+'''
        	  <input name="user[remember_me]" type="hidden" value="0" /><input id="si_user_remember_me" name="user[remember_me]" type="checkbox" value="1" /> <label for="si_user_remember_me">Remember me</label>
        	  <input type="submit" value="Sign in" />
            </form>
            <a href="/password/new">Forgot your password?</a><br />
          </div>
        </div>
      '''
      app.Utilities.modal 'login-dialog'
        html: html
        width: 550
      @create_dialog_ui()
  
