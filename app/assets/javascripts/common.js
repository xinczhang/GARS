// JavaScript Document


$(document).ready(function() {	
	// use jquery style button
	$(".jqBtn").button();
	
	// search textbook effect
	$("#searchQuery").focus(function() {
		if ($(this).val() == "Search" ) {
			$(this).val("");
			$(this).css("color", "black");
		}
	}).focusout(function() {
		if ($(this).val() == "" ) {
			$(this).val("Search");
			$(this).css("color", "#CCC");
		}
	});
	
	$(".expandAppBtn").button({
				icons: {
                	primary: "ui-icon-plus"
            	},
            	text: false
	});
});