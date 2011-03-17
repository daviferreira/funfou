$(function(){
  greetings();
  $('.question pre').each(function(){
    $(this).snippet($(this).attr('class'),{
              style:"vim",
              clipboard:"/flash/ZeroClipboard.swf"
    });
  });
});

var greetings = function(){
  var d = new Date();
  var c_hour = d.getHours();
  var user = false;
  if($('#greetings-time').length > 0) user = $('#greetings-time').html();

  var greeting = '';
  if(c_hour > 6 && c_hour <= 12) greeting = user ? 'Bom dia, '+user+'!' : 'Bom dia.';
  else if(c_hour > 12 && c_hour <= 18) greeting = user ? 'Boa tarde, '+user+'.' : 'Boa tarde.';
  else if(c_hour > 18 && c_hour <= 23) greeting = user ? 'Boa noite, '+user+'.' : 'Boa noite.';
  else greeting = user ? 'Tá sem sono, '+user+'? Dormir é para os fracos!' : 'Tá sem sono?';
  
  if(user) $('#greetings-time').html(greeting);
  else $('#greetings-time-guest').html(greeting);
};