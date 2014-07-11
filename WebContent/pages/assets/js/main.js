/**
 * 
 */

function LoadPage() {
	
	$('#hiw-btn').on("click", function() {
		$('#page-content').load("how_it_works.jsp", function() {
			LoadPage();
		});
	});
	
	$('#au-btn').on("click", function() {
		$('#page-content').load("landing.jsp", function() {
			LoadPage();
		});
	});
	
	$('#logo').on("click", function() {
		$('#page-content').load("landing.jsp", function() {
			LoadPage();
		});
	});
	
	$('#cu-btn').on("click", function() {
		$('#page-content').load("contact_us.jsp", function() {
			LoadPage();
		});
	});
	
	$('#si-btn').on("click", function() {
		$('#page-content').load("user_login.jsp", function() {
			LoadPage();
		});
	});
	
	$('#si-btn2').on("click", function() {
		$('#page-content').load("user_profile.jsp", function() {
			LoadPage();
		});
	});
	
	$('#btn-signup').on("click", function() {
		$('#page-content').load("sign-up.jsp", function() {
			LoadPage();
		});
	});
	
	$('#su-link').on("click", function() {
		$('#page-content').load("sign-up.jsp", function() {
			LoadPage();
		});
	});
}