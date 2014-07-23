<div class="site-page">
	<div class="inner-page" id="inner-profile">
		<h3><strong>Submit a Transaction Request</strong></h3>
		<form class="request-form" action="JavaScript:SubmitTransaction()">
			<select><option value="USD">USD</option><option value="BTC">BTC</option></select>
			<input type="text" name="amount" placeholder="Amount">
			<select><option value="BTC">BTC</option><option value="USD">USD</option></select>
			<button type="submit" class="btn header-btn" id="request-btn">Submit</button>
		</form> 
		
		<p>The settings below will be used for this transaction request. Be sure to make any changes necessary before submitting your request. <br>
		You can click the save button at the bottom of the page to save the settings as your default settings for future transactions. </p>
	</div>

	<div id="user-preferences">
		<h4><strong>Transaction Preferences</strong></h4>
		<div class="inner-page" id="inner-pref">
			<form id="trans-preferences">
				<p>
					<label for="wallet-pref">Bitcoin Wallet Address</label> <input
						type="text" id="wallet-pref" name="wallet-pref">
				</p>
				<p>
					<label for="location-pref">Location</label> <input type="text"
						id="location-pref" name="location-pref">
				</p>
				<p>
					<label for="rating-pref">Preferred Reputation</label> <select
						id="rating-pref" name="rating-pref"><option value="0">Any</option>
						<option value=1>1+</option>
						<option value=2>2+</option>
						<option value=3>3+</option>
						<option value=4>4+</option>
						<option value=5>5</option></select>
				</p>
				<p>
					<label for="trans-number-pref">Transactions Completed</label> <select
						id="trans-number-pref" name="trans-number-pref"><option
							value="0">Any</option>
						<option value=50>0-50</option>
						<option value=100>50-100</option>
						<option value=250>100-250</option>
						<option value=500>250-500</option>
						<option value=1000>500-1000</option>
						<option value=1001>1000+</option></select>
				</p>
				<p>
					<label for="timeframe-pref">Time Frame</label> <select
						id="timeframe-pref" name="timeframe-pref"><option
							value=0>Any</option>
						<option value=1>Today</option>
						<option value=2>This week</option>
						<option value=3>This month</option></select>
				</p>
				<p id="checkboxes-pref">
					<input type="checkbox" value='FALSE' class="payment-pref" id="cash-pref">Cash	
					<input type="checkbox" value='FALSE' class="payment-pref" id="bank-wire-pref">Bank
					Wire	 <input type="checkbox" value='FALSE' class="payment-pref"
						id="cash-deposit-pref">Cash Deposit	 <input
						type="checkbox" value='FALSE' class="payment-pref" id="paypal-pref">Paypal	
					<input type="checkbox" value='FALSE' class="payment-pref" id="other-pref">Other<br>
				</p>
				
				<p>
					<button type="button" class="btn header-btn" id="save-btn">Save Settings as Default</button>
				</p>

			</form>
		</div>
	</div>

	<div id="transactions">
		<div id="request-match" class="inner-page">
			<h4>
				<strong>Matching Transaction</strong>
			</h4>
			<p>
				The transaction match information will show up here. <a
					class="response-link" id="match-accept"
					href="JavaScript:acceptLink()">Accept</a> <a class="response-link"
					id="match-decline" href="JavaScript:declineLink()">Decline</a>
			</p>
		</div>
		<div id="next-request-match" class="inner-page">
			<h4>
				<strong>Matching Transaction</strong>
			</h4>
			<p>
				The next transaction match information will show up here. <a
					class="response-link" id="match-accept"
					href="JavaScript:acceptLink()">Accept</a> <a class="response-link"
					id="match-decline" href="JavaScript:declineLink()">Decline</a>
			</p>
		</div>
		<div id="request-accept" class="inner-page">
			<h4>
				<strong>Accepted Transaction</strong>
			</h4>
			<p>
				You have successfully accepted the transaction. <br> When both
				parties have accepted you will recieve an email containing the other
				party's contact information.
			</p>
		</div>
	</div>

</div>