		$(document).ready(function() {					
			$( "#selectRadios" ).buttonset();
		
			$("#expandBtn").button({
				icons: {
                	primary: "ui-icon-plus"
            	},
            	text: false
			})
			.click(function() {
				/* expandBtn click */
				var options;
				if ( $( this ).text() === "Expand" ) {
					options = {
						label: "Collapse",
						icons: {
							primary: "ui-icon-minus"
						}
					};
					$(".appContent").show();
					$(".expandAppBtn").button("option", options)
				} else {
					options = {
						label: "Expand",
						icons: {
							primary: "ui-icon-plus"
						}
					};
					$(".appContent").hide();
					$(".expandAppBtn").button("option", options)
				}
				$( this ).button( "option", options );
			});
			
			$(".jqBtn").button();
			$("#prevBtn").button({
				text: false,
				icons: {
					primary: "ui-icon-triangle-1-w"
				}
			})
			.click(function() {
				/* prevBtn click */
				alert("prev button clicked");
			});


			$("#nextBtn").button({
				text: false,
				icons: {
					primary: "ui-icon-triangle-1-e"
				}
			})
			.click(function() {
				/* nextBtn click */
				alert("next button clicked");
			});
			
			
			$("#whatever").buttonset();
			$(".selector").buttonset();
			$("#selectRadios").buttonset();
			
			$("#selectAllBtn").click(function() {
				$(".selectAppCB").attr('checked', 'checked');
			});
			$("#selectNoneBtn").click(function() {
				$(".selectAppCB").removeAttr('checked');
			});
			
			$("#filter_accordion").hide()
			
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
			})
			.click(function() {
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
			});		
			
			
			$(".dialogTrigger").parent().css("display", "inline-block").buttonset();
			$(".dialog .okCancelControls").find('input:eq(1)').click(function() {
				$(this).parents('.dialog').hide();
			});
			$(".dialogTrigger").click(function() {
				var dialog = $(this).next().next();
				if (dialog.css("display") != "none") {
					dialog.slideUp("fast");
				} else {
					// $(".dialog").hide().prev().prev().click();
					dialog.slideDown("fast");
				}
			});				
			
			notAssignable();

			// the dialog that shows up when the assign button is clicked
			$("#assignReviewsDialog").dialog({
				width: 700,
				height: 400,
				modal: true,
				autoOpen: false, // closed intially
				draggable: false,
				resizable: false,
				buttons: {
				Ok: function() {
						save_attrs_in_hidden('ay');
						save_attrs_in_hidden('ots');
						save_attrs_in_hidden('gars');
						$(this).find('.submitBtn').trigger('click');
					}
				}
			});	
			$("#assignBtn").click(function() {
				$("#assignReviewsDialog").dialog("open");
			});
			
			$(".research-area").change(function(){
				var v = $(this).children("option:selected").val();
				$.get(
					"/reviews/filter", 
					{by:'research-area', value:v}, 
					function(data){
						var userlst = data||[];
						var content = $("#assign-reviews-form .content tbody");			
						
						var cnt = "";
						for(var i=0,j=userlst.length; i<j; ++i){
							var user = userlst[i];

							var tr = "<tr><td>";
							tr += '<input type="checkbox" value="' + user['name'] + '"/>';
							tr += '<a href class="appName">' + user['name'] + '</a>';
							
							var areas = '';
							for(var u=0,v=user.research_areas.length; u<v; u++){
								areas += user.research_areas[u].name + ',';
							}
							tr += '<span>' + areas + '</span>';
							tr += "</td></tr>";

							cnt += tr;
						}
						content.html(cnt);
					},
					"json"
				);
			});
	
			// the dialog that shows up when the add remove fields button is clicked
			$("#addRemoveFieldsDialog").dialog({
				width: 900,
				height: 400,
				modal: true,
				autoOpen: false, // closed intially
				draggable: false,
				resizable: false,
				buttons: {
				Ok: function() {
						save_attrs_in_hidden('ay');
						save_attrs_in_hidden('ots');
						save_attrs_in_hidden('gars');
						$(this).find('.submitBtn').trigger('click');
					}
				}
			});	
			$("#addRemoveFieldsBtn").click(function() {
				$("#addRemoveFieldsDialog").dialog("open");
			});
			
			
			$("#filterAddBtn").click(function(){
				var li = $("#filterDialog ul li:first-child").clone();
				$("#filterDialog ul").append(li);
				li.show();
				li.children(".filter-value").each(function(){
					if($(this).css("display") != "none")
						$(this).change();
				});
			});

			$("#filterDelBtn").click(function(){
				var lst = $("#filterDialog ul li");
				if(lst.length > 2)
					$("#filterDialog ul li:last-child").remove();
			});

			$(".filter-type").live('change',function(){
				var type = $(this).children("option:selected").val();
				$(this).parent().children(".filter-value").hide();
				var v = $(this).parent().children("."+type);
				v.show();
				v.change();
			});
			
			$(".filter-value").live('change',function(){
				var type = $(this).children("option:selected").attr("data-type");
				var op = $(this).parent().children(".op");
				if(type == "string" || type == "text"){
					op.hide();
				}else if(type == "integer" || type == "float"){
					op.show();
				}else{
					op.hide();
				}
			});

			$("#filter-form").submit(function(){
				var type     = $("input#select-type"),
				    name     = $("input#select-name"),
				    value    = $("input#select-value"),
				    op       = $("input#select-op");

				var _t, _s, _n, _v, _o;
				var _tt = [], _nn = [], _vv = [], _oo = [];				
				var optlst = $(this).find("ul li:gt(0)");
				for(var i=0,j=optlst.length; i<j; ++i){
					var opt = $(optlst[i]);
					_v = opt.children("input.filter-content").val();
					if(_v && _v !== ''){
						_t = opt.children(".filter-type").children("option:selected").val();
						_n = opt.children("."+_t).children("option:selected").val();
						_s = opt.children("."+_t).children("option:selected").attr("data-type");
						if(_s == "string" || _s == "text"){
							_o = 0
						}else{
							_o = opt.children(".op").children("option:selected").val();
						}
						
						_tt.push(_t);
						_nn.push(_n);
						_vv.push(_v);
						_oo.push(_o);
					}
				}

				type.val(_tt.join(','));
				name.val(_nn.join(','));
				value.val(_vv.join(','));
				op.val(_oo.join(','));
				return true;
			});
			
			$(".sort-type").live('change',function(){
				var type = $(this).children("option:selected").val();
				$(this).parent().children(".sort-value").hide();
				$(this).parent().children("."+type).show();
			});		
			
			$("#sort-form").submit(function(){
				var type = $("input#sort-type"),
				    name = $("input#sort-name"),
				    order= $("input#sort-order");
				
				var _t,_n,_o;
				var _tt=[],_nn=[],_oo=[];
				var optlst = $(this).find("ul li:gt(0)");
				for(var i=0,j=optlst.length; i<j; ++i){
					var opt = $(optlst[i]);
					_t = opt.children(".sort-type").children("option:selected").val();
					_n = opt.children("."+_t).children("option:selected").val();
					_o = opt.children(".sort-order").children("option:selected").val();
					_tt.push(_t);
					_nn.push(_n);
					_oo.push(_o);	
				}
				type.val(_tt.join(','));
				name.val(_nn.join(','));
				order.val(_oo.join(','));
				return true;
			});

			$("#sortDelLevelBtn").click(function(){
				var lst = $("#sortDialog ul li");
				if(lst.length > 2)
					$("#sortDialog ul li:last-child").remove();

			});
	
			// sort add level button click handler
			$("#sortAddLevelBtn").click(function() {
				var li = $("#sortDialog ul li:first-child").clone();
				$("#sortDialog ul").append(li);
				li.show();
			});
			
			
			$(".section .header").click(function() {
				
				var className = $(this).parent().attr("class");
				if (className.indexOf('nocollapsing') != -1)
					return;

				if (className.indexOf('expanded') == -1) {
					$(this).parent().attr('class', 'section expanded');
				}
				else {
					$(this).parent().attr('class', 'section collapsed');
				}
				
			});
			
			/*
			$(document).ready(function() {
				$('.section').addClass('collapsed');
				$('.section.nocollapsing').attr('class', 'section nocollapsing');
			});
			*/
			$('.section').addClass('collapsed');
			$('.section.nocollapsing').attr('class', 'section nocollapsing');		

		
			$('#upload-form form').submit(function(){
				var tkn,type;
				tkn = $(this).find('input[name="authenticity_token"]').val();
				type= $('#filetype option:selected').val();
				$.ajaxFileUpload({
					url:'/upload/file',
					secureuri:false,
					data:{
						authenticity_token:tkn,
						filetype:type
					},
					dataType:'text/html',
					fileElementId:'datafile',
					success:function(data){
						
						var li = $("<li><span>Error: "+data+"</span<</li>");	
						$("#uploadErrorMsgList").prepend(li);
					}
				}); 
			
				return false;
			});
		
			
		});
		
		function notAssignable() {
			$("#assignBtn").hide();
			$("#selectRadios").hide();
			$(".selectAppCB").hide();
		}
		function assignable() {
			$("#assignBtn").show();
			$("#selectRadios").show();
			$(".selectAppCB").show();			
		}
		function changeRound() {
			if ($("#roundSelector").val() == -1) {
				assignable();
			} else {
				notAssignable();
			}
		}

function save_attrs_in_hidden(datatype) {
	var table = $('#addRemoveFieldsDialog .tableSelector.' + datatype);
	var selected_fields = table.find('input:checked');
	var hidden_val = '';
	for(var i=0; i<selected_fields.length;i++) {
		hidden_val += $(selected_fields[i]).attr('name') + ',';
	}
	if (hidden_val.length > 0) {
		hidden_val = hidden_val.substr(0, hidden_val.length - 1);
	}
	var hidden_input_id = 'add_remove_' + datatype;
	$('#' + hidden_input_id).val(hidden_val);
}
