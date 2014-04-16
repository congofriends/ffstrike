function getLatLong(name) {
  $.ajax({
    type: 'GET',
    url: '/movements/' + name + '.json',
    dateType: 'json',
    success: function(result) {
      // alert("Success");
      events = result;
      console.log(events);
    },
    error: function (req, status, error) { alert("Unsuccess"); }
  });
};

$(document).ready(function () {
var location_array = [];
var map;
var event_array = [];
var event_path = [];

// var events = gon.events;
var events;
getLatLong();

// var event_zips =[[39.9307, -91.3763], 
//                  [39.9601, -91.3026],
//                  [39.9786, -91.2126]];

for (var i=0; i < events.length; i++) {
  // location_array.push(new google.maps.LatLng(events[i].latitude, events[i][longitude]));
  // event_array.push(events[i].name);
  // event_path.push(events[i].event.to_param);
  location_array.push(new google.maps.LatLng(events[i][0], events[i][1]));
  event_array.push(events[i][2]);
  event_path.push(events[i][3]);
}                 

var center_location = location_array[0];

function initialize() {
  var mapOptions = {
    center: center_location,
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
        content: "Hi"
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
});
