$(function() {
    $( ".datetimepicker" ).datetimepicker({
    	timeFormat: 'h:mm tt',
    	minDateTime: Date.new,
    	dateFormat: "D, d MM, yy",
      timezone: 'MT',
			timezoneList: [
				{ value: 'ET', label: 'Eastern'},
				{ value: 'CT', label: 'Central' },
				{ value: 'MT', label: 'Mountain' },
				{ value: 'PT', label: 'Pacific' }
			]
    });

});

