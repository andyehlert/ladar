package ladar;

import java.sql.*;
import java.util.*;

public class Ladar {
	
	/**
	 * Performs a query into the transaction database to find the optimal matching 
	 * transaction and returns the vital information in a string.
	 * @param conn Instance of a transaction database connection.
	 * @param params Map of parameters needed to find a suitable matching transaction.
	 * @return String containing information about the match that is found.
	 * @throws SQLException
	 */
	public static String findMatch(Connection conn, Map<String, String> params) throws SQLException {
		/* Initializes variables needed for matching process. */
		StringBuilder result = new StringBuilder();
		StringBuilder query = new StringBuilder();
		String role = "";
		double btcValue = 600; /* Change to price call later. */
		double convertedAmount = Double.parseDouble(params.get("amount"));
		
		/* Sets the required role and calculates converted amount to search for. */
		System.out.println(params.get("role"));
		if(params.get("role").equals("buyer")) {
			role = "seller";
			convertedAmount = (convertedAmount / btcValue);
		} else if(params.get("role").equals("seller")) {
			role = "buyer";
			convertedAmount = (convertedAmount * btcValue);
		}
		
		/* Sets the query string to be used in a prepared statement. */
		query.append("SELECT * FROM trans_db WHERE ( status='submitted' OR status='matched' ) AND ( from_currency='" + params.get("to_currency") +"' AND to_currency='" + params.get("from_currency") + "' ) ");
		query.append("AND ( reputation>=" + params.get("reputation_pref") + " AND reputation_pref<=" + params.get("reputation") + " AND location='" + params.get("location") + "' ");
		query.append("AND trans_pref<=" + params.get("num_of_trans") + " AND num_of_trans>=" + params.get("trans_pref") + " AND trans_time=" + params.get("trans_time") + " ) ");
		query.append("AND ( (cash=" + params.get("cash") + " AND cash=true) OR (bank_wire=" + params.get("bank_wire") + " AND bank_wire=true) OR (paypal=" + params.get("paypal") + " ");
		query.append("AND paypal=true) OR (cash_deposit=" + params.get("cash_deposit") + " AND cash_deposit=true) OR (other=" + params.get("other") + " AND other=true) ) AND " + role + "!='' ");
		query.append("AND " + role + "!='" + params.get("email") + "' AND " + params.get("role") + "='' AND owner!='" + params.get("email") + "' ORDER BY abs(amount - " + convertedAmount +") ASC");
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
			String update = "UPDATE trans_db SET match_trans_id=" + rs.getInt("trans_id") + " WHERE owner='" + params.get("email") + "' AND trans_id=" + params.get("trans_id");
			System.out.println("update statement: " + update);
			PreparedStatement myUpdate = conn.prepareStatement(update);
			myUpdate.execute();
			myUpdate.close();
		} else {
			result.append("No match found;");
		}
		
