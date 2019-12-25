package library.dao;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import library.connection.ConnectionManager;
import library.model.BookBean;


public class BookDAO {
	
	static Connection currentCon = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement stat = null;
	static String bookISBN;
	static String bookName;
	static String bookPublisher;
	static String bookLocation;
	static String bookPrice;
	Integer bookQuantity, bookCurrentQuantity;
	
	//add new book
	public void add(BookBean bean) {
		bookISBN = bean.getBookISBN();
		bookName = bean.getBookName();
		bookPrice = bean.getBookPrice();
		bookPublisher = bean.getBookPublisher();
		bookLocation = bean.getBookLocation();
		bookQuantity = bean.getBookQuantity();
		bookCurrentQuantity = bean.getBookCurrentQuantity();

		
		try {
			currentCon = ConnectionManager.getConnection();
			ps=currentCon.prepareStatement("insert into book (book_ISBN, book_price, book_name, book_publisher, book_location, book_quantity, book_currentquantity) values(?,?,?,?,?,?,?)");
			ps.setString(1,bookISBN);
			ps.setString(2,bookPrice);
			ps.setString(3,bookName);
			ps.setString(4,bookPublisher);
			ps.setString(5,bookLocation);
			ps.setInt(6,bookQuantity);
			ps.setInt(7,bookCurrentQuantity);
			ps.executeUpdate();
			
			System.out.println("Your book name is " + bookName);
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
	
	//get all book to display in listBook.jsp
	public  List<BookBean> getAllBook() {
        List<BookBean> books = new ArrayList<BookBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select * from book");
            
            while (rs.next()) {
                BookBean book = new BookBean();
                book.setBookISBN(rs.getString("book_ISBN"));
                book.setBookPrice(rs.getString("book_price"));
                book.setBookName(rs.getString("book_name"));
                book.setBookPublisher(rs.getString("book_publisher"));
                book.setBookLocation(rs.getString("book_location"));
                book.setBookQuantity(rs.getInt("book_quantity"));
                book.setBookCurrentQuantity(rs.getInt("book_currentquantity"));


                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }
	
	public  List<BookBean> getAllNonZeroBook() {
        List<BookBean> books = new ArrayList<BookBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select * from book");
            
            while (rs.next()) {
                BookBean book = new BookBean();
                book.setBookISBN(rs.getString("book_ISBN"));
                book.setBookPrice(rs.getString("book_price"));
                book.setBookName(rs.getString("book_name"));
                book.setBookPublisher(rs.getString("book_publisher"));
                book.setBookLocation(rs.getString("book_location"));
                book.setBookQuantity(rs.getInt("book_quantity"));
                book.setBookCurrentQuantity(rs.getInt("book_currentquantity"));


                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }
	
	//get all borrowedbook to display in returnForm.jsp
	public  List<BookBean> getBorrowedBook(String patronID) {
        List<BookBean> books = new ArrayList<BookBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select b.patron_id , bb.book_isbn , book.book_name , (case when  sysdate > bb.expected_return_date then 0.2 * (TO_DATE(sysdate,'dd-mm-yyyy') - to_date(bb.expected_return_date,'dd-mm-yyyy')) else 0 end) from borrow b "
            		+ "join borrow_book bb on(b.borrow_id = bb.borrow_id) join book on(bb.book_isbn = book.book_isbn) where bb.status = 'Borrowed' and b.patron_id = '"+ patronID + "'");
            
            while (rs.next()) {
            	BookBean book = new BookBean();
            	book.setBookISBN(rs.getString(2));
            	book.setBookName(rs.getString(3));
            	book.setFine(rs.getDouble(4));
            	Double test = book.getFine() / 0.2;
            	int value = (int)Math.round(test);
            	book.setCount(value);
            	books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }
	
	//for update book
	public void updateBook(BookBean bean) throws NoSuchAlgorithmException{
		bookISBN = bean.getBookISBN();
		bookName = bean.getBookName();
		bookPrice = bean.getBookPrice();
		bookPublisher = bean.getBookPublisher();
		bookLocation = bean.getBookLocation();
		bookQuantity = bean.getBookQuantity();
		bookCurrentQuantity = bean.getBookCurrentQuantity();
		
		String searchQuery = "UPDATE book SET book_ISBN ='" + bookISBN + "', book_name ='" + bookName + "', book_price ='"+ bookPrice +"', book_publisher= '" + bookPublisher + "', book_location= '"+ bookLocation +"', book_quantity='"+ bookQuantity +"', book_currentQuantity='"+ bookCurrentQuantity+"' WHERE book_isbn = '" + bookISBN + "'";
		
		try {
			currentCon = ConnectionManager.getConnection();
			stat = currentCon.createStatement();
			stat.executeUpdate(searchQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//for delete Book
	public  void deleteBook(String bookISBN) {
        try {
        	currentCon = ConnectionManager.getConnection();
        	ps=currentCon.prepareStatement("delete from book where book_isbn=?");
            ps.setString(1, bookISBN);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
		
    }
	//to identify the existence of the book
public BookBean getBook(BookBean bean)  {
    	
        bookISBN = bean.getBookISBN();

        String searchQuery = "select * from book where book_isbn='" + bookISBN + "'";

        try {
            currentCon = ConnectionManager.getConnection();
            stat = currentCon.createStatement();
            rs = stat.executeQuery(searchQuery);
            boolean more = rs.next();

            // if user exists set the isValid variable to true
            if (more) {
            	String bookISBN = rs.getString("book_isbn");
           
                bean.setBookISBN(bookISBN);
                bean.setValid(true);
           	}
           
            else if (!more) {
            	System.out.println("Sorry");
            	bean.setValid(false);
            }
           
        }

        catch (Exception ex) {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
        }

        finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
                rs = null;
            }

            if (stat != null) {
                try {
                    stat.close();
                } catch (Exception e) {
                }
                stat = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (Exception e) {
                }

                currentCon = null;
            }
        }

        return bean;
    }
	//get detail about a book from its isbn
	public BookBean getBookByID(String bookISBN) {
		BookBean book = new BookBean();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from book where book_isbn=?");
	        
	        ps.setString(1, bookISBN);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	        	 book.setBookISBN(rs.getString("book_ISBN"));
	             book.setBookPrice(rs.getString("book_price"));
	             book.setBookName(rs.getString("book_name"));
	             book.setBookPublisher(rs.getString("book_publisher"));
	             book.setBookLocation(rs.getString("book_location"));
	             book.setBookQuantity(rs.getInt("book_quantity"));
	             book.setBookCurrentQuantity(rs.getInt("book_currentquantity"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return book;
	}

	
}
