var ready;
ready = function () {
  var location_array = [];
  var map;
  // var map_boundary;
  var event_names = [];
  var event_path = [];
  var addresses = [];
  var events = gon.events;

  for (var i=0; i < events.length; i++) {
    location_array.push(new google.maps.LatLng(events[i].latitude, events[i].longitude));
    event_names.push(events[i].name);
    addresses.push(events[i].location_details);
    event_path.push('/events/'+ events[i].name.replace(/ /g, '-'));
  }

  function initialize() {
    var mapOptions = {
      center: location_array[0],
      zoom: 7,
    };

    map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    // map_boundary = new google.maps.LatLngBounds();


    for (i = 0; i < location_array.length; i++) {
      marker = new google.maps.Marker({
        map:map,
        draggable:false,
        animation: google.maps.Animation.DROP,
        position: location_array[i],
        title: event_names[i],
        // map_boundary.extend(location_array[i])
      });

      // map.fitBounds(map_boundary);
      var infowindow = new google.maps.InfoWindow();

      var content = '<a href =' + event_path[i]+'>' + event_names[i] + '</a>' +
      '<div>' + addresses[i] + '</div>';

      google.maps.event.addListener(marker, 'click', function(marker, i) {
        return function() {
          infowindow.setContent(content);
          infowindow.open(map, marker);
        }
      }(marker, i));
    }
  }
  google.maps.event.addDomListener(window, 'load', initialize);
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

