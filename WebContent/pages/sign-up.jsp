<div>

	<h3><strong>User Sign-Up</strong></h3>
	<form>
		<p>
			<label for="signup-email">Email Address:</label>
			<input type="text" name="signup-email" id="signup-email">
		</p>
		<p>
			<label for="signup-email2">Repeat Email Address:</label>
			<input type="text" name="signup-email2" id="signup-email2">
		</p>
		<p>
			<label for="signup-password">Password:</label>
			<input type="text" name="signup-password" id="signup-password">
		</p>
		<p>
			<label for="signup-password2">Repeat Password:</label>
			<input type="text" name="signup-password2" id="signup-password2">
		</p>
		<p><button type="submit" class="signup-button">Sign Up</button></p>
	</form>
	
</div>

<script>
	$('.signup-button').on("click", function() {
		$('.content').load("pages/user_profile.jsp");
	});
</script>