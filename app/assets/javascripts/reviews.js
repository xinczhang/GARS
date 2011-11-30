$(document).ready(function() {
	$(".editCommentBtn").button({
		icons: {primary: "ui-icon-pencil"},
		text: false
	}).click(function() {
		$(this).parent().next().children("div:nth-child(2)").show();				
	});

	$(".commentSubmitBtn").click(function() {
		var appContentDiv = $(this).parents(".appContent");
		appContentDiv.hide();
		var appControlsDiv = appContentDiv.parents(".appWrapper").children(".appControls");
		appControlsDiv.children("div").css("background-color", "green");
		appControlsDiv.children("a").button("option",{
			icons: {primary: "ui-icon-plus"},
			text: false
			});
	});
});
