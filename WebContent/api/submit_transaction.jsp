<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="ladar.*" %>
<%
try {
	
	String driver = "org.postgresql.Driver";
	String url = "jdbc:postgresql://ec2-54-204-42-135.compute-1.amazonaws.com:5432/dal7m7vq7mvnhm?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
	String username = "qrqtiswaifzehm";
	String password = "uS3cn1kfbC16j3VF2ZqHddvpfx";
	String myDataField = "";
	double myDataDouble;
	int myDataInt;
	boolean paymentData;
	String role = "";
	String otherRole = "";
	
	if(request.getParameter("to-currency").equals("BTC")) {
		role = "buyer";
		otherRole = "seller";
	} else if(request.getParameter("from-currency").equals("BTC")) {
		role = "seller";
		otherRole = "buyer";
	}
	
	Connection myConnection;
	PreparedStatement myPreparedStatement;
	PreparedStatement myStatement;
	PreparedStatement myMatchStatement;
	ResultSet myResultSet;
	
	Class.forName(driver).newInstance();
	myConnection = DriverManager.getConnection(url,username,password);
	
	String myQuery = "SELECT * FROM user_db WHERE email_address='" + request.getParameter("user-email") +"'";
	double rep;
	int num_trans;
	myPreparedStatement = myConnection.prepareStatement(myQuery);
	myResultSet = myPreparedStatement.executeQuery();
	myResultSet.next();
	rep = myResultSet.getDouble("reputation");
	num_trans = myResultSet.getInt("num_of_transactions");
	
	String myInsert = "INSERT INTO trans_db (from_currency, to_currency, status, amount, " + role + ", " + otherRole + ", location, trans_pref, trans_time, reputation_pref, cash, bank_wire, paypal, cash_deposit, other, reputation, num_of_trans) VALUES('" + request.getParameter("from-currency") + "', '" + request.getParameter("to-currency") + "', 'submitted', '" + request.getParameter("amount") +"', '" + request.getParameter("user-email") + "', '', '" + request.getParameter("location-pref") +"', '" + request.getParameter("trans-number-pref") +"', '" + request.getParameter("timeframe-pref") +"', '" + request.getParameter("rating-pref") +"', '" + request.getParameter("cash-pref") +"', '" + request.getParameter("bank-wire-pref") +"', '" + request.getParameter("paypal-pref") +"', '" + request.getParameter("cash-deposit-pref") +"', '" + request.getParameter("other-pref") + "', '" + rep + "', '" + num_trans + "')";
	myStatement = myConnection.prepareStatement(myInsert);
	myStatement.execute();
	
	Map<String, String> params = new HashMap<String, String>();
	params.put("from_currency", request.getParameter("from-currency"));
	params.put("to_currency", request.getParameter("to-currency"));
	params.put("role", role);
	params.put("email", request.getParameter("user-email"));
	params.put("amount", request.getParameter("amount"));
	params.put("location", request.getParameter("location-pref"));
	params.put("trans_pref", request.getParameter("trans-number-pref"));
	params.put("trans_time", request.getParameter("timeframe-pref"));
	params.put("reputation_pref", request.getParameter("rating-pref"));
	params.put("cash", request.getParameter("cash-pref"));
	params.put("bank_wire", request.getParameter("bank-wire-pref"));
	params.put("paypal", request.getParameter("paypal-pref"));
	params.put("cash_deposit", request.getParameter("cash-deposit-pref"));
	params.put("other", request.getParameter("other-pref"));
	params.put("reputation", rep + "");
	params.put("num_of_trans", num_trans + "");
	
	String match = Ladar.findMatch(myConnection, params);

	myResultSet.close();
	myPreparedStatement.close();
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