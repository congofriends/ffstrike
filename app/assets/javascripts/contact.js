 function initializeValidations() {
	$.modal.defaults = {
	  overlay: "#000",        // Overlay color
	  opacity: 0.75,          // Overlay opacity
	  zIndex: 1,              // Overlay z-index.
	  escapeClose: true,      // Allows the user to close the modal by pressing `ESC`
	  clickClose: true,       // Allows the user to close the modal by clicking the overlay
	  closeText: 'Close',     // Text content for the close <a> tag.
	  closeClass: '',         // Add additional class(es) to the close <a> tag.
	  showClose: false,        // Shows a (X) icon/link in the top-right corner
	  modalClass: "modal",    // CSS class added to the element being displayed in the modal.
	  spinnerHtml: null,      // HTML appended to the default spinner during AJAX requests.
	  showSpinner: false,      // Enable/disable the default spinner during AJAX requests.
	  fadeDuration: null,     // Number of milliseconds the fade transition takes (null means no transition)
	  fadeDelay: 1.0          // Point during the overlay's fade-in that the modal begins to fade in (.5 = 50%, 1.5 = 150%, etc.)
	};
	  $('#contact-form').validate({
	    rules: {
	      'message[name]': { required: true },
	      'message[email]': { required: true },
	      'message[subject]': { required: true },
	      'message[body]': { required: true }
	    },
	    messages: {
	      'message[name]': "Name is required",
	      'message[email]': "Email is required",
	      'message[subject]': "Subject is required",
	      'message[body]': "Body is required"
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

$(document).ready(function() {
   initializeValidations();
});

$('.contact-link').on("click", function() {
		$.modal.defaults = {
	  overlay: "#000",        // Overlay color
	  opacity: 0.75,          // Overlay opacity
	  zIndex: 1,              // Overlay z-index.
	  escapeClose: true,      // Allows the user to close the modal by pressing `ESC`
	  clickClose: true,       // Allows the user to close the modal by clicking the overlay
	  closeText: 'Close',     // Text content for the close <a> tag.
	  closeClass: '',         // Add additional class(es) to the close <a> tag.
	  showClose: false,        // Shows a (X) icon/link in the top-right corner
	  modalClass: "modal",    // CSS class added to the element being displayed in the modal.
	  spinnerHtml: null,      // HTML appended to the default spinner during AJAX requests.
	  showSpinner: false,      // Enable/disable the default spinner during AJAX requests.
	  fadeDuration: null,     // Number of milliseconds the fade transition takes (null means no transition)
	  fadeDelay: 1.0          // Point during the overlay's fade-in that the modal begins to fade in (.5 = 50%, 1.5 = 150%, etc.)
	};
   initializeValidations();
});


