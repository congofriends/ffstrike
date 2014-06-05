function initializeValidations() {
  $('#new-event-form').validate({
    rules: {
      'event[name]': { required: true },
      'event[start_time]': { required: true },
      'event[address]': { required: true },
      'event[city]': { required: true },
      'event[description]': { required: true },
      'event[state]': { required: true },
      'event[zip]': {
        required: true,
        number: true,
        rangelength: [5, 5] }
    },
    messages: {
      'event[name]': "Name is required",
      'event[start_time]': "Start date & time is required",
      'event[address]': 'Address is required',
      'event[city]': 'City is required',
      'event[description]': 'Description is required',
      'event[state]': 'State is required',
      'event[zip]': {
        required: 'Zip is required',
        number: "Zip should contain only numbers",
        rangelength: "Zip should be 5 digits long"}
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
  end_time = start_date.setHours(start_date.getHours() + 1);
  $('#event_end_time').val(new Date(end_time));
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

  $(function() {
      $('#search_input').fastLiveFilter('#search_events');
  });

  $('#search_input').fastLiveFilter('#search_events', {
  timeout: 200,
  callback: function(total) { $('#num_results').html(total); }
  });

});
