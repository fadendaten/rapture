# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$('#results').html(" <%= escape_javascript('render :partial => display_customers')");
$("#results").html("<%= raw (render("products")) %>");