// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function (){  
    $('#user_birthday').datepicker();  
});

$(function () {  
  $('.pagination a').live("click", function () {  
    $.get(this.href, null, null, 'script');  
    return false;  
  });  
});

$(function () {  
  $('.users_sort a').live("click", function () {  
    $.get(this.href, null, null, 'script');  
    return false;  
  });  
});