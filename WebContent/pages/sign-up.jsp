<div class="login-page">

	<div class="inner-page">
		<h3><strong>User Sign-Up</strong></h3>
		<form action="api/save_user_login.jsp">
			<p>
				<label class="su-label" for="signup-email">Email Address:</label>
				<input class="su-input" type="email" name="signup-email" id="signup-email">
			</p>
			<!--  <p>
				<label class="su-label" for="signup-email2">Repeat Email Address:</label>
				<input class="su-input" type="email" name="signup-email2" id="signup-email2">
			</p>-->
			<p>
				<label class="su-label" for="wallet-addr">Bitcoin Wallet Address:</label>
				<input class="su-input" type="text" name="wallet-addr" id="wallet-addr">
			</p>
			<p>
				<label class="su-label" for="signup-password">Password:</label>
				<input class="su-input" type="password" name="signup-password" id="signup-password">
			</p>
			<p>
				<label class="su-label" for="signup-password2">Confirm Password:</label>
				<input class="su-input" type="password" name="signup-password2" id="signup-password2">
			</p>

			<p><button type="submit" class="btn header-btn" id="si-btn2">Sign Up</button></p>
		</form>
	</div>
	
</div>

<script>
	$('.signup-button').on("click", function() {
		$('.content').load("pages/user_profile.jsp");
	});
</script>