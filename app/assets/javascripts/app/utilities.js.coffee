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

    @modal: (classes, options={}) =>
      defaults =
        html: null
        ajax: null
        ajaxLoadingIndicator: true
        modal: {}
        removeOnHidden: true
        width: null
        height: null
        fade: true
      options = $.extend(defaults, options)
      if options.fade
        classes += ' fade'
      html = '<div class="app-modal modal '+classes+'">'+options.html+'</div>'
      $('body').append(html)
      modal = $('.app-modal:last')
      if options.ajax
        if options.ajaxLoadingIndicator
          original_width = modal.width()
          @set_modal_width(modal, 150)
          html = '
            <div class="modal-header">
              <h3><span class="loading-icon" style="margin-right:7px;"></span> Loading...</h3>
            </div>
          '
          modal.html(html).modal(options.modal)
          @set_modal_vertical_position(modal)
          modal.load(options.ajax, =>
            @set_modal_width(modal, original_width)
            @set_modal_dimensions(modal, options.width, options.height)
            modal.modal(options.modal)
            @set_modal_vertical_position(modal)
            if options['onLoad']
              options['onLoad']()
            if options.removeOnHidden
              modal.on 'hidden', =>
                modal.remove()
          )
        else
          @set_modal_dimensions(modal, options.width, options.height)
          modal.load(options.ajax, =>
            modal.modal(options.modal)
            @set_modal_vertical_position(modal)
            if options['onLoad']
              options['onLoad']()
            if options.removeOnHidden
              modal.on 'hidden', =>
                modal.remove()
          )
      else
        @set_modal_dimensions(modal, options.width, options.height)
        modal.modal(options.modal)
        @set_modal_vertical_position(modal)
        if options['onLoad']
          options['onLoad']()
        if options.removeOnHidden
          modal.on 'hidden', =>
            modal.remove()

    @remove_modals: (selector) =>
      if (selector)
        modals = $('.modal'+selector)
      else
        modals = $('.modal')
      modals.each () ->
        if $(this).is(':hidden')
          $(this).remove()
        else
          $(this).on('hidden', ->
            $(this).remove()
          )
          $(this).modal('hide')

    @set_modal_dimensions: (modal, width, height) =>
      @set_modal_width(modal, width)
      @set_modal_height(modal, height)

    @set_modal_width: (modal, width) =>
      if !width
        return
      margin_right = -1*(width/2)
      margin_left = margin_right + 30
      modal.css('width', width+'px')
      modal.css('margin-right', margin_right+'px')
      modal.css('margin-left', margin_left+'px')

    @set_modal_height: (modal, height) =>
      if !height
        return
      modal.css('height', height+'px')

    @set_modal_vertical_position: (modal) =>
      modal.css(
        'margin-top': ->
          -($(this).height() / 2)
      )
    
    @target: (e) =>
      $(e.currentTarget)

    @on_input_delay: (input, fn, ms=400) =>
      input.keyup ->
        clearTimeout($.data(this, 'timer'))
        wait = setTimeout(fn, ms)
        $(this).data('timer', wait)
    
    @csrf_input: =>
      token = $('meta[name="csrf-token"]').attr('content')
      '<div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="'+token+'" /></div>'