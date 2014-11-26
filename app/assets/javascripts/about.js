'use strict';

$(function(){

	$('.panel-body').hide();

	$('.panel-heading').on('click', function(){

		$(this).next().slideToggle();
		$(this).find('.fa').toggleClass("fa-rotate-180");

	});

});