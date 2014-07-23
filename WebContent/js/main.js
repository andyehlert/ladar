var login_email = "";

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
	formData += SerializeCheckboxes();
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
	var formData = $('#trans-preferences').serialize() + "&user-email=" + login_email;
	formData += SerializeCheckboxes();
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
function VerifyLogin() {
	/* Serializes user preferences form data. */
	var formData = $('#signin-form').serialize();
	console.log(formData);
	
	/* Makes ajax call to store new preferences in user database. */
	$.ajax({
		url: "api/authenticate.jsp",
		type: "POST",
		data: formData,
		dataType: "text",
		async: false,
		success: function(data) {
			var dataContent = data.toString().split(";");
			login_email = dataContent[0];
			console.log(login_email);
			if(login_email == "fail") {
				/* Append message letting user know of the failed login attempt. */
				alert("Login attempt failed. Please try another email and password combination.");
			} else {
				$('#page-content').load("pages/user_profile.jsp");
				LoadPage();
			}
		}
	});
	
	
	
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
		if(box.prop("checked")) {
			box.val(1);
		} else {
			box.val(0);
		}
		CheckboxValue();
	});
}

/**
 * 
 */
function SerializeCheckboxes() {
	var data = "";
	var value = $('#cash-pref').prop("checked");
	data += "&cash-pref=" + value;
	value = $('#bank-wire-pref').prop("checked");
	data += "&bank-wire-pref=" + value;
	value = $('#cash-deposit-pref').prop("checked");
	data += "&cash-deposit-pref=" + value;
	value = $('#paypal-pref').prop("checked");
	data += "&paypal-pref=" + value;
	value = $('#other-pref').prop("checked");
	data += "&other-pref=" + value;
	
	return data;
}