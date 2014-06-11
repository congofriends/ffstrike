function initializeProfileValidations() {
  $('#edit-user-details').validate({
    rules: {
      'user[name]': { required: true },
      'user[email]': { required: true },
      'user[current_password]': { required: true }
    },
    messages: {
      'user[name]': "Name is required",
      'user[email]': "Email is required",
      'user[current_password]': 'Current Password is required'
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
