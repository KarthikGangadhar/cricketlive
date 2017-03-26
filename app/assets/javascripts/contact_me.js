// Contact Form Scripts

$(function() {

    $("#contactForm input,#contactForm textarea").jqBootstrapValidation({
        preventSubmit: true,
        submitError: function($form, event, errors) {
            // additional error messages or events
        },
        submitSuccess: function($form, event) {
            event.preventDefault(); // prevent default submit behaviour
            // get values from FORM
            var name = $("input#name").val();
            var email = $("input#email").val();
            var phone = $("input#phone").val();
            var message = $("textarea#message").val();
            var firstName = name; // For Success/Failure Message
            // Check for white space in name for Success/Fail message
            if (firstName.indexOf(' ') >= 0) {
                firstName = name.split(' ').slice(0, -1).join(' ');
            }
            $.ajax({
                url: "././mail/contact_me.php",
                type: "POST",
                data: {
                    name: name,
                    phone: phone,
                    email: email,
                    message: message
                },
                cache: false,
                success: function() {
                    // Success message
                    $('#success').html("<div class='alert alert-success'>");
                    $('#success > .alert-success').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                        .append("</button>");
                    $('#success > .alert-success')
                        .append("<strong>Your message has been sent. </strong>");
                    $('#success > .alert-success')
                        .append('</div>');

                    //clear all fields
                    $('#contactForm').trigger("reset");
                },
                error: function() {
                    // Fail message
                    $('#success').html("<div class='alert alert-danger'>");
                    $('#success > .alert-danger').html("<button type='button' class='close' data-dismiss='alert' aria-hidden='true'>&times;")
                        .append("</button>");
                    $('#success > .alert-danger').append($("<strong>").text("Sorry " + firstName + ", it seems that my mail server is not responding. Please try again later!"));
                    $('#success > .alert-danger').append('</div>');
                    //clear all fields
                    $('#contactForm').trigger("reset");
                },
            });
        },
        filter: function() {
            return $(this).is(":visible");
        },
    });

    $("a[data-toggle=\"tab\"]").click(function(e) {
        e.preventDefault();
        $(this).tab("show");
    });
});


/*When clicking on Full hide fail/success boxes */
$('#name').focus(function() {
    $('#success').html('');
});

var total_news = $('.cl-nws-lst').length;

// for list and box 
$('.cl-nws-lst').slice(5).css("display", "none");
$('.cl-news-box').slice(5).css("display", "none");


$('.cl-nws-lst').slice(0, 5 ).addClass('show');
$('.cl-news-box').slice(0, 5 ).addClass('show');
$('#prop_load_more').on('click', function(){
	var news_length = $('.cl-nws-lst').length;
	var visible_property_count = $('.cl-nws-lst.show').length;
	_slicer_window = 5;
	
	$('.cl-nws-lst').slice(visible_property_count, visible_property_count + _slicer_window).addClass('show');
	$('.cl-news-box').slice(visible_property_count, visible_property_count + _slicer_window).addClass('show');
	
	if (visible_property_count ==  news_length)
	{
		$('#prop_load_more').hide();
	}
});

$('#schedule_date').show();
$('#schedule_team').hide();

$('#team_schedule').on('click', function(){
	$('#schedule_date').hide();
	$('#schedule_team').show();
});

$('#date_schedule').on('click', function(){
	$('#schedule_date').show();
    $('#schedule_team').hide();
});

$('#squard_details').addClass('hide');

$('#squard_update_nav').on('click',function(){
	if($('#match_details').hasClass('show')){
		$('#match_details').removeClass('show');
		$('#match_details').addClass('hide');
	}
	else{
		$('#match_details').addClass('hide');
	}
	
	if($('#squard_details').hasClass('hide')){
		$('#squard_details').removeClass('hide');
		$('#squard_details').addClass('show');
	}
	else{
		$('#squard_details').addClass('show');
	}
});

$('#live_update_nav').on('click',function(){
	if($('#match_details').hasClass('hide')){
		$('#match_details').removeClass('hide');
		$('#match_details').addClass('show');
	}
	if($('#squard_details').hasClass('show')){
		$('#squard_details').removeClass('show');
		$('#squard_details').addClass('hide');
	}
});

$('#team_detail_nav').on('click',function(){
	if($('#match_details').hasClass('hide')){
		$('#match_details').removeClass('hide');
		$('#match_details').addClass('show');
	}
	if($('#squard_details').hasClass('show')){
		$('#squard_details').removeClass('show');
		$('#squard_details').addClass('hide');
	}
});


