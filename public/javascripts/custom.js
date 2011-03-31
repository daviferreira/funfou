$(function(){
  greetings();

	$('pre').find('br.content-nl').remove();

  $('.question .description pre').each(function(){
    $(this).snippet($(this).attr('class'),{
              style:"vim-dark",
              clipboard:"/flash/ZeroClipboard.swf"
    });
  });
  
  $('.answer pre').each(function(){
    $(this).snippet($(this).attr('class'),{
              style:"rand01",
              clipboard:"/flash/ZeroClipboard.swf",
    }).width(920);
  });
  
  $('.question-answers li.answer:odd').addClass('odd');
  
	if($('#fld-search').val() == "") $('#fld-search').val($('#fld-search').attr('title'));
	$('#fld-search').blur(function(){
		if($(this).val() == "")	 $(this).val($(this).attr('title'));
	});
	$('#fld-search').focus(function(){
		if($(this).val() == $(this).attr('title')) $(this).val('');
	});
	if($('#questions-sidebar').length > 0){
		if($('#questions-sidebar').height() <= $('#questions-list').height())
			$('#questions-sidebar').height($('#questions-list').height());
		else
			$('#questions-list').height($('#questions-sidebar').height());
	}
	$('li.perguntar a, .questions-admin a, #btn-change-image, .j-button, .admin a').button();
	$('ul.user-list li:odd').addClass('odd');
	$('ul.user-list img').height("auto").width(60);

});

var greetings = function(){
  var d = new Date();
  var c_hour = d.getHours();
  var user = false;
  if($('#greetings-time').length > 0) user = $('#greetings-time').html();

  var greeting = '';
  if(c_hour >= 5 && c_hour < 12) greeting = user ? 'Bom dia, '+user+'!' : 'Bom dia!';
  else if(c_hour >= 12 && c_hour < 18) greeting = user ? 'Boa tarde, '+user+'.' : 'Boa tarde!';
  else if(c_hour >= 18 && c_hour < 23) greeting = user ? 'Boa noite, '+user+'.' : 'Boa noite!';
  else greeting = user ? 'Tá sem sono, '+user+'? Dormir é para os fracos!' : 'Tá sem sono?';
  
  if(user) $('#greetings-time').html(greeting);
  else $('#greetings-time-guest').html(greeting);
};
