package library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import library.connection.ConnectionManager;
import library.model.BorrowBean;
import library.model.LibrarianBean;

public class BorrowDAO {
	
	static Connection currentCon = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement stat = null;
	static Integer borrowID;
	static String patronID;
	static Integer libID;
	static String borrowDate;
	
	//add new borrow
	public void add(BorrowBean bean) {
		patronID = bean.getPatronID();
		libID = bean.getLibID();
		
       

		try {
			currentCon = ConnectionManager.getConnection();
			ps=currentCon.prepareStatement("insert into borrow (borrow_id,patron_id, librarian_id, borrow_date) values(BORROW_SEQ1.nextval,?,?,SYSDATE)");
			ps.setString(1,patronID);
			ps.setInt(2,libID);
			ps.executeUpdate();
			
			System.out.println("Patron ID is " + patronID);
			
			String searchQuery = "select  BORROW_SEQ1.currval from dual";
			stat = currentCon.createStatement();
	        rs = stat.executeQuery(searchQuery);
            boolean more = rs.next();
            
            if (more) {
            	Integer borrowID = rs.getInt(1);
           
                bean.setBorrowID(borrowID);
           	}
           
            else if (!more) {
            	System.out.println("Sorry");
            }
		}
		
		catch (Exception ex) {
			System.out.println("failed: An Exception has occured!" + ex);
		}
		
		finally {
			if (ps != null){
				try {
					ps.close();
				} catch (Exception e) {
					ps = null;
				}
			if (currentCon != null) {
				try {
					currentCon.close();
				} catch (Exception e_) {
					currentCon = null;
				}
			}
			}
		}
	}
	
	//to check whether patron didnt return yet the book that he/she wants to borrow
	public int check(String bookISBN, String patronID) {
		int count = 0;
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select count(b.borrow_id) from borrow b join borrow_book bb on( b.borrow_id = bb.borrow_id) where b.patron_id = ? and bb.book_isbn = ? and bb.status = 'Borrowed'");
	        
	        ps.setString(1, patronID);
	        ps.setString(2, bookISBN);


	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            count = (rs.getInt(1));
	          

	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return count;
	}
	//get borrow_id , use for update (returning book)
	public int getBorrowID(String patronID, String bookISBN) {
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select b.borrow_id from borrow b join borrow_book bb on( b.borrow_id = bb.borrow_id) where b.patron_id = ? and bb.book_isbn = ? and bb.status = 'Borrowed'");
	        
	        ps.setString(1, patronID);
	        ps.setString(2, bookISBN);


	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            borrowID = (rs.getInt(1));
	          
	            System.out.println("Borrow ID =" + borrowID);

	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return borrowID;
	}
}
