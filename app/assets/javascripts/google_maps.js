var ready;
ready = function () {
  var location_array = [];
  var map;
  var event_array = [];
  var event_path = [];
  var events = gon.events;

  for (var i=0; i < events.length; i++) {
    location_array.push(new google.maps.LatLng(events[i].latitude, events[i].longitude));
    event_array.push(events[i].name);
    event_path.push('/events/'+ events[i].name.replace(/ /g, '-'));
  }

  function initialize() {
    var mapOptions = {
      center: location_array[0],
      zoom: 7,
    };

    map = new google.maps.Map(document.getElementById("map-canvas"),
        mapOptions);

    for (i = 0; i < location_array.length; i++) {
      marker = new google.maps.Marker({
        map:map,
        draggable:false,
        animation: google.maps.Animation.DROP,
        position: location_array[i],
        title: event_array[i]
      });

      var infowindow = new google.maps.InfoWindow({
          content: ""
      });

      google.maps.event.addListener(marker, 'click', function(marker, i) {
        return function() {
          infowindow.setContent('<a href =' + event_path[i]+'>' + event_array[i] + '</a>');
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
