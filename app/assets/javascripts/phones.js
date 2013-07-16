$(function () {

  $('#phones_search input').keyup(function () {
    $.get($('#phones_search').attr('action'), 
    $('#phones_search').serialize(), null, 'script');
    return false;
  });

});  
  