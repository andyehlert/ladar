<div class="site-page">
	<div class="inner-page">
		<h3>Submit a Transaction Request</h3>
		<form class="request-form">
			<select><option value="USD">USD</option><option value="BTC">BTC</option></select>
			<input type="text" placeholder="Amount">
			<select><option value="BTC">BTC</option><option value="USD">USD</option></select>
			<button type="button" class="btn header-btn" id="request-btn">Submit</button>
		</form>
	</div>
	<div id="request-match" class="inner-page">
		<h3><strong>Matching Transaction</strong></h3>
		<p>The transaction match information will show up here.  <a class="response-link" id="match-accept" href="JavaScript:acceptLink()">Accept</a>   <a class="response-link" id="match-decline" href="JavaScript:declineLink()">Decline</a></p>
	</div>
	<div id="next-request-match" class="inner-page">
		<h3><strong>Matching Transaction</strong></h3>
		<p>The next transaction match information will show up here.  <a class="response-link" id="match-accept" href="JavaScript:acceptLink()">Accept</a>   <a class="response-link" id="match-decline" href="JavaScript:declineLink()">Decline</a></p>
	</div>
	<div id="request-accept" class="inner-page">
		<h3><strong>Accepted Transaction</strong></h3>
		<p>You have successfully accepted the transaction. <br>
		When both parties have accepted you will recieve an email containing the other party's contact information.</p>
	</div>
</div>