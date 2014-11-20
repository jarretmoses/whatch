$(function(){
  $('.button_to').on('submit',function(e){
    e.preventDefault();
    // What type of request should I fire and where should I fire it to?
    var form_method = $(this).attr("method");
    var form_action = $(this).attr("action");
    // Fire the Request
    $.ajax(form_action, {
      type: form_method,
      data: $(this).serialize(),
      dataType: "script"
    });
  });
});
