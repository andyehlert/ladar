/* Global variable used to identify which user is logged in. */
var login_email = "";


/**
 * Sets all of the necessary button and link behavior when a new
 * page is loaded.
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
	
	/* Sets click event behavior for the Payment button. */
	$('#p-btn').on("click", function() {
		$('#page-content').load("pages/payment.jsp", function() {
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
}


/**
 * Temporary function that displays a transaction acceptance message.
 */
function acceptLink() {
	/* Displays the transaction acceptance message and hides the others. */
	$('#request-match').css("display", "none");
	$('#next-request-match').css("display", "none");
	$('#request-accept').css("display", "block");
}


/**
 * Temporary function that displays a transaction declined message with a 
 * message representing the next transaction match proposal.
 */
function declineLink() {
	/* Displays the next transaction proposal. */
	$('#request-match').css("display", "none");
	$('#next-request-match').css("display", "block");
}


/**
 * Creates a new user entry in the user database and initializes all required
 * column values when a sign up form is submitted.
 */
function UserSignup() {
	/* Serializes user sign up form data. */
	var formData = $('#signup-form').serialize();
	
	/* Makes ajax call to store new user vital information in user database. */
	$.ajax({
		url: "api/save_user_login.jsp",
		type: "POST",
		data: formData,
		async: false,
		success: function(data) {
			var dataContent = data.toString().split(";");
			login_email = dataContent[0];
		}
	});
	
	/* Loads the new user's profile page once registration is complete. */
	$('#page-content').load("pages/user_profile.jsp");
	LoadPage();
	
	return false;
}


/**
 * Creates a new entry in the transaction database and initializes all column values
 * when a user submits a transaction request form from their profile page.
 */
function SubmitTransaction() {
	/* Serializes transaction form data. */
	var formData = $('.request-form').serialize() + "&";
	formData += $('#trans-preferences').serialize();
	formData += SerializeCheckboxes() + "&user-email=" + login_email;
	
	/* Makes ajax call to store new transaction in database. */
	$.ajax({
		url: "api/submit_transaction.jsp",
		type: "POST",
		data: formData,
		async: false
	});
	
	/* Loads transaction information into the right side of the user profile. */
	$('#request-match').css("display", "block");
	$('#next-request-match').css("display", "none");
	$('#request-accept').css("display", "none");
	
	return false;
}


/**
 * Overwrites old user preferences with the new values when a user submits the save 
 * as default preferences form on their profile page.
 */
function SavePreferences() {
	/* Serializes user preferences form data. */
	var formData = $('#trans-preferences').serialize() + "&user-email=" + login_email;
	formData += SerializeCheckboxes();
	
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
 * Checks the user database for an entry with email and password values that match those
 * submitted by the sign in form. Upon success, the user's profile page is loaded and 
 * their default preferences are loaded into the preferences form on the profile page.
 */
function VerifyLogin() {
	/* Serializes user sign in form data. */
	var formData = $('#signin-form').serialize();
	
	/* Makes ajax call to verify the provided email-password combination. */
	$.ajax({
		url: "api/authenticate.jsp",
		type: "GET",
		data: formData,
		dataType: "text",
		async: false,
		success: function(data) {
			var dataContent = data.toString().split(";");
			login_email = dataContent[0];
			if(login_email == "fail") {
				/* Append message letting user know of the failed login attempt. */
				alert("Login attempt failed. Please try another email and password combination.");
			} else {
				/* Loads the user's default preferences into the preferences form on their profile page. */
				$('#page-content').load("pages/user_profile.jsp", function() {
					$('#wallet-pref').val(dataContent[1]);
					$('#location-pref').val(dataContent[2]);
					$('#rating-pref').val(parseInt(dataContent[3]));
					$('#trans-number-pref').val(parseInt(dataContent[4]));
					$('#timeframe-pref').val(parseInt(dataContent[5]));
					$('#cash-pref').prop("checked", (dataContent[6] === "true"));
					$('#bank-wire-pref').prop("checked", (dataContent[7] === "true"));
					$('#cash-deposit-pref').prop("checked", (dataContent[8] === "true"));
					$('#paypal-pref').prop("checked", (dataContent[9] === "true"));
					$('#other-pref').prop("checked", (dataContent[10] === "true"));
					LoadTransactions();
					LoadPage();
				});
			}
		}
	});
	
	return false;
}


/**
 * Loads the active transaction requests for a user to their
 * profile page upon a successful login.
 */
function LoadTransactions() {
	/* Serializes the data to be used for the ajax call. */
	var ajaxData = "user-email=" + login_email;
	
	/* Makes ajax call to retrieve user's active transactions info. */
	$.ajax({
		url: "api/view_transactions.jsp",
		type: "GET",
		data: ajaxData,
		dataType: "text",
		async: false,
		success: function(data) {
			/* Put information into the transaction managment profile section. */
		}
	});
	
	return false;
}


/**
 * Serializes the checkbox values into a string that will be used as a part of 
 * the data option in an ajax call.
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

function payment(){
	Bitpay bitpay = new Bitpay("API_KEY", "USD");
}
