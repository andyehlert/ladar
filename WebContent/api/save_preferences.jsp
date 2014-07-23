<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%
try {
	
	String driver = "org.postgresql.Driver";
	String url = "jdbc:postgresql://ec2-54-204-42-135.compute-1.amazonaws.com:5432/dal7m7vq7mvnhm?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
	String username = "qrqtiswaifzehm";
	String password = "uS3cn1kfbC16j3VF2ZqHddvpfx";
	String myDataField = null;
	
	String myQuery = "SELECT * FROM user_db";
	
	String myInsert = "INSERT INTO trans_db (location, num_of_trans, trans_time, reputation, cash, bank_wire, paypal, cash_deposit, other) VALUES('" + request.getParameter("location-pref") +"', '" + request.getParameter("trans-number-pref") +"', '" + request.getParameter("timeframe-pref") +"', '" + request.getParameter("rating-pref") +"', '" + request.getParameter("cash-pref") +"', '" + request.getParameter("bank-wire-pref") +"', '" + request.getParameter("paypal-pref") +"', '" + request.getParameter("cash-deposit-pref") +"', '" + request.getParameter("other-pref") +"')";
	
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
		myDataField = myResultSet.getString("location");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("num_of_trans");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("trans_time");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("distance");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("cash");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("bank_wire");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("paypal");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("cash_deposit");
		System.out.println(myDataField);
		myDataField = myResultSet.getString("other");
		System.out.println(myDataField);
		System.out.println();
	}
} catch(ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException ex) {
	out.print("SQLException: "+ex.getMessage());
	out.print("SQLState: " + ex.getSQLState());
	out.print("VendorError: " + ex.getErrorCode());
}
%>l>