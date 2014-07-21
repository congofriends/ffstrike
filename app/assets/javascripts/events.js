function initializeValidations() {
  $('#new-event-form').validate({
    rules: {
      'event[name]': { required: true },
      'event[start_time]': { required: true },
      'event[address]': { required: true },
      'event[city]': { required: true },
      'event[country]': { required: true },
      'event[description]': { required: true },
      'user[name]': {required: true},
      'user[surname]': {required: true},
      'user[email]': {
            required: true,
            email: true,
            remote: "/check_email" },
      'user[password]': {required: true},
      'user[password_confirmation]': {equalTo : "#user_password"}
    },
    messages: {
      'event[name]': "Name is required",
      'event[start_time]': "Start date & time is required",
      'event[address]': 'Address is required',
      'event[city]': 'City is required',
      'event[country]': 'Country is required',
      'event[description]': 'Description is required',
      'user[name]': "First Name is required",
      'user[surname]': "Last Name is required",
      'user[email]': {
            required: "Email is required",
            email: "Please enter a valid email address",
            remote: "Email has already been taken"},
      'user[password]': "Password is required",
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
      label.closest('.form-event').removeClass('has-error').addClass('has-success');
    }
  });
};

function formValid(nextButton, fieldset){
    return $('#new-event-form').valid();
}

function goToNextStep(button) {
  current_fieldset = $(button).closest('fieldset');

  if(!formValid(button, current_fieldset))
    return false;

  next_fieldset = current_fieldset.next().show();
  current_fieldset.hide();
  };

function goToPreviousStep(button) {
  current_fieldset = $(button).closest('fieldset');
  previous_fieldset = current_fieldset.prev('fieldset');
  current_fieldset.hide();
  previous_fieldset.show();
}

function populate_end_time() {
  start_date = new Date($('#event_start_time').val());
  end_date = new Date(start_date.setHours(start_date.getHours() + 1));
  formatted_end_date = end_date.toString('ddd, d MMMM, yyyy h:mm tt');
  $('#event_end_time').val(formatted_end_date);
}

$(document).ready(function() {
  initializeValidations();

  $('#event_start_time').change(function() {
    populate_end_time();
  });

  $(".next").click(function() {
    goToNextStep(this);
  });

  $(".previous").click(function() {
    goToPreviousStep(this);
  });

  $("#event_time_tbd").bind('change', function(){
    if(this.checked){
      $(".event-date-time").hide();
    }
    else{
      $(".event-date-time").show();
    }
  })

  $("#event_location_tbd").bind('change', function(){
    if(this.checked){
      $("#event_address").val("TBD")
      $("#event_address2").val("TBD")
      $("#event_zip").val("TBD")
    }
    else{
      $("#event_address").val("");
      $("#event_address2").val("");
      $("#event_zip").val("");
    }
  })

  $(function() {
      $('#search_input').fastLiveFilter('#search_events');
  });

  $('#search_input').fastLiveFilter('#search_events', {
  timeout: 200,
  callback: function(total) { $('#num_results').html(total); }
  });

$('#event_location_tbd').bind(function() {
    $('#yourInput').val( $(this).text() ).keyup();
    return false;
});

});
