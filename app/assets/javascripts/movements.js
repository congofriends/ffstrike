$(document).ready(function() {
/* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();

 //activate first nav-tab and tab-content if nothing is activated currently
 var elementAlreadyActive = false;
 $('.nav-tabs li').each(function(index, li) {
   var element = $(li);
   if (element.attr("class") == "active") {
     elementAlreadyActive = true;
   }
 });
 if (!elementAlreadyActive) {
   $('.nav-tabs li:first').addClass('active');
   $('.tab-content div:first').addClass('active');
 }

function not_movement_dashboard_page() {
  return location.pathname.match(/movements/) == null;
};

 //redirect to certain tab after CRUD operations on associated models
 var navbox = not_movement_dashboard_page() ? $('#eventTabs') : $('#movementTabs');
 navbox.on('click', 'a', function(e) {
   var $this = $(this);
   e.preventDefault();
   window.location.hash = $this.attr('href');
   $this.tab('show');
 });

 function refreshHash(){
   navbox.find('a[href="'+window.location.hash+'"]').tab('show');
 }

 $(window).bind('hashchange', refreshHash);
 if(window.location.hash) {
   refreshHash();
 }

function update_event_url(type){
  var eventType = type.replace(/ /g, '+');
  var url = window.location.origin +  $('#new_event').attr('action') + '/new?type=' + eventType;
  return url;
};

function get_description(type) {
  var eventType = type.toLocaleLowerCase().replace(/ /g, '_');
  var lookup_val = 'event_type.'.concat(eventType).concat('.full_description');
  $('.event-description').text(I18n.t(lookup_val));
};

function not_dashboard_page() {
  return location.pathname.match(/dashboard/) == null;
};

 $('#event_event_type').on('change', function(){
   get_description(this.value);
   if(not_dashboard_page()) {
      location.href = update_event_url(this.value);
   }
 });

$("#map").on("click", function() {
  $("#map-canvas").slideToggle();
});

function click_event(id) {
  $(".edit-event").hide('fast');
  $('.event-' + id +'-details').show('slow');
}

$(".edit-event-dash").on("click", function() {
  click_event(this.id);
});

$(".sub_movements").on("click", function() {
  $("#sub_movements").slideToggle();
});

$.modal.defaults = {
  overlay: "#000",        // Overlay color
  opacity: 0.75,          // Overlay opacity
  zIndex: 1,              // Overlay z-index.
  escapeClose: true,      // Allows the user to close the modal by pressing `ESC`
  clickClose: true,       // Allows the user to close the modal by clicking the overlay
  closeText: 'Close',     // Text content for the close <a> tag.
  closeClass: '',         // Add additional class(es) to the close <a> tag.
  showClose: true,        // Shows a (X) icon/link in the top-right corner
  modalClass: "modal",    // CSS class added to the element being displayed in the modal.
  spinnerHtml: null,      // HTML appended to the default spinner during AJAX requests.
  showSpinner: true,      // Enable/disable the default spinner during AJAX requests.
  fadeDuration: null,     // Number of milliseconds the fade transition takes (null means no transition)
  fadeDelay: 1.0          // Point during the overlay's fade-in that the modal begins to fade in (.5 = 50%, 1.5 = 150%, etc.)
};

$.modal.resize()

});
