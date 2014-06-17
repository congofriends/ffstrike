function initializeValidations2(id) {
  $('#edit-event' + id + '-form').validate({
    rules: {
      'event[name]': { required: true },
      'event[city]': { required: true },
      'event[state]': { required: true },
      'event[address]': { required: true },
      'event[description]': { required: true },
      'event[zip]': {
      required: true,
      number: true,
      rangelength: [5, 5] }

    },
    messages: {
      'event[name]': "Name is required",
      'event[start_time]': "Start date & time is required",
      'event[city]': "City is required",
      'event[state]': "State is required",
      'event[address]': "Address is required",
      'event[description]': "Description is required",
      'event[zip]': {
      required: 'Zip is required',
      number: "Zip should contain only numbers",
      rangelength: "Zip should be 5 digits long"}
    },

    errorElement: "div",
    errorClass: "text-danger",
    errorId: "event_error",
    errorPlacement: function (error, element) {
      error.insertAfter(element);
      element.closest('div').addClass('has-error');
    },
    success: function (label) {
        label.closest('.form-group').removeClass('has-error').addClass('has-success');
        label.next('.help-block').hide();
    }
  });
};

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

function not_movement_page() {
  return location.pathname.match(/movements/) == null;
};

if(not_movement_page()){
  $(".edit-event").show();
}

if(!not_movement_page()){
  $("div#flyer_download").hide();
}

 //redirect to certain tab after CRUD operations on associated models
 var navbox = not_movement_page() ? $('#eventTabs') : $('#movementTabs');
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

function new_unauthenticated_event_page() {
  return location.pathname.match(/unauthenticated_events/) != null;
};


 $('#event_event_type').on('change', function(){
   get_description(this.value);
   if(new_unauthenticated_event_page()) {
      location.href = update_event_url(this.value);
   }
 });

$("#map").on("click", function() {
  $("#map-canvas").slideToggle();
});

function click_event(id) {
  $(".edit-event").hide('fast');
  $('.event-' + id + '-details').show('slow');
}

$(".edit-event-dash").on("click", function() {
  click_event(this.id);
  initializeValidations2(this.id);
});

$(".sub_movements").on("click", function() {
  $("#sub_movements").slideToggle();
});

$('.dropdown-toggle').click(function(){
  $(this).next(".dropdown-menu").toggle();
});

});
