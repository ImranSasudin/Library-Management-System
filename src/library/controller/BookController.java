package library.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.dao.BookDAO;
import library.model.BookBean;


@WebServlet("/BookController")
public class BookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String LIST_BOOK = "/domains/book/listBook.jsp";
	private String UPDATE_BOOK = "/domains/book/updateBook.jsp";
	private String DELETE_BOOK = "/domains/book/deleteBook.jsp";
	private String VIEW_BOOK = "/domains/book/viewBook.jsp";

    private String forward;
	BookDAO bookDAO = new BookDAO();

    public BookController() {
        super();
        
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		//list all book for listBook.jsp
		if(action.equalsIgnoreCase("listBook")){
    		forward = LIST_BOOK;
    		List<BookBean> book = bookDAO.getAllBook();
            request.setAttribute("books", book); 
    	}
		//update book
		else if(action.equalsIgnoreCase("updateBook")){
			BookBean book = new BookBean();
    		forward = UPDATE_BOOK;
    		String bookISBN = request.getParameter("bookISBN");
			book.setBookISBN(bookISBN);
            book = bookDAO.getBookByID(bookISBN);
        	request.setAttribute("book", book);
    	}
		//delete book
		else if(action.equalsIgnoreCase("deleteBook")){
			BookBean book = new BookBean();
    		forward = DELETE_BOOK;
    		String bookISBN = request.getParameter("bookISBN");
			book.setBookISBN(bookISBN);
            book = bookDAO.getBookByID(bookISBN);
        	request.setAttribute("book", book);
    	}
		else if(action.equalsIgnoreCase("viewBook")){
			BookBean book = new BookBean();
    		forward = VIEW_BOOK;
    		String bookISBN = request.getParameter("bookISBN");
			book.setBookISBN(bookISBN);
            book = bookDAO.getBookByID(bookISBN);
        	request.setAttribute("book", book);
        	request.setAttribute("listBook", "true");
    	}
    	RequestDispatcher view = request.getRequestDispatcher(forward);
    	view.forward(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		BookBean book = new BookBean();
		
		//for add new book and update book
		if(action.equalsIgnoreCase("Add") || (action.equalsIgnoreCase("Update")))  {
			String bookISBN = request.getParameter("bookISBN");
			String bookName = request.getParameter("bookName");
			String bookPrice = request.getParameter("bookPrice");
			String bookPublisher = request.getParameter("bookPublisher");
			String bookLocation = request.getParameter("bookLocation");
			Integer bookQuantity = Integer.valueOf(request.getParameter("bookQuantity"));
			
			book.setBookISBN(bookISBN);
			book.setBookName(bookName);
			book.setBookPrice(bookPrice);
			book.setBookPublisher(bookPublisher);
			book.setBookLocation(bookLocation);
			book.setBookQuantity(bookQuantity);

			bookDAO =  new BookDAO();
			
			
			if(action.equalsIgnoreCase("Add")) {
				book = bookDAO.getBook(book);
				if(!book.isValid()) {
					book.setBookCurrentQuantity(book.getBookQuantity());
					bookDAO.add(book);
					request.setAttribute("successAdd", "true");
					RequestDispatcher view = request.getRequestDispatcher("/domains/book/addBook.jsp");
					view.forward(request, response);
				}
				else {
					request.setAttribute("successAdd", "false");
					RequestDispatcher view = request.getRequestDispatcher("/domains/book/addBook.jsp");
					view.forward(request, response);
				}
				
			}
			else if(action.equalsIgnoreCase("Update")){ 
				try {
					String reason = request.getParameter("reason");
					Integer bookCurrentQuantity = Integer.valueOf(request.getParameter("bookCurrentQuantity"));
					Integer currentQuantity = Integer.valueOf(request.getParameter("currentQuantity"));
					
					if(reason.equalsIgnoreCase("")){ //if librarian doesnt choose the reason
						book.setBookCurrentQuantity(bookCurrentQuantity);
					}
					else if(reason.equalsIgnoreCase("add")){ //for add new book
						book.setBookCurrentQuantity((bookQuantity - currentQuantity) + bookCurrentQuantity);
					}
					else if(reason.equalsIgnoreCase("lost")){ //for book lost
						book.setBookCurrentQuantity(bookCurrentQuantity);
					}
					else if(reason.equalsIgnoreCase("throw")){ //for throw away book
						book.setBookCurrentQuantity((bookQuantity - currentQuantity) + bookCurrentQuantity);
					}
					else if(reason.equalsIgnoreCase("audit")){ //for throw away book
						book.setBookQuantity(bookQuantity);
						book.setBookCurrentQuantity(bookCurrentQuantity);
					}

					bookDAO.updateBook(book);
				}catch (NoSuchAlgorithmException e) {
					e.printStackTrace();
				}
				request.setAttribute("book", book);
				request.setAttribute("successUpdate", "true"); //for success update popup
				RequestDispatcher view = request.getRequestDispatcher("/domains/book/viewBook.jsp"); //redirect
				view.forward(request, response);
			   }
			}
		else if(action.equalsIgnoreCase("Delete")) { //for delete book
			String bookISBN = request.getParameter("bookISBN");
			book.setBookISBN(bookISBN);
            bookDAO.deleteBook(bookISBN);
            request.setAttribute("successDelete", "true"); //for delete success popup
            List<BookBean> book1 = bookDAO.getAllBook();
            request.setAttribute("books", book1); 
            RequestDispatcher view = request.getRequestDispatcher("/domains/book/listBook.jsp"); //redirect
			view.forward(request, response);
			}
		}

	}

		


