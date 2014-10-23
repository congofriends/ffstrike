// When document has finished loading
$(document).ready(function() {

	var initialSize = $(this).width();

	var resizeText = function () {
		// Standard height, for which the body font size is correct
		var preferredFontSize = 91; // %
		var finalSize = $(window).width();

		var scalePercentage = (finalSize) / (initialSize);
		var newFontSize = preferredFontSize * scalePercentage;
		
		if (finalSize > 1100){
			$(".btn").css("font-size", newFontSize + '%');
		}

	};

  $(window).bind('resize', function() {
		resizeText();
		}).trigger('resize');

});