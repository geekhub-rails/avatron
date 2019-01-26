$(function(){
  $('body').on( "click", ".button", function(){
    $(this).parents('.small-cont').find('.phone-cont').addClass('orange-text')    
    $('.avatar-container').addClass('orange-border')
  })

  $('body').on( "click", ".big-ava-label", function(){
    $(this).parents('.container').find('.orange-border').removeClass('orange-border')    
  })

});