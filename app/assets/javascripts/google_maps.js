var ready;
ready = function () {
  var map;
  var events;
  var event_types = [];
  var location_array = [];
  var event_names = [];
  var event_path = [];
  var addresses = [];
  var dates = []

  if(window.gon.events != undefined || window.gon.event_types != undefined) {
    events = window.gon.events;

    for (var i=0; i < events.length; i++) {
      location_array.push(new google.maps.LatLng(events[i].latitude, events[i].longitude));
      event_names.push(events[i].name);
      event_types.push(window.gon.event_types[events[i].event_type_id - 1].name);
      addresses.push(events[i].address + ", " + events[i].city + ", " + events[i].state + ", " + events[i].zip);
      event_path.push('/events/'+ events[i].name.replace(/ /g, '-'));
      dates.push(events[i].start_time)
    }

    function initialize() {
      var mapOptions = {
        scrollwheel: false,
        center: location_array[0],
        zoom: 3,
      };

      map = new google.maps.Map(document.getElementById("map-canvas"),
          mapOptions);

      var infowindow = new google.maps.InfoWindow();

      for (var i = 0; i < location_array.length; i++) {
        marker = new google.maps.Marker({
          map:map,
          draggable:false,
          animation: google.maps.Animation.DROP,
          position: location_array[i],
          title: event_names[i],
        });

        google.maps.event.addListener(marker, 'click', function(marker, i) {
          return function() {

            infowindow.setContent('<a href =' + event_path[i]+'>' + event_names[i] + '</a>' +
        '<div>' + event_types[i] + '</div>' + '<hr>' +
        '<div>' + addresses[i] + '</div>' +
        '<div>' + dates[i] + '</div>');


            infowindow.open(map, marker);
          }
        }(marker, i));
      }
    }
    google.maps.event.addDomListener(window, 'load', initialize);
  };
};

function addEvent(element, event, fn) {
    if (element.addEventListener)
        element.addEventListener(event, fn, false);
    else if (element.attachEvent)
        element.attachEvent('on' + event, fn);
}
addEvent(window, 'load', ready);
$(document).ready(ready);
$(document).on('page:load', ready);

