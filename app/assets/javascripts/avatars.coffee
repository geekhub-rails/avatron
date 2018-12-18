$(document).on 'dragover', '.dropzone', (e) ->
  e.preventDefault()
  $(@).addClass('active')

$(document).on 'dragleave drop', '.dropzone', (e) ->
  $(@).removeClass('active')

$(document).on 'change', '#dropzone', (e) ->
  $.each this.files, (i, file) ->
    reader = new FileReader
    reader.onload = (e) ->
      src = e.target.result
      $('[data-images]').prepend("<li id='image_#{i}' class='column preloader'><img src='#{ src }' /></li>")
      $.ajax
        url: 'https://api.cloudinary.com/v1_1/du4fm2qcv/image/upload'
        method: 'POST'
        crossDomain: true
        data: {file: src, upload_preset: 'unsigned'}
        success: (response) ->
          $("#image_#{i}").attr('id', "image_#{response.public_id}")
          $.ajax
            type: 'POST'
            url: '/avatars'
            data: { url: response.url, public_id: response.public_id }
            dataType: 'script'
            complete: (res) ->
              eval(res)
              $("#image_#{response.public_id}").hide()
    reader.readAsDataURL(file)

