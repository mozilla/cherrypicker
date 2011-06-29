function signin(form){
  navigator.id.getVerifiedEmail(function(assertion) {
    if (assertion) {
      // This code will be invoked once the user has successfully
      // selected an email address they control to log in with.
      form.find('input.SignIn').val(assertion);
      form.submit();
    } 
    else {
      // something went wrong!  the user isn't logged in.
      console.log('fail');
      console.log(assertion);
    }
  });
}

$(function(){
  $("a.SignIn").click(function(){
    signin($(this).parent());
    return false;
  });
});

