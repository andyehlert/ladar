<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%
try {
	
	String driver = "org.postgresql.Driver";
	String url = "jdbc:postgresql://ec2-54-204-42-135.compute-1.amazonaws.com:5432/dal7m7vq7mvnhm?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
	String username = "qrqtiswaifzehm";
	String password = "uS3cn1kfbC16j3VF2ZqHddvpfx";
	String myDataField = "";
	
	String myQuery = "SELECT * FROM user_db WHERE email_address = '" + request.getParameter("signup-email") + "'";
	
	String myInsert = "INSERT INTO user_db (email_address, password, wallet_address, num_of_transactions, location, trans_pref, trans_timeframe, reputation_pref, cash, bank_wire, paypal, cash_deposit, other) VALUES('" + request.getParameter("signup-email") + "', '" + request.getParameter("signup-password") +"', '" + request.getParameter("wallet-addr") +"', 0, '', 0, 0, 0, 'false', 'false', 'false', 'false', 'false')";
	
	Connection myConnection;
	PreparedStatement myPreparedStatement;
	PreparedStatement myStatement;
	ResultSet myResultSet;
	PrintWriter result;
	
	
	Class.forName(driver).newInstance();
	myConnection = DriverManager.getConnection(url,username,password);
	
	myStatement = myConnection.prepareStatement(myInsert);
	myStatement.execute();
	
	myPreparedStatement = myConnection.prepareStatement(myQuery);
	myResultSet = myPreparedStatement.executeQuery();
	result = response.getWriter();
	while(myResultSet.next()) {
		result.write(request.getParameter("signup-email") + ";");
		result.write(myResultSet.getString("wallet_address") + ";");
		result.write(myResultSet.getString("location") + ";");
		result.write(myResultSet.getInt("reputation_pref") + ";");
		result.write(myResultSet.getInt("trans_pref") + ";");
		result.write(myResultSet.getInt("trans_timeframe") + ";");
		result.write(myResultSet.getBoolean("cash") + ";");
		result.write(myResultSet.getBoolean("bank_wire") + ";");
		result.write(myResultSet.getBoolean("cash_deposit") + ";");
		result.write(myResultSet.getBoolean("paypal") + ";");
		result.write(myResultSet.getBoolean("other") + "");
	}
	
	
	

	myResultSet.close();
	myStatement.close();
	myConnection.close();
	result.close();
	
} catch(ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException ex) {
	out.print("SQLException: "+ex.getMessage());
	out.print("SQLState: " + ex.getSQLState());
	out.print("VendorError: " + ex.getErrorCode());
}
%>