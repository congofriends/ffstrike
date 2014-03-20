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
        required: "Zip code is required",
        zipDigitsDashSpaceOnlyRegex: "Zip code should contain only digits",
      }
    },
    errorElement: "div",
    errorClass: "text-danger",
    errorPlacement: function (error, element) {
      error.insertAfter(element)
    }
  });
});
