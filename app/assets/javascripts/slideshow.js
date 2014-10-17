$(document).ready(function(){

	$(function() {
    $('.fadein img:gt(0)').hide();
    setInterval(function(){
      $('.fadein :first-child').fadeOut(2000)
         .next('img').fadeIn(2000)
         .end().appendTo('.fadein');},
      7000);
	})

	$('.carousel-responsive').slick({
	  dots: true,
	  infinite: false,
	  speed: 500,
	  slidesToShow: 3,
	  slidesToScroll: 3,
	  responsive: [
	    {
	      breakpoint: 1024,
	      settings: {
	        slidesToShow: 2,
	        slidesToScroll: 2,
	        infinite: true,
	        dots: true
	      }
	    },
	    {
	      breakpoint: 600,
	      settings: {
	        slidesToShow: 1,
	        slidesToScroll: 1
	      }
	    }
	  ]
	})


});