/**
 * 
 */
function LoadPage() {
	
	$('#hiw-btn').on("click", function() {
		$('#page-content').load("pages/how_it_works.jsp", function() {
			LoadPage();
		});
	});
	
	$('#au-btn').on("click", function() {
		$('#page-content').load("pages/about_us.jsp", function() {
			LoadPage();
		});
	});
	
	$('#logo').on("click", function() {
		$('#page-content').load("pages/landing.jsp", function() {
			LoadPage();
		});
	});
	
	$('#cu-btn').on("click", function() {
		$('#page-content').load("pages/contact_us.jsp", function() {
			LoadPage();
		});
	});
}

function AddToBeta() {
	var formData = $('#signup-form').serialize();
	
	$.ajax({
		url: "form_acceptor.jsp",
		type: "POST",
		data: formData,
		async: false
	});
	$('#page-content').load("pages/signup_success.jsp");
	return false;
}