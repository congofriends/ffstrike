var ready;
ready = function () {
  var map;
  var events;
  var times;
  var event_images;
  var addresses;
  var event_types = [];
  var location_array = [];
  var event_names = [];
  var event_path = [];

  if(window.gon.events != undefined || window.gon.event_types != undefined) {
    events = window.gon.events;
    times = window.gon.times;
    event_images = window.gon.event_images;
    addresses = window.gon.addresses;

    for (var i=0; i < events.length; i++) {
      location_array.push(new google.maps.LatLng(events[i].latitude, events[i].longitude));
      event_names.push(events[i].name);
      event_types.push(window.gon.event_types[events[i].event_type_id - 1].name);
      event_path.push('/events/'+ events[i].name.replace(/ /g, '-'));
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

            infowindow.setContent('<div class="contentWindow"><h4><a href =' + event_path[i]+'>' + event_names[i] + '</a>' +
        '<img src="' + event_images[i] + '" class="marker_image"></h4>' +
        '<div>' + event_types[i] + '</div>' + '<hr>' +
        '<h6>Location:</h6>' +
        '<div>' + addresses[i] + '</div>' +
        '<h6>When:</h6>' +
        '<div>' + times[i] + '</div></br>' +
        '<div>Would you like more information about this event? </div>' +
        '<div>Contact the host</div>' +
        '</div>');


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

