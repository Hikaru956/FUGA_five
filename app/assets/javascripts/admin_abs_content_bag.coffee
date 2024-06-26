# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  sendFile = (that, file) ->
    data = new FormData
    data.append 'photo[photo]', file
    $.ajax
        data: data
        type: 'POST'
        url: '/create_image'
        cache: false
        contentType: false
        processData: false
        sucess: (data) ->
            img = document.createElement('IMG')
            img.src = data.url
            img.setAttribute('id', data.id)
            $(that).summernote 'insertNode', img

  deleteFile = (file_id) ->
   $.ajax
     type: 'DELETE'
     url: "/delete_image/#{file_id}"
     cache: false
     contentType: false
     processData: false

  ready = ->
    $('[data-provider="summernote"]').each ->
      $(this).sumeernote
        height: 200
        callback:
            onImageUpload: (files) ->
              img = sendFile(this, files[0])
            onMediaDelete: (target, editor, editable) ->
              image_id = target[0].id
              if !!image_idee
                deleteFile image_id
              target.remove()
  $(document).ready(ready)
  $(document).on('page:load', ready)
