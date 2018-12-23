// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require activestorage
//= require jquery3


function addAvatarToPhone(phoneId) {
    const overlay = document.getElementById('overlay');
    const images = document.getElementById('images');

    const onOverlayClick = cleanUp;

    const onImageClick = (event) => {
        $.ajax({
            type: 'PATCH',
            url: `/phone_numbers/${phoneId}`,
            crossDomain: true,
            data: {url: event.target.getAttribute('src')},
            complete: function (res) {
                console.log(res);
                eval(res.responseText);
            }
        });

        cleanUp();
    };

    overlay.addEventListener('click', onOverlayClick);
    images.addEventListener('click', onImageClick);

    overlay.classList.add('shown');

    function cleanUp() {
        overlay.classList.remove('shown');

        overlay.removeEventListener('click', onOverlayClick);
        images.removeEventListener('click', onImageClick);
    }
}
