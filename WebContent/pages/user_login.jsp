<div class="login-page">

	<div class="inner-page">
		<h3><strong>Sign in</strong></h3>
		<form accept-charset="utf-8" class="user-login">
			<p>
				<!-- User login form. -->
				<label for="user-email">Email Address:</label>
				<input type="email" class="login-input" id="login-username" name="user-email">
				<label for="user-password">Password:</label>
				<input type="password" class="login-input" id="login-password" name="user-password">
				<button type="button" class="btn header-btn" id="si-btn2">Sign in</button>
			</p>
		</form>
	
		<p>Not currently registered? <a href="javascript:void(0)" id="su-link">Sign up</a></p>
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