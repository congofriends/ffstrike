$(document).ready(function(){
  $.validator.addMethod("zipDigitsDashSpaceOnlyRegex", function(value, element) {
          return this.optional(element ) || /^\d{5}$/.test(value);
  });

  $('#zip-form').validate({
    rules: {
      'zip': {
        required: true,
        zipDigitsDashSpaceOnlyRegex: true,
      }
    },
    messages: {
      'zip': {
        required: I18n[window.gon.locale]['validations']['zip_required'],
        zipDigitsDashSpaceOnlyRegex: I18n[window.gon.locale]['validations']['zip_numeric'],
      }
    },
    errorElement: "div",
    errorClass: "text-danger",
    errorId: "zip_error",
    errorPlacement: function (error, element) {
      error.insertAfter(element)
    }
  });
});
