/**
 * 
 */
function LoadPage() {
	/* Removes old bound click events. */
	$('#hiw-btn').unbind("click");
	$('#au-btn').unbind("click");
	$('#logo').unbind("click");
	$('#cu-btn').unbind("click");
	$('#si-btn').unbind("click");
	$('#si-btn2').unbind("click");
	$('#btn-signup').unbind("click");
	$('#su-link').unbind("click");
	$('#request-btn').unbind("click");
	$('#save-btn').unbind("click");
	
	/*  */
	CheckboxValue();
	
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
	
	/* Sets click event behavior for the Already a Member link. */
	$('#si-btn').on("click", function() {
		$('#page-content').load("pages/user_login.jsp", function() {
			LoadPage();
		});
	});
	
	/* Sets click event behavior for the Sign Up button on the user sign up page. */
	$('#si-btn2').on("click", function() {
		$('#page-content').load("pages/user_profile.jsp", function() {
			LoadPage();
		});
	});
	
	/* Sets click event behavior for the Sign Up button on the landing page. */
	$('#btn-signup').on("click", function() {
		$('#page-content').load("pages/sign-up.jsp", function() {
			LoadPage();
		});
	});
	
	/* Sets click event behavior for the Sign Up link on the user sign in page. */
	$('#su-link').on("click", function() {
		$('#page-content').load("pages/sign-up.jsp", function() {
			LoadPage();
		});
	});
	
	/* Sets click event behavior for transaction request button on the user profile page. */
	$('#request-btn').on("click", function() {
		$('#request-match').css("display", "block");
		$('#next-request-match').css("display", "none");
		$('#request-accept').css("display", "none");
	});
	
	/* Sets click event behavior for the save settings button on the user profile page. */
	$('#save-btn').on("click", function() {
		var save = confirm("Are you sure you would like to save these settings as your default preferences? They will be automatically loaded in the provided boxes every tim you log into your Ladar account.");
		if(save) {
			/* Write preferences to user database. */
		}
		LoadPage();
	});
}

/**
 * 
 */
function acceptLink() {
	$('#request-match').css("display", "none");
	$('#next-request-match').css("display", "none");
	$('#request-accept').css("display", "block");
}

/**
 * 
 */
function declineLink() {
	$('#request-match').css("display", "none");
	$('#next-request-match').css("display", "block");
}

/**
 * 
 */
function SubmitTransaction() {
	/* Serializes beta sign up form data. */
	var formData = $('.request-form').serialize() + "&";
	formData += $('#trans-preferences').serialize();
	console.log(formData);
	
	/* Makes ajax call to store new email in beta list. */
	$.ajax({
		url: "api/submit_transaction.jsp",
		type: "POST",
		data: formData,
		async: false
	});
	
	/* Loads the sign up success page into the page content div. */
	$('#request-match').css("display", "block");
	$('#next-request-match').css("display", "none");
	$('#request-accept').css("display", "none");
	
	return false;
}

/**
 * 
 */
function SavePreferences() {
	/* Serializes user preferences form data. */
	var formData = $('#trans-preferences').serialize();
	console.log(formData);
	
	/* Makes ajax call to store new preferences in user database. */
	$.ajax({
		url: "api/save_preferences.jsp",
		type: "POST",
		data: formData,
		async: false
	});
	
	/* Notifies the user that the preferences have been saved. */
	alert("The current preferences have successfully been saved as your default preferences.");
	
	return false;
}

/**
 * 
 */
function CheckboxValue() {
	/* Unbinds any previous change event behavior from the checkboxes. */
	$('.payment-pref').unbind("change");
	
	/* Reassigns the checkbox value when a change is made. */
	$('.payment-pref').on("change", function() {
		var box = $(this);
		box.val(box.prop("checked"));
		CheckboxValue();
	});
}