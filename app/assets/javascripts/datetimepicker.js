$(function() {
    $( ".datetimepicker-es" ).datetimepicker({
	    timeOnlyTitle: 'Elegir una hora',
			timeText: 'Hora',
			hourText: 'Horas',
			minuteText: 'Minutos',
			secondText: 'Segundos',
			millisecText: 'Milisegundos',
			microsecText: 'Microsegundos',
			timezoneText: 'Huso horario',
			currentText: 'Ahora',
			closeText: 'Cerrar',
			timeFormat: 'HH:mm',
			amNames: ['a.m.', 'AM', 'A'],
			pmNames: ['p.m.', 'PM', 'P'],
			closeText: 'Cerrar',
			prevText: 'Anterior',
			nextText: 'Siguiente;',
			currentText: 'Hoy',
			monthNames: ['enero','febrero','marzo','abril','mayo','junio',
			'julio','agosto','septiembre','octubre','noviembre','diciembre'],
			monthNamesShort: ['ene','feb','mar','abr','may','jun',
			'jul','ago','sep','oct','nov','dic'],
			dayNames: ['domingo','lunes','martes','miércoles','jueves','viernes','sábado'],
			dayNamesShort: ['dom','lun','mar','mié','jue','vie','sáb'],
			dayNamesMin: ['D','L','M','X','J','V','S'],
			weekHeader: 'Sm',
			dateFormat: 'dd/mm/yy',
			firstDay: 1,
			isRTL: false,
			showMonthAfterYear: false,
    	timeFormat: 'h:mm tt',
    	minDateTime: Date.new,
    	dateFormat: "D, d MM, yy",
      timezone: 'CT',
			timezoneList: [
				{ value: 'ET', label: 'Eastern'},
				{ value: 'CT', label: 'Central' },
				{ value: 'MT', label: 'Mountain' },
				{ value: 'PT', label: 'Pacific' }
			]
    });

});

$(function() {
    $( ".datetimepicker-fr" ).datetimepicker({
			timeOnlyTitle: 'Choisir une heure',
			timeText: 'Heure',
			hourText: 'Heures',
			minuteText: 'Minutes',
			secondText: 'Secondes',
			millisecText: 'Millisecondes',
			microsecText: 'Microsecondes',
			timezoneText: 'Fuseau horaire',
			currentText: 'Maintenant',
			closeText: 'Terminé',
			timeFormat: 'HH:mm',
			amNames: ['AM', 'A'],
			pmNames: ['PM', 'P'],
			isRTL: false,
			closeText: 'Fermer',
			prevText: 'Précédent',
			nextText: 'Suivant',
			currentText: 'Aujourd\'hui',
			monthNames: ['janvier', 'février', 'mars', 'avril', 'mai', 'juin',
				'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'],
			monthNamesShort: ['janv', 'févr', 'mars', 'avril', 'mai', 'juin',
				'juil', 'août', 'sept', 'oct', 'nov', 'déc'],
			dayNames: ['dimanche', 'lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi'],
			dayNamesShort: ['dim', 'lun', 'mar', 'mer', 'jeu', 'ven', 'sam'],
			dayNamesMin: ['D','L','M','M','J','V','S'],
			weekHeader: 'Sem.',
			dateFormat: 'dd/mm/yy',
			firstDay: 1,
			isRTL: false,
			showMonthAfterYear: false,
	  	timeFormat: 'h:mm tt',
    	minDateTime: Date.new,
    	dateFormat: "D, d MM, yy",
      timezone: 'CT',
			timezoneList: [
				{ value: 'ET', label: 'Eastern'},
				{ value: 'CT', label: 'Central' },
				{ value: 'MT', label: 'Mountain' },
				{ value: 'PT', label: 'Pacific' }
			]
    });
});


$(function() {
    $( ".datetimepicker-en" ).datetimepicker({
    	timeFormat: 'h:mm tt',
    	minDateTime: Date.new,
    	dateFormat: "D, d MM, yy",
      timezone: 'CT',
			timezoneList: [
				{ value: 'ET', label: 'Eastern'},
				{ value: 'CT', label: 'Central' },
				{ value: 'MT', label: 'Mountain' },
				{ value: 'PT', label: 'Pacific' }
			]
    });

});