		return result.toString();
	}
	
	
	/**
	 * Identifies and performs one of multiple transaction management actions requested 
	 * by the user and returns the appropriate information in a string.
	 * @param conn Instance of a transaction database connection.
	 * @param params Map of parameters used to identify and perform the requested action.
	 * @return String containing the appropriate information for the requested action.
	 * @throws SQLException
	 */
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
	
	
	/**
	 * Helper method that identifies the transaction that was accepted and notifies the owner
	 * and alters the state of the transaction owned by the accepting user.
	 * @param conn Instance of a transaction database connection.
	 * @param params Map of parameters used to identify the transaction requests to be altered.
	 * @return String containing information about the transaction the was accepted.
	 * @throws SQLException
	 */
	private static String acceptMatch(Connection conn, Map<String, String> params) throws SQLException {
		/* Finds the transaction owned by the accepting user. */
		String body = "";
		StringBuilder result = new StringBuilder();
		String query = "SELECT * from trans_db WHERE trans_id=" + params.get("trans_id") + " AND owner='" + params.get("email") + "'";
		PreparedStatement pstmt = conn.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		
		/* Checks to make sure the transaction was found. */
		if(rs.next()) {
			/* Updates the transactions status to matched. */
			String update = "UPDATE trans_db SET status='matched' WHERE trans_id=" + rs.getInt("trans_id");
			PreparedStatement updateStatement = conn.prepareStatement(update);
			updateStatement.execute();
			
			/* Finds the matching transaction that was accepted. */
			String matchQuery = "SELECT * FROM trans_db WHERE trans_id=" + rs.getInt("match_trans_id");
			PreparedStatement matchStatement = conn.prepareStatement(matchQuery);
			ResultSet rs2 = matchStatement.executeQuery();
			
			/* Checks to make sure the transaction was found. */
			if(rs2.next()) {
				if(rs2.getString("status").trim().equals("submitted")) {
					result.append("submitted");
					// PreparedStatement matchUpdate = conn.prepareStatement("UPDATE trans_db SET match_trans_id")
					/* Send email notification to owner of accepted transaction. */
					// body = "Another user has accepted your transaction offer. Please logon to your"
					// + "ladar.co account to view the details and take further action.";
					// GmailSender.send(rs2.getString("owner").trim(), "Transaction Accepted", body);
				} else if(rs2.getString("status").trim().equals("matched")) {
					result.append("matched");
					/* Sets the status of both transactions to pending. */
					String updateStatus = "UPDATE trans_db SET status='pending' WHERE trans_id=" + rs.getInt("trans_id") + " OR trans_id=" + rs2.getInt("trans_id");
					conn.prepareStatement(updateStatus).execute();
					
					/* Notify both users of the completed match and prompt the seller to bitpay. */
					// if(rs2.getString("seller").trim().equals(rs2.getString("owner").trim())) {
					// 	body = "Both users have accepted the transaction, the match is a success! "
					// 	+ "Please log on to ladar.co and submit the transaction fee to recieve the "
					// 	+ " other user's contact information. ";
					// 	GmailSender.send(rs2.getString("owner").trim(), "Match Successful!", body);
					// 	body = "Both users have accepted the transaction, the match is a success! "
					// 	+ "The contact information for the other user will be released when they have "
					// 	+ "submitted the transaction fee.";
					// 	GmailSender.send(params.getParameter("email").trim(), "Match Successful!", body);
					// } else if(rs2.getString("buyer").trim().equals(rs2.getString("owner").trim())) {
					// 	body = "Both users have accepted the transaction, the match is a success! "
					// 	+ "Please log on to ladar.co and submit the transaction fee to recieve the "
					// 	+ " other user's contact information. ";
					// 	GmailSender.send(params.getParameter("email").trim(), "Match Successful!", body);
					// 	body = "Both users have accepted the transaction, the match is a success! "
					// 	+ "The contact information for the other user will be released when they have "
					// 	+ "submitted the transaction fee.";
					// 	GmailSender.send(rs2.getString("owner").trim(), "Match Successful!", body);
					// }
					
					
					/* Change status of both transactions to complete. */
					String updateStatus2 = "UPDATE trans_db SET status='complete' WHERE trans_id=" + rs.getInt("trans_id") + " OR trans_id=" + rs2.getInt("trans_id");
					conn.prepareStatement(updateStatus2).execute();
					
					/* Move the transactions to the completed transactions database. IMPLEMENT LATER. */
				}
			}

			rs2.close();
			updateStatement.close();
			matchStatement.close();

		}

		rs.close();
		pstmt.close();
		
		return result.toString();
	}
	
	
	/**
	 * Helper method that finds a new match for the user when a match is rejected and returns the 
	 * vital transaction information for the new match in a string.
	 * @param conn Instance of a transaction database connection.
	 * @param params Map of parameters needed to find and change the appropriate transaction.
	 * @return String containing information about the new matching transaction.
	 * @throws SQLException
	 */
	private static String declineMatch(Connection conn, Map<String, String> params) throws SQLException {
		StringBuilder result = new StringBuilder();
		String query = "SELECT * FROM trans_db WHERE owner='" + params.get("email") + "' AND trans_id=" + params.get("trans_id");
		System.out.println(query);
		PreparedStatement pstmt = conn.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		
		/* If the transaction is found, searches for a new match. */
		if(rs.next()) {
			/* Assigns the appropriate role search parameter. */
			String role = "";
			System.out.println(rs.getString("buyer"));
			System.out.println(rs.getString("seller"));
			if(rs.getString("buyer").trim().equals(params.get("email").trim())) {
				role = "buyer";
			} else if(rs.getString("seller").trim().equals(params.get("email").trim())) {
				role = "seller";
			}
			
			/* Adds necessary search parameters to map to be sent to findMatch(). */
			Map<String, String> searchParams = new HashMap<String, String>();
			searchParams.put("from_currency", rs.getString("from_currency"));
			searchParams.put("to_currency", rs.getString("to_currency"));
			searchParams.put("role", role);
			searchParams.put("email", rs.getString("owner"));
			searchParams.put("amount", rs.getDouble("amount") + "");
			searchParams.put("location", rs.getString("location"));
			searchParams.put("trans_pref", rs.getInt("trans_pref") + "");
			searchParams.put("trans_time", rs.getInt("trans_time") + "");
			searchParams.put("reputation_pref", rs.getInt("reputation_pref") + "");
			searchParams.put("cash", rs.getBoolean("cash") + "");
			searchParams.put("bank_wire", rs.getBoolean("bank_wire") + "");
			searchParams.put("paypal", rs.getBoolean("paypal") + "");
			searchParams.put("cash_deposit", rs.getBoolean("cash_deposit") + "");
			searchParams.put("other", rs.getBoolean("other") + "");
			searchParams.put("reputation", rs.getInt("reputation") + "");
			searchParams.put("num_of_trans", rs.getInt("num_of_trans") + "");
			searchParams.put("trans_id", rs.getInt("trans_id") + "");
			
			/* Finds a new matching transaction for the user. */
			result.append(findMatch(conn, searchParams));
		} else {
			result.append("Transaction to be changed could not be found./");
		}
		
		/* Close prepared statement and result set. */
		pstmt.close();
		rs.close();
		
		return result.toString();
	}
	
	
	/**
	 * Helper method that identifies the appropriate transaction request and removes it 
	 * from the transaction database.
	 * @param conn Instance of a transaction database connection.
	 * @param params Map of parameters used to identify the transaction to be removed.
	 * @return True if removal of transaction was successful, false otherwise.
	 * @throws SQLException
	 */
	private static boolean cancelTransaction(Connection conn, Map<String, String> params) throws SQLException {
		/* Executes a delete statement to remove the appropriate transaction from the transaction database. */
		return conn.prepareStatement("DELETE FROM trans_db WHERE trans_id=" + params.get("trans_id") + " AND owner='" + params.get("email") + "'").execute();
	}
}
