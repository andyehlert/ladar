<div class="login-page">

	<div class="inner-page">
		<h3>Sign in</h3>
		<form accept-charset="utf-8" class="user-login">
			<p>
				<!-- User login form. -->
				<label for="user-email">Email Address:</label>
				<input type="text" class="login-input" id="login-username" name="user-email">
				<label for="user-password">Password:</label>
				<input type="text" class="login-input" id="login-password" name="user-password">
				<button type="button" class="btn header-btn" id="si-btn2">Sign in</button>
			</p>
		</form>
	
		<p>Not currently registered? To sign up <a href="javascript:void(0)" id="su-link">click here</a>.</p>
	</div>
	
</div>

<script>
	$('#su-link').on("click", function() {
		$('.content').load("pages/sign-up.jsp");
	});
	
	$('.login-button').on("click", function() {
		$('.content').load("pages/user_profile.jsp");
	});
</script>