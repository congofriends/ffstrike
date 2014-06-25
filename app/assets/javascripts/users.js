function initializeProfileValidations() {
  $('#edit-user-details').validate({
    rules: {
      'user[name]': { required: true },
      'user[email]': { 
        required: true,
        email: true},
      'user[current_password]': { required: true },
      'user[password_confirmation]': {equalTo : "#user_password"}
    },
    messages: {
      'user[name]': "Name is required",
      'user[email]': {
          required: "Email is required",
          email: "Please enter a valid email address"},
      'user[current_password]': 'Current Password is required',
      'user[password_confirmation]': "Confirmation Password must equal Password"
    },
    errorElement: "div",
    errorClass: "text-danger",
    errorId: "event_error",
    errorPlacement: function (error, element) {
      error.insertAfter(element);
      element.closest('div').addClass('has-error');
    },
    success: function (label) {
      label.closest('.form-group').removeClass('has-error').addClass('has-success');
    }
  });
};

$(document).ready(function() {
  initializeProfileValidations();
});
