package library.dao;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import library.connection.ConnectionManager;
import library.model.LibrarianBean;
import library.model.ReportBean;

public class ReportDAO {
	static Connection currentCon = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement stat = null;
	static Integer borrowID;
	static String bookISBN;
	static String status;
	static String returnDate;
	
	public static List<ReportBean> topBorrowers() {
        List<ReportBean> reports = new ArrayList<ReportBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select p.patron_id, p.patron_name, s.form, count(b.book_isbn) , s.status from book b join borrow_book bb on (b.book_isbn = bb.book_isbn) join borrow bor on (bb.borrow_id = bor.borrow_id) join patron p on (p.patron_id = bor.patron_id) join student s on (s.patron_id = p.patron_id) group by p.patron_id, p.patron_name, s.form, s.status having s.status = 'Studying' order by 4 desc");

            
            while (rs.next()) {
                ReportBean report = new ReportBean();
                report.setPatronID(rs.getString(1));
                report.setForm(rs.getInt(3));
                report.setPatronName(rs.getString(2));
                report.setCount(rs.getInt(4));
                report.setStatus(rs.getString(5));

                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }
	
	public static List<ReportBean> borrowedBooks() {
        List<ReportBean> reports = new ArrayList<ReportBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select book.book_isbn, book.book_name, to_char(b.borrow_date,'dd-MON-yyyy'), p.patron_id, p.patron_name, to_char(bb.expected_return_date,'dd-MON-yyyy'), (case when  sysdate > bb.expected_return_date then 'Yes' else 'No' end) "
            		+ "from patron p join borrow b on (p.patron_id = b.patron_id) join borrow_book bb on (b.borrow_id = bb.borrow_id) join book on (bb.book_isbn = book.book_isbn) where bb.status = 'Borrowed'");

            
            while (rs.next()) {
                ReportBean report = new ReportBean();
                report.setPatronID(rs.getString(4));
                report.setBookISBN(rs.getString(1));
                report.setPatronName(rs.getString(5));
                report.setBookName(rs.getString(2));
                report.setBorrowDate(rs.getString(3));
                report.setExpectedReturnDate(rs.getString(6));
                report.setLate(rs.getString(7));

                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }
	public static List<ReportBean> returnedBooks() {
        List<ReportBean> reports = new ArrayList<ReportBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select b.book_isbn, b.book_name, to_char(bb.return_date,'dd-MON-yyyy'), p.patron_id, p.patron_name, bb.paid_fine from book b join borrow_book bb on(bb.book_isbn = b.book_isbn) join borrow bor on(bor.borrow_id = bb.borrow_id) join patron p on(p.patron_id = bor.patron_id) where bb.status='Returned'");
            
            
            while (rs.next()) {
                ReportBean report = new ReportBean();
                report.setPatronID(rs.getString(4));
                report.setBookISBN(rs.getString(1));
                report.setPatronName(rs.getString(5));
                report.setBookName(rs.getString(2));
                report.setReturnDate(rs.getString(3));
                report.setPaidFine(rs.getDouble(6));

                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }
	
	public static List<ReportBean> graduatedBorrowers() {
        List<ReportBean> reports = new ArrayList<ReportBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select p.patron_id, p.patron_name, s.status, bb.book_isbn, book.book_name, to_char(b.borrow_date,'dd-MON-yyyy') from student s join patron p on (s.patron_id = p.patron_id) join borrow b on (p.patron_id = b.patron_id) join borrow_book bb on (b.borrow_id = bb.borrow_id) join book on (bb.book_isbn = book.book_isbn) where s.status = 'Graduated' and bb.status = 'Borrowed'");

            
            while (rs.next()) {
                ReportBean report = new ReportBean();
                report.setPatronID(rs.getString(1));
                report.setBookISBN(rs.getString(4));
                report.setPatronName(rs.getString(2));
                report.setBookName(rs.getString(5));
                report.setBorrowDate(rs.getString(6));

                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }
	
	public static List<ReportBean> borrowByForm() {
        List<ReportBean> reports = new ArrayList<ReportBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select s.form, count(b.borrow_id) from student s join patron p on (s.patron_id = p.patron_id) left outer join borrow b on (p.patron_id = b.patron_id) where s.form is not null group by s.form order by 1");

            
            while (rs.next()) {
                ReportBean report = new ReportBean();
                report.setForm(rs.getInt(1));
                report.setCount(rs.getInt(2));
               
                reports.add(report);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reports;
    }
	
	public void updateForm() throws NoSuchAlgorithmException{
		
	    String searchQuery = "update student set form = form + (to_char(sysdate,'yyyy') - to_char(last_modified,'yyyy')), last_modified = sysdate where status = 'Studying' and form <= 5 and to_char(last_modified, 'yyyy') <= to_char(sysdate,'yyyy')";
	    String searchQuery2 = "update student set status = 'Graduated', form = null where form >= 6";  
	    		
		
		try {
			currentCon = ConnectionManager.getConnection();
			stat = currentCon.createStatement();
			stat.executeUpdate(searchQuery);
			stat.executeUpdate(searchQuery2);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
