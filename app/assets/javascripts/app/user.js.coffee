@module 'app', ->
  class @User
    @user_id = null
    @login_checked = false
    
    @do_if_logged_in: (callback, message='') =>
      if !message
        message = 'Please log in:'
      if @user_id
        if callback
          callback()
        return
      else if @login_checked
        app.LoginDialog.open(message)
        return
      $.getJSON app.Settings.services_url+'users/get_user_id', (data) =>
        @login_checked = true
        if data == null
          app.LoginDialog.open(message)
        else
          @user_id = data
          if callback
            callback()
    
    @open_login_dialog_if_not_logged_in: (message='') =>
      @do_if_logged_in(null, message)