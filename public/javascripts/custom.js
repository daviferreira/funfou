$(function(){
  greetings();
  $('.question pre').each(function(){
    $(this).snippet($(this).attr('class'),{
              style:"vim",
              clipboard:"flash/ZeroClipboard.swf"
    });
  });
});

var greetings = function(){
  var d = new Date();
  var c_hour = d.getHours();
  var user = $('#greetings-time').html();

  var greeting = '';
  if(c_hour > 6 && c_hour <= 12) greeting = 'Bom dia, '+user+'!';
  else if(c_hour > 12 && c_hour <= 18) greeting = 'Boa tarde, '+user+'.';
  else if(c_hour > 18 && c_hour <= 23) greeting = 'Boa noite, '+user+'.';
  else greeting = 'Tá sem sono, '+user+'? Dormir é para os fracos!';
  
  $('#greetings-time').html(greeting);
};