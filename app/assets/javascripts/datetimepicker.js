$(function() {
    $( ".datetimepicker" ).datetimepicker({
    	timeFormat: 'hh:mm tt',
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

// $( ".datetimepicker" ).datepicker({ dateFormat: "yy-mm-dd" })
