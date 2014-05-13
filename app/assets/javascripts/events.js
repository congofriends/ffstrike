function initializeValidations() {
  $('#new-event-form').validate({
    rules: {
      'event[name]': { required: true },
      'event[start_time]': { required: true },
      'event[end_time]': { required: true },
      'event[address]': { required: true },
      'event[city]': { required: true },
      'event[state]': { required: true },
      'event[zip]': { required: true }
    },
    messages: {
      'event[name]': "Name is required",
      'event[start_time]': "Start date & time is required",
      'event[end_time]': 'End date & time is required',
      'event[address]': 'Address is required',
      'event[city]': 'City is required',
      'event[state]': 'State is required',
      'event[zip]': 'Zip is required'
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
        label.next('.help-block').hide();
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

$(document).ready(function() {
  initializeValidations();

  $(".next").click(function() {
    goToNextStep(this);
  });

  $(".previous").click(function() {
    goToPreviousStep(this);
  });
});  
