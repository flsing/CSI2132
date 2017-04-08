package postgresql;
import java.sql.*;
public class demo {

	public static void main(String[] args) {
		try
		{
			Connection db = DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/**********", "**********", "**********"); 
			Statement st = db.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM lab.artist");
			while (rs.next()) {
			System.out.print("Column 1 returned: ");
			System.out.println(rs.getString(1)); } 
			rs.close(); 
			st.close(); 
			
		}
		catch (Exception exc)
		{
			exc.printStackTrace();
		}

	}

}






PRINTING NAME AND BIRTHDAY:

package postgresql;
import java.sql.*; 
public class Example {

	public static void main(String[] args) {
		
		try
		{
			Connection db = DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/**********", "**********", "**********"); 
			Statement st = db.createStatement();
			ResultSet rs = st.executeQuery("SELECT aname, dateofbirth FROM lab.artist");
			System.out.println("Name\t Birthday");
			while (rs.next()) {
			
			System.out.print(rs.getString(1)+"\t");
			System.out.println(rs.getString(2));} 
			rs.close(); 
			st.close();
			
		}
		catch (Exception exc)
		{
			exc.printStackTrace();
		}
		}

	}


DYNAMIC QUERIES:

package postgresql;
import java.sql.*;
public class dynamic {

	public static void main(String[] args) {
		try
		{
			Connection db = DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/**********", "**********", "**********"); 
			
			String field = "aname, style";
			String cond = "aname";
			String table = "lab.artist";
			String value = "'Picasso'";
			Statement st = db.createStatement();
			ResultSet rs = st.executeQuery("SELECT " +field+ " FROM " +table+ " where " +cond+ " = " +value+" ;");
			while(rs.next()){
				System.out.print(rs.getString(1)+"\t");
				System.out.println(rs.getString(2));
			}
			rs.close(); 
			st.close(); 
			
		}
		catch (Exception exc)
		{
			exc.printStackTrace();
		}

	}

}


COUNT COLUMNS:

package postgresql;
import java.sql.*; 
public class count {

	public static void main(String[] args) {
		try
		{
			Connection db = DriverManager.getConnection("jdbc:postgresql://web0.site.uottawa.ca:15432/**********", "**********", "**********"); 
			Statement st = db.createStatement();
			
			ResultSet rs = st.executeQuery("SELECT aname, dateofbirth FROM lab.artist");
			ResultSetMetaData rsMetaData = rs.getMetaData();
			int numberOfColumns = rsMetaData.getColumnCount();
			System.out.println("Number of Columns: "+numberOfColumns);
			while (rs.next()) {
			
			System.out.print(rs.getString(1)+"\t");
			System.out.println(rs.getString(2));} 
			rs.close(); 
			st.close();
			
		}
		catch (Exception exc)
		{
			exc.printStackTrace();
		}
		


	}

}