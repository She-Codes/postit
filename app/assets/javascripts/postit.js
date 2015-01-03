function ready(){
  $('.view-cats').click(function(e){
    e.preventDefault();
    $(this).addClass('hide');
    $('.expanded-view-cat').addClass('show');
    $('.hide-cats').addClass('show');
  });

  $('.hide-cats').click(function(e){
    e.preventDefault();
    $(this).removeClass('show');
    $('.expanded-view-cat').removeClass('show');
    $('.view-cats').removeClass('hide');
  });

  $('.user-options-button').click(function(e){
    e.preventDefault();
    if ( $(this).hasClass('show') ){
      $(this).removeClass('show');
    } else {
      $(this).addClass('show');
    }

    if ( $('.user-links').hasClass('show') ){
      $('.user-links').removeClass('show');
    } else {
      $('.user-links').addClass('show');
    }
  })
}

$(document).ready(ready);
$(document).on('page:load', ready);