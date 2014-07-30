package ladar;
import java.sql.*;
import java.io.*;
import java.util.*;

public class Ladar {
	
	public static String findMatch(Connection conn, Map<String, String> params) throws SQLException {
		StringBuilder result = new StringBuilder();
		String role = "";
		String otherRole = "";
		
		if(params.get("role").equals("buyer")) {
			role = "seller";
			// Calculate amount
		} else if(params.get("role").equals("seller")) {
			role = "buyer";
			// Calculate amount
		}
		
		String query = "SELECT * FROM trans_db WHERE status='submitted' AND (from_currency='" + params.get("to_currency") +"' AND to_currency='" + params.get("from_currency") + "' "
				+ "AND reputaion>=" + params.get("reputation_pref") + " AND reputation_pref<=" + params.get("reputation") + " AND location='" + params.get("location") + "' "
				+ "AND trans_pref<=" + params.get("num_of_trans") + " AND num_of_trans>=" + params.get("trans_pref") + " AND trans_time=" + params.get("trans_time") + " "
				+ "AND cash=" + params.get("cash") + " AND bank_wire=" + params.get("bank_wire") + " AND paypal=" + params.get("paypal") + " AND cash_deposit=" + params.get("cash_deposit") + " "
				+ "AND other=" + params.get("other") + " AND " + role + "='' AND " + params.get("role") + "!='" + params.get("email") + "'";
		System.out.println(query);
		
		PreparedStatement pstmt = conn.prepareStatement(query);
		ResultSet rs = pstmt.executeQuery();
		
		return result.toString();
	}
}
