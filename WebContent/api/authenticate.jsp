<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.* " %>
<%@ page import="java.io.*" %>
<%
try {
	
	String driver = "org.postgresql.Driver";
	String url = "jdbc:postgresql://ec2-54-204-42-135.compute-1.amazonaws.com:5432/dal7m7vq7mvnhm?ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
	String username = "qrqtiswaifzehm";
	String password = "uS3cn1kfbC16j3VF2ZqHddvpfx";
	String myDataField = null;
	
	String myQuery = "SELECT * FROM user_db WHERE (email_address = ?) AND (password = ?)";
	
	Connection myConnection;
	PreparedStatement myPreparedStatement;
	ResultSet myResultSet;
	
	Class.forName(driver).newInstance();
	myConnection = DriverManager.getConnection(url,username,password);
	
	myPreparedStatement = myConnection.prepareStatement(myQuery);
	myPreparedStatement.setString(1, request.getParameter("user-email"));
	myPreparedStatement.setString(2, request.getParameter("user-password"));
	myResultSet = myPreparedStatement.executeQuery();
	
	if(myResultSet.next()) {
		System.out.println("Login success!");
		response.getWriter().write(request.getParameter("user-email") + ";");
	} else {
		System.out.println("Login failure.");
		response.getWriter().write("fail;");
	}

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