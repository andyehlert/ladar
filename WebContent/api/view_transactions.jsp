<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%
try {
	
	String driver = "org.postgresql.Driver";
	String url = "jdbc:postgresql://ec2-54-204-42-135.compute-1.amazonaws.com:5432/dal7m7vq7mvnhm?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
	String username = "qrqtiswaifzehm";
	String password = "uS3cn1kfbC16j3VF2ZqHddvpfx";
	String user = request.getParameter("user-email");
	
	String myQuery = "SELECT * FROM trans_db WHERE owner LIKE '" + user + "%'";
		
	Connection myConnection;
	PreparedStatement myPreparedStatement;
	ResultSet myResultSet;
	PrintWriter result = response.getWriter();
	
	Class.forName(driver).newInstance();
	myConnection = DriverManager.getConnection(url,username,password);
	
	myPreparedStatement = myConnection.prepareStatement(myQuery);
	myResultSet = myPreparedStatement.executeQuery();
	while(myResultSet.next()) {
		result.write(myResultSet.getString("status") + ";");
		result.write(myResultSet.getString("to_currency") + ";");
		result.write(myResultSet.getString("from_currency") + ";");
		result.write(myResultSet.getString("location") + ";");
		result.write(myResultSet.getDouble("amount") + ";");
		result.write(myResultSet.getInt("reputation") + ";");
		result.write(myResultSet.getInt("num_of_trans") + ";");
		result.write(myResultSet.getInt("trans_time") + ";");
		result.write(myResultSet.getInt("trans_id") + ";");
		result.write(myResultSet.getInt("match_trans_id") + "/");
	}

	result.close();
	myResultSet.close();
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