<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%
try {
	
	String driver = "org.postgresql.Driver";
	String url = "jdbc:postgresql://ec2-54-204-16-70.compute-1.amazonaws.com:5432/d8ri4oh9l02soa?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
	String username = "ugucbxgbjfeqpw";
	String password = "xa4D1_iP8MX2ghy23gIrwGUWJo";
	String myDataField;
	
	String myQuery = "SELECT * FROM beta_list";
	
	String myInsert = "INSERT INTO beta_list (beta_email, location) VALUES('" + request.getParameter("email") + "', '" + request.getParameter("location") + "')";
	
	Connection myConnection;
	PreparedStatement myPreparedStatement;
	PreparedStatement myStatement;
	ResultSet myResultSet;
	
	
	Class.forName(driver).newInstance();
	myConnection = DriverManager.getConnection(url,username,password);
	
	myStatement = myConnection.prepareStatement(myInsert);
	myStatement.executeQuery();
	
	myPreparedStatement = myConnection.prepareStatement(myQuery);
	myResultSet = myPreparedStatement.executeQuery();
	while(myResultSet.next()) {
		myDataField = myResultSet.getString("beta_email");
		System.out.print(myDataField);
		myDataField = myResultSet.getString("location");
		System.out.print(myDataField);
	}
	
	myResultSet.close();
	myStatement.close();
	myPreparedStatement.close();
	myConnection.close();
	
} catch(ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException ex) {
	out.print("SQLException: "+ex.getMessage());
	out.print("SQLState: " + ex.getSQLState());
	out.print("VendorError: " + ex.getErrorCode());
}
%>