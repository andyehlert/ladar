package ladar;

import java.sql.*;
import java.util.*;

public class Ladar {
	
	public static String findMatch(Connection conn, Map<String, String> params) throws SQLException {
		/* Initializes variables needed for matching process. */
		StringBuilder result = new StringBuilder();
		StringBuilder query = new StringBuilder();
		String role = "";
		double btcValue = 600; /* Change to price call later. */
		double convertedAmount = Double.parseDouble(params.get("amount"));
		
		/* Sets the required role and calculates converted amount to search for. */
		if(params.get("role").equals("buyer")) {
			role = "seller";
			convertedAmount = (convertedAmount / btcValue);
		} else if(params.get("role").equals("seller")) {
			role = "buyer";
			convertedAmount = (convertedAmount * btcValue);
		}
		
		/* Sets the query string to be used in a prepared statement. */
		query.append("SELECT * FROM trans_db WHERE status='submitted' OR status='matched' AND from_currency='" + params.get("to_currency") +"' AND to_currency='" + params.get("from_currency") + "' ");
		query.append("AND reputation>=" + params.get("reputation_pref") + " AND reputation_pref<=" + params.get("reputation") + " AND location='" + params.get("location") + "' ");
		query.append("AND trans_pref<=" + params.get("num_of_trans") + " AND num_of_trans>=" + params.get("trans_pref") + " AND trans_time=" + params.get("trans_time") + " ");
		query.append("AND ( (cash=" + params.get("cash") + " AND cash=true) OR (bank_wire=" + params.get("bank_wire") + " AND bank_wire=true) OR (paypal=" + params.get("paypal") + " ");
		query.append("AND paypal=true) OR (cash_deposit=" + params.get("cash_deposit") + " AND cash_deposit=true) OR (other=" + params.get("other") + " AND other=true) ) AND " + role + "!='' ");
		query.append("AND " + role + "!='" + params.get("email") + "' AND " + params.get("role") + "='' ORDER BY abs(amount - " + convertedAmount +") ASC");
		System.out.println(query); /* Print used for debugging purposes. */
		
		/* Creates a prepared statement and executes the query. */
		PreparedStatement pstmt = conn.prepareStatement(query.toString());
		ResultSet rs = pstmt.executeQuery();
		
		/* Appends the information from the best match to the result. */
		if(rs.next()) {
			result.append(rs.getString("to_currency") + ";");
			result.append(rs.getString("from_currency") + ";");
			result.append(rs.getString("location") + ";");
			result.append(rs.getDouble("amount") + ";");
			result.append(rs.getInt("reputation") + ";");
			result.append(rs.getInt("num_of_trans") + ";");
			result.append(rs.getInt("trans_time") + ";");
			result.append(rs.getInt("trans_id") + "/");
			String update = "UPDATE trans_db SET match_trans_id = " + rs.getInt("trans_id") + " WHERE owner='" + params.get("email") + "' AND trans_id=" + params.get("trans_id");
			PreparedStatement myUpdate = conn.prepareStatement(update);
			myUpdate.execute();
			myUpdate.close();
		} else {
			result.append("No match found;");
		}
		
		return result.toString();
	}
	
	
	public static String manageTransaction(Connection conn, Map<String, String> params) throws SQLException {
		StringBuilder result = new StringBuilder();
		if(params.get("link").equals("accept")) {
			result.append(acceptMatch(conn, params));
		} else if(params.get("link").equals("decline")) {
			result.append(declineMatch(conn, params));
		} else if(params.get("link").equals("cancel")) {
			result.append(cancelTransaction(conn, params));
		}
		return result.toString();
	}
	
	
	private static String acceptMatch(Connection conn, Map<String, String> params) throws SQLException {
		return "";
	}
	
	
	private static String declineMatch(Connection conn, Map<String, String> params) throws SQLException {
		return "";
	}
	
	
	private static String cancelTransaction(Connection conn, Map<String, String> params) throws SQLException {
		return "";
	}
}
