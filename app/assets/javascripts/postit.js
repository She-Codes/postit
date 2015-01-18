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
  });

  $('.new-options-button').click(function(e){
    e.preventDefault();
    if ( $(this).hasClass('show') ){
      $(this).removeClass('show');
    } else {
      $(this).addClass('show');
    }

    if ( $('.new-links').hasClass('show') ){
      $('.new-links').removeClass('show');
    } else {
      $('.new-links').addClass('show');
    }
  });

  $('.admin-user-form').submit(function(e){
    var checked = false
    $('.delete-check').each(function(){
      if ( $(this).prop('checked') ){
        checked = true;
      }
    });
    if ( checked ) {
      e.preventDefault();
      $('#myModal').modal();

      $('.modal-submit').click(function(){
        $('.admin-user-form').submit();
      });
      
    }
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);