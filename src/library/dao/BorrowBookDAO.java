package library.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import library.connection.ConnectionManager;
import library.model.BookBean;
import library.model.BorrowBean;
import library.model.BorrowBookBean;
import library.model.LibrarianBean;
import library.model.PatronBean;

public class BorrowBookDAO {
	static Connection currentCon = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement stat = null;
	static Integer borrowID;
	static String bookISBN;
	static String bookName;
	static String status;
	static String returnDate;
	static Double fine;
	
	
	public void addBook(BorrowBookBean bean) {
		borrowID = bean.getBorrowID();
		bookISBN = bean.getBookISBN();
		status = bean.getStatus();
		//borrowDate = bean.getBorrowDate();
		
	    String searchQuery = "UPDATE book SET book_currentquantity = book_currentquantity - 1 where book_isbn = '" + bookISBN + "'" ;

		
		try {
			currentCon = ConnectionManager.getConnection();
			ps=currentCon.prepareStatement("insert into borrow_book (borrow_id,book_isbn, status, expected_return_date) values(?,?,?,(select sysdate + 14 from dual))");
			ps.setInt(1,borrowID);
			ps.setString(2,bookISBN);
			ps.setString(3,status);
			ps.executeUpdate();
			
			System.out.println("Book Status is " + status);
			
			stat = currentCon.createStatement();
			stat.executeUpdate(searchQuery);
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
	
	public void returnBook(BorrowBookBean bean, BookBean book) {
		borrowID = bean.getBorrowID();
		bookISBN = bean.getBookISBN();
		status = bean.getStatus();
		fine = book.getFine();
		//borrowDate = bean.getBorrowDate();
		
	    String searchQuery = "UPDATE book SET book_currentquantity = book_currentquantity + 1 where book_isbn = '" + bookISBN + "'" ;

	    String searchQuery2 = "UPDATE borrow_book SET return_date = sysdate , status = '"+status +"' , paid_fine = '" + fine + "' where book_isbn = '" + bookISBN + "' and borrow_id = '"+ borrowID +"'" ;

		try {
			currentCon = ConnectionManager.getConnection();

			System.out.println("Book Status is " + status);
			
			stat = currentCon.createStatement();
			stat.executeUpdate(searchQuery);
			stat.executeUpdate(searchQuery2);

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
	public static BorrowBookBean getExpectedReturnDate() {
		BorrowBookBean BorrowBook = new BorrowBookBean();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select to_char(sysdate + 14,'dd-MON-yyyy') from dual");
	        
	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            BorrowBook.setExpectedReturnDate(rs.getString(1));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return BorrowBook;
	}
	
}
