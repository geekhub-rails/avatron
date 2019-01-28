$(function(){
  $('body').on( "click", ".button", function(){
    $(this).parents('.small-cont').find('.phone-cont').addClass('orange-text')    
    $('.avatar-container').addClass('orange-border')
  })

  $('body').on( "click", ".big-ava-label", function(){
    $(this).parents('.container').find('.orange-border').removeClass('orange-border')    
  })

  $('body').on( "click", ".login, .login-string", function(){
    $(this).parents('.container').find(".login-string").removeClass('orange-border') 
    $(this).parents('.container').find(".login").removeClass('orange-back') 
    $(this).parents('form .row').find(".login-string").addClass('orange-border')   
    $(this).parents('form .row').find(".login").addClass('orange-back')
    console.log($(this))
  })

});