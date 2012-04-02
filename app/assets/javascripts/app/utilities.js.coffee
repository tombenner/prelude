@module 'app', ->
  class @Utilities

    @encode_html: (string) =>
      $('<div/>').text(string).html()
    
    @dialog: (class_name, html, options={}) =>
      defaults = {
        resizable: false
      }
      options = $.extend(defaults, options)
      options['dialogClass'] = class_name+'-container'
      options['close'] = ->
        $(this).remove()
      if options['noTitle']?
        options['dialogClass'] += ' dialog-no-title'
      html = '<div class="'+class_name+'">'+html+'</div>'
      $('body').append(html)
      dialog = $('.'+class_name).dialog(options)
      dialog = dialog.parents('.ui-dialog:first')
      if options['topDisplacement']?
        dialog.css('top', options['topDisplacement'] + $(document).scrollTop())
      if options['noTitle']?
        close_button = dialog.find('.ui-dialog-titlebar-close')
        close_button.remove()
        dialog.find('.ui-dialog-titlebar').remove()
        dialog.prepend(close_button)
        close_button.click (e) =>
          $(e.currentTarget).parents('.dialog-no-title:first').find('.ui-dialog-content').dialog('close')
          $(e.currentTarget).parents('.ui-dialog:first').remove()
          false
      $('.'+class_name).find('input,textarea,select,a').blur()
      if options['ajax']?
        dialog.find('.ui-dialog-content').load(options['ajax'])
    
    @remove_dialogs: (selector) =>
      if (selector)
        dialogs = $('.ui-dialog:has('+selector+')')
      else
        dialogs = $('.ui-dialog')
      dialogs.each () ->
        $(this).find('.ui-dialog-content').dialog('close')
        $(this).remove()
    
    @target: (e) =>
      $(e.currentTarget)

    @validate_input: (id, field_title, rule='empty') =>
      if rule == 'empty'
        if not $.trim($('#'+id).val())
          alert 'Please enter a value for '+field_title+'!'
          $('#'+id).focus()
          return false
      return true
    
    @validate_inputs: (validations) =>
      for validation in validations
        rule = if validation[2] then validation[2] else 'empty'
        if not @validate_input validation[0], validation[1], rule
          return false
      return true

    @on_input_delay: (input, fn, ms=400) =>
      input.keyup ->
        clearTimeout($.data(this, 'timer'))
        wait = setTimeout(fn, ms)
        $(this).data('timer', wait)
    
    @csrf_input: =>
      token = $('meta[name="csrf-token"]').attr('content')
      '<div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="'+token+'" /></div>'