<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%
try {
	
	String driver = "org.postgresql.Driver";
	String url = "jdbc:postgresql://ec2-54-204-42-135.compute-1.amazonaws.com:5432/dal7m7vq7mvnhm?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
	String username = "qrqtiswaifzehm";
	String password = "uS3cn1kfbC16j3VF2ZqHddvpfx";
	String myDataField = "";
	int myDataInt;
	boolean payment;
	
	String myQuery = "SELECT * FROM user_db WHERE email_address = '" + request.getParameter("user-email") + "'";
	
	String myInsert = "UPDATE user_db SET (wallet_address, location, trans_pref, trans_timeframe, reputation_pref, cash, bank_wire, paypal, cash_deposit, other) = ('" + request.getParameter("wallet-pref") +"', '" + request.getParameter("location-pref") +"', '" + request.getParameter("trans-number-pref") +"', '" + request.getParameter("timeframe-pref") +"', '" + request.getParameter("rating-pref") +"', '" + request.getParameter("cash-pref") +"', '" + request.getParameter("bank-wire-pref") +"', '" + request.getParameter("paypal-pref") +"', '" + request.getParameter("cash-deposit-pref") +"', '" + request.getParameter("other-pref") +"') WHERE email_address = '" + request.getParameter("user-email") +"'";
	
	Connection myConnection;
	PreparedStatement myPreparedStatement;
	PreparedStatement myStatement;
	ResultSet myResultSet;
	
	
	Class.forName(driver).newInstance();
	myConnection = DriverManager.getConnection(url,username,password);
	
	myStatement = myConnection.prepareStatement(myInsert);
	myStatement.execute();
	
	myPreparedStatement = myConnection.prepareStatement(myQuery);
	myResultSet = myPreparedStatement.executeQuery();
	while(myResultSet.next()) {
		myDataField = myResultSet.getString("email_address");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("wallet_address");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("location");
		System.out.println(myDataField);
		myDataInt = myResultSet.getInt("trans_pref");
		System.out.println(myDataInt);
		myDataInt = myResultSet.getInt("trans_timeframe");
		System.out.println(myDataInt);
		myDataInt = myResultSet.getInt("reputation_pref");
		System.out.println(myDataInt);
		myDataInt = myResultSet.getInt("distance");
		System.out.println(myDataInt);
		payment = myResultSet.getBoolean("cash");
		System.out.println(payment);
		payment = myResultSet.getBoolean("bank_wire");
		System.out.println(payment);
		payment = myResultSet.getBoolean("cash_deposit");
		System.out.println(payment);
		payment = myResultSet.getBoolean("paypal");
		System.out.println(payment);
		payment = myResultSet.getBoolean("other");
		System.out.println(payment);
		System.out.println();
	}

	myResultSet.close();
	myStatement.close();
	myConnection.close();
	
} catch(ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException ex) {
	out.print("SQLException: "+ex.getMessage());
	out.print("SQLState: " + ex.getSQLState());
	out.print("VendorError: " + ex.getErrorCode());
}
%>