/**
 * 
 */
function LoadPage() {
	/* Removes old bound click events. */
	$('#hiw-btn').unbind("click");
	$('#au-btn').unbind("click");
	$('#logo').unbind("click");
	$('#cu-btn').unbind("click");
	
	/* Sets click event behavior for the How It Works button. */
	$('#hiw-btn').on("click", function() {
		$('#page-content').load("pages/how_it_works.jsp", function() {
			LoadPage();
		});
	});
	
	/* Sets click event behavior for the About Us button. */
	$('#au-btn').on("click", function() {
		$('#page-content').load("pages/about_us.jsp", function() {
			LoadPage();
		});
	});
	
	/* Sets click event behavior for the Logo/Home button. */
	$('#logo').on("click", function() {
		$('#page-content').load("pages/landing.jsp", function() {
			LoadPage();
		});
	});
	
	/* Sets click event behavior for the Contact Us button. */
	$('#cu-btn').on("click", function() {
		$('#page-content').load("pages/contact_us.jsp", function() {
			LoadPage();
		});
	});
}

/**
 * 
 */
function AddToBeta() {
	/* Serializes beta sign up form data. */
	var formData = $('#signup-form').serialize();
	
	/* Makes ajax call to store new email in beta list. */
	$.ajax({
		url: "form_acceptor.jsp",
		type: "POST",
		data: formData,
		async: false
	});
	
	/* Loads the sign up success page into the page content div. */
	$('#page-content').load("pages/signup_success.jsp");
	
	return false;
}