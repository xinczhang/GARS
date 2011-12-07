$(document).ready(function() {	
	$(".expandAppBtn").button({
		icons: {
              		primary: "ui-icon-plus"
           	},
            	text: false
	}).click(expand_collapse_handler);
	
	$(".editCommentBtn").button({                
                icons: {                
                        primary: "ui-icon-plus"
                },
                text: false
        }).click(expand_collapse_handler);
	$('.expandAppBtn').trigger('click');
});

function expand_collapse_handler() {
                                /* expandAppBtn click */
                                var options;
                                if ($(this).text() === "Expand" ) {
                                        options = {
                                                label: "Collapse",
                                                icons: {
                                                        primary: "ui-icon-minus"
                                                }
                                        };
                                        $(this).parent().next().children(".appContent").show();
                                } else {
                                        options = {
                                                label: "Expand",
                                                icons: {
                                                        primary: "ui-icon-plus"
                                                }
                                        };
                                        $(this).parent().next().children(".appContent").hide();
                                }
                                $( this ).button( "option", options );
                        }
