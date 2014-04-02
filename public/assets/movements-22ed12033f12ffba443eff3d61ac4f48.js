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

 //redirect to certain tab after CRUD operations on associated models
 var navbox = $('#movementTabs');
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
});
