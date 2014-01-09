$(document).ready(function(){
  $.validator.addMethod("zipDigitsDashSpaceOnlyRegex", function(value, element) {
          return this.optional(element ) || /^ *\d{5}((-|\s)?\d{4})? *$/.test(value);
  });

  $('#zip-form').validate({
    rules: {
      'zip': {
        required: true,
        minlength: 5,
        zipDigitsDashSpaceOnlyRegex: true
      }
    },
    messages: {
      'zip': {
        required: "Zip code is required",
        minlength: "Zip code must have at least five digits",
        zipDigitsDashSpaceOnlyRegex: "Zip code should contain only digits, space or dash"
      }
    },
    errorElement: "div",
    errorClass: "text-danger",
    errorPlacement: function (error, element) {
      error.insertAfter(element)
    }
  });
});
