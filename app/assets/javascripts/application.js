// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// = require jquery
// = require jquery_ujs
// = require jquery-ui
// = require_tree .

jQuery(function($) {
		
	$(function(){
		$(".settings").hide();
		$('.toggle_button').click(function(){
		  idelem = $(this).attr('id');
		  idelemdiv = idelem.replace('togglebutton_', 'toggle_');
		  $('#'+idelemdiv).slideToggle("fast");
		});
	});
	
	$(".address_printer_form").submit(function(){
	  var form = $(this);
	  console.log("1")
	  //clean up
	  $(this).children("input[type='hidden']").remove();
	  console.log("2")    
	  var reg = /_ids/
	  var inputs = []
	  var checked = $(".printables input[type='checkbox']").
	    filter(function(){
	      return $(this).attr("id").search(reg) > 1;
	  }).filter(function(){
	      return $(this).attr("checked");
	  });
	  console.log(checked.serialize())
	  checked.each(function(){
	    var c = $(this).clone()
	    c.attr("type", "hidden");

	    form.append(c)
	  });
	  console.log(form.serialize());
	});
	
});