function initializeGroupValidations() {
  $('#new-group-form').validate({
    rules: {
      'movement[name]': {
        required: true,
        remote: "/check_name"},
      'user[name]': {required: true},
      'user[email]': {
            required: true,
            email: true,
            remote: "/check_email" },
      'user[password]': {required: true},
      'user[password_confirmation]': {equalTo : "#user_password"}
    },
    messages: {
      'movement[name]': {
        required: "Name is required",
        remote: "Name is already in use"},
      'user[name]': "Name is required",
      'user[email]': {
            required: "Email is required",
            email: "Please enter a valid email address",
            remote: "Email has already been taken"},
      'user[password]': "Password is required",
      'user[password_confirmation]': "Confirmation Password must equal Password"
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
    }
  });
};

function groupFormValid(nextButton, fieldset){
    return $('#new-group-form').valid();
}

function goToGroupNextStep(button) {
  current_fieldset = $(button).closest('fieldset');

  if(!groupFormValid(button, current_fieldset))
    return false;

  next_fieldset = current_fieldset.next().show();
  current_fieldset.hide();
  };

function goToGroupPreviousStep(button) {
  current_fieldset = $(button).closest('fieldset');
  previous_fieldset = current_fieldset.prev('fieldset');
  current_fieldset.hide();
  previous_fieldset.show();
}

$(document).ready(function() {

  $(".next").click(function() {
    goToGroupNextStep(this);
  });

  $(".previous").click(function() {
    goToGroupPreviousStep(this);
  });

/* Activating Best In Place */
  jQuery(".best_in_place").best_in_place();
  initializeGroupValidations();

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

function not_group_page() {
  return location.pathname.match(/my_groups/) == null;
};

// if(not_movement_page()){
//   $(".edit-event").show();
// }

if(!not_movement_page()){
  $("div#flyer_download").hide();
}

 //redirect to certain tab after CRUD operations on associated models
 var navbox = not_group_page() ? $('#eventTabs') : $('#groupTabs');
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

function not_dashboard_page() {
  return location.pathname.match(/dashboard/) == null;
};

function new_unauthenticated_event_page() {
  return location.pathname.match(/unauthenticated_events/) != null;
};

$("#map").on("click", function() {
  $("#map-canvas").slideToggle();
});

$(".sub_movements").on("click", function() {
  $("#sub_movements").slideToggle();
});

$('.dropdown-toggle').click(function(){
  $(this).next(".dropdown-menu").toggle();
});

});
