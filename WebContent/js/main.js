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
		$('#page-content').load("pages/landing.jsp", function() {
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
	
	$('#si-btn').on("click", function() {
		$('#page-content').load("pages/user_login.jsp", function() {
			LoadPage();
		});
	});
	
	$('#si-btn2').on("click", function() {
		$('#page-content').load("pages/user_profile.jsp", function() {
			LoadPage();
		});
	});
	
	$('#btn-signup').on("click", function() {
		$('#page-content').load("pages/sign-up.jsp", function() {
			LoadPage();
		});
	});
	
	$('#su-link').on("click", function() {
		$('#page-content').load("pages/sign-up.jsp", function() {
			LoadPage();
		});
	});
	
	$('#request-btn').on("click", function() {
		$('#request-match').css("display", "block");
		$('#next-request-match').css("display", "none");
		$('#request-accept').css("display", "none");
	});
}

function acceptLink() {
	$('#request-match').css("display", "none");
	$('#next-request-match').css("display", "none");
	$('#request-accept').css("display", "block");
}

function declineLink() {
	$('#request-match').css("display", "none");
	$('#next-request-match').css("display", "block");
}