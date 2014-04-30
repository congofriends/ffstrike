$(function() {
    $( ".datetimepicker" ).datetimepicker({
    	timeFormat: 'hh:mm tt',
			timezone: 'MT',
			timezoneList: [
				{ value: 'ET', label: 'Eastern'},
				{ value: 'CT', label: 'Central' },
				{ value: 'MT', label: 'Mountain' },
				{ value: 'PT', label: 'Pacific' }
			]
    });
});

// $(".datetimepicker").datetimepicker({
// 	timeFormat: 'HH:mm z',
// 	timezone: 'MT',
// 	timezoneList: [
// 			{ value: 'ET', label: 'Eastern'},
// 			{ value: 'CT', label: 'Central' },
// 			{ value: 'MT', label: 'Mountain' },
// 			{ value: 'PT', label: 'Pacific' }
// 		]
// });
