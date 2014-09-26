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
	
	Class.forName(driver).newInstance();
	Connection myConnection = DriverManager.getConnection(url,username,password);

	String user = "SELECT * FROM trans_db WHERE trans_id=" + request.getParameter("trans-id");
	PreparedStatement pstmt = myConnection.prepareStatement(user);
	ResultSet rs = pstmt.executeQuery();

	if(rs.next()) {
		Map<String, String> params = new HashMap<String, String>();
		params.put("link", request.getParameter("link"));
		params.put("trans_id", request.getParameter("trans-id"));
		params.put("match_trans_id", request.getParameter("match-id"));
		params.put("email", rs.getString("owner"));
	
		System.out.println("Manage Trans Params: " + params.toString());
	
		response.getWriter().write(Ladar.manageTransaction(myConnection, params));
	} else {
		response.getWriter().write("Transaction ID not found;");
	}
	
	rs.close();
	pstmt.close();
	myConnection.close();
	
} catch(ClassNotFoundException e) {
	e.printStackTrace();
} catch (SQLException ex) {
	out.print("SQLException: "+ex.getMessage());
	out.print("SQLState: " + ex.getSQLState());
	out.print("VendorError: " + ex.getErrorCode());
}
%>