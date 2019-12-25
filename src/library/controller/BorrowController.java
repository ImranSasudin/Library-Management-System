package library.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.dao.BookDAO;
import library.dao.BorrowBookDAO;
import library.dao.BorrowDAO;
import library.dao.LibrarianDAO;
import library.dao.PatronDAO;
import library.dao.StudentDAO;
import library.dao.TeacherDAO;
import library.model.BookBean;
import library.model.BorrowBean;
import library.model.BorrowBookBean;
import library.model.LibrarianBean;
import library.model.PatronBean;
import library.model.StudentBean;
import library.model.TeacherBean;


@WebServlet("/BorrowController")
public class BorrowController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String BORROW = "/domains/borrow/borrowForm.jsp";
	private String SEARCH = "/domains/borrow/searchBorrower.jsp";
	private String MAX = "/domains/borrow/maxBorrow.jsp";
	private String forward;

    public BorrowController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		BookDAO bookDAO = new BookDAO();
		PatronDAO patronDAO = new PatronDAO();
		LibrarianBean librarian = new LibrarianBean();
		BorrowBookBean borrowBook = new BorrowBookBean();

		//for borrowForm.jsp (to get all the patron id and book title + book isbn
		if (action.equalsIgnoreCase("borrowBook")) { 
    		forward = BORROW;
    		 List<BookBean> book = bookDAO.getAllNonZeroBook();
	         request.setAttribute("books", book); 
	         List<PatronBean> patron = patronDAO.getAllPatron();
	         request.setAttribute("patrons", patron); 
	         List<StudentBean> student = StudentDAO.getAllStudent();
	         request.setAttribute("students", student); 
	         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
	         request.setAttribute("teachers", teacher); 
	         Integer libID = Integer.parseInt(request.getParameter("libID"));
	         librarian = LibrarianDAO.getUserByID(libID);
	         request.setAttribute("librarian", librarian); 
	         borrowBook = BorrowBookDAO.getExpectedReturnDate();
	         request.setAttribute("borrowBook", borrowBook); 

       	}	
		//for searchBorrower before returnForm.jsp
		else if (action.equalsIgnoreCase("searchBorrower")) {
    		forward = SEARCH;
	         List<PatronBean> patron = patronDAO.getAllBorrowers();
	         List<StudentBean> student = StudentDAO.getAllStudent();
	         request.setAttribute("students", student); 
	         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
	         request.setAttribute("teachers", teacher); 
	         request.setAttribute("patrons", patron); 
	         

       	}	
		else if (action.equalsIgnoreCase("maxBorrow")) {
			forward = MAX;
			Integer libID = Integer.parseInt(request.getParameter("libID"));
			librarian = LibrarianDAO.getUserByID(libID);
			request.setAttribute("librarian", librarian); 
			

       	}	
		RequestDispatcher view = request.getRequestDispatcher(forward);
    	view.forward(request,response);	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		BorrowBean borrow = new BorrowBean();
		BorrowBookBean borrowBook = new BorrowBookBean();
		BorrowDAO borrowDAO = new BorrowDAO();
		BorrowBookDAO borrowBookDAO = new BorrowBookDAO();
		BookDAO bookDAO = new BookDAO();
		PatronDAO patronDAO = new PatronDAO();
		LibrarianBean librarian = new LibrarianBean();
		int count = 0; //to initialize
		int count1 = 0; //to initialize
		String duplicate = "false"; //to initialize

		if(action.equalsIgnoreCase("Borrow")) {
			Integer libID = Integer.valueOf(request.getParameter("libID"));
			String patronID = request.getParameter("patronID");
			String bookISBN[] = request.getParameterValues("bookISBN");
			String bookNotReturn = "null"; //initialization

			//this is to check if librarian enter same book in the borrowForm.jsp
			Map<String, Integer> duplicates = new HashMap<String, Integer>();
			 
		    for (String str : bookISBN) {
		        if (duplicates.containsKey(str)) {
		           duplicates.put(str, duplicates.get(str) + 1);
		        } else {
		           duplicates.put(str, 1);
		        }
		    }
		 
		    for (Map.Entry<String, Integer> entry : duplicates.entrySet()) {
		        if(entry.getValue() > 1)
		        	duplicate = "true"; //if librarian enter same book in borrowForm, duplicate="true"
		    }
		    
		    //if duplicate equal to true, popup error 
		    if(duplicate.equalsIgnoreCase("true")) {
		    	request.setAttribute("duplicateBook", "true");
		    	List<BookBean> book = bookDAO.getAllBook();
		        request.setAttribute("books", book); 
		        List<PatronBean> patron = patronDAO.getAllPatron();
		        request.setAttribute("patrons", patron); 
		        List<StudentBean> student = StudentDAO.getAllStudent();
		         request.setAttribute("students", student); 
		         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
		         request.setAttribute("teachers", teacher); 
		         borrowBook = BorrowBookDAO.getExpectedReturnDate();
		         request.setAttribute("borrowBook", borrowBook); 
		         libID = Integer.parseInt(request.getParameter("libID"));
		         librarian = LibrarianDAO.getUserByID(libID);
		         request.setAttribute("librarian", librarian); 
		    	RequestDispatcher view = request.getRequestDispatcher("/domains/borrow/borrowForm.jsp");
				view.forward(request, response);
		    }
		    //if there are no duplication
		    else {
		    	
				borrow.setLibID(libID);
				borrow.setPatronID(patronID);
				//to check whether patron has not return yet the book that he/she wants to borrow (means, he/she has already borrow that book and not return it yet)
				for(int i = 0; i < bookISBN.length; i++) {
					borrowBook.setBookISBN(bookISBN[i]);
					count1 = borrowDAO.check(bookISBN[i], patronID);
					if (count1 > count) {
						count = count1;
						bookNotReturn = bookISBN[i];
					}
				}
				//if patron didnt return yet the book that he/she borrowed before
				if(count >= 1) {
					request.setAttribute("notReturnYet", "true");
					request.setAttribute("Book", bookNotReturn);
					List<BookBean> book = bookDAO.getAllBook();
			        request.setAttribute("books", book); 
			        List<PatronBean> patron = patronDAO.getAllPatron();
			        request.setAttribute("patrons", patron); 
			        List<StudentBean> student = StudentDAO.getAllStudent();
			         request.setAttribute("students", student); 
			         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
			         request.setAttribute("teachers", teacher); 
			         borrowBook = BorrowBookDAO.getExpectedReturnDate();
			         request.setAttribute("borrowBook", borrowBook); 
			         libID = Integer.parseInt(request.getParameter("libID"));
			         librarian = LibrarianDAO.getUserByID(libID);
			         request.setAttribute("librarian", librarian); 
					RequestDispatcher view = request.getRequestDispatcher("/domains/borrow/borrowForm.jsp");
					view.forward(request, response);
				}
				//else 
				else {	
					borrowDAO.add(borrow);	
					borrowBook.setBorrowID(borrow.getBorrowID());
					borrowBook.setStatus("Borrowed");
						for(int i = 0; i < bookISBN.length; i++) {
							borrowBook.setBookISBN(bookISBN[i]);
							borrowBookDAO.addBook(borrowBook);
					 	}
					List<BookBean> book = bookDAO.getAllBook();
			        request.setAttribute("books", book); 
			        List<PatronBean> patron = patronDAO.getAllPatron();
			        request.setAttribute("patrons", patron); 
			        List<StudentBean> student = StudentDAO.getAllStudent();
			         request.setAttribute("students", student); 
			         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
			         request.setAttribute("teachers", teacher); 
			        request.setAttribute("successBorrow", "true");
			        borrowBook = BorrowBookDAO.getExpectedReturnDate();
			         request.setAttribute("borrowBook", borrowBook); 
			         libID = Integer.parseInt(request.getParameter("libID"));
			         librarian = LibrarianDAO.getUserByID(libID);
			         request.setAttribute("librarian", librarian); 
					RequestDispatcher view = request.getRequestDispatcher("/domains/borrow/borrowForm.jsp");
					view.forward(request, response);
					}
		    	}	
			}
		
		//for return book
		else if(action.equalsIgnoreCase("Return")) {
			BookBean book = new BookBean();
			String patronID = request.getParameter("patronID");
			String bookISBN[]= request.getParameterValues("bookISBN");
		
			borrowBook.setStatus("Returned");
			//get all book that patron wants to return
			for(int i = 0; i < bookISBN.length; i++) {
				for(int j = 0; j < 2; j++) {
					String[] str = bookISBN[i].split(" ");
					borrowBook.setBookISBN(str[0]);
					book.setFine(Double.parseDouble(str[1]));
					int borrowID = borrowDAO.getBorrowID(patronID, borrowBook.getBookISBN()); //get borrow_id from table borrow
					borrowBook.setBorrowID(borrowID); //set that borrow_id for BorrowBookBean
					borrowBookDAO.returnBook(borrowBook, book);
				}
				}
			request.setAttribute("successReturn", "true"); //for success return popup
			List<PatronBean> patron = patronDAO.getAllBorrowers();
	        request.setAttribute("patrons", patron); 
	        List<StudentBean> student = StudentDAO.getAllStudent();
	         request.setAttribute("students", student); 
	         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
	         request.setAttribute("teachers", teacher); 
			RequestDispatcher view = request.getRequestDispatcher("/domains/borrow/searchBorrower.jsp");
		    view.forward(request, response);
		}
		//for searchBorrower.jsp
		else if(action.equalsIgnoreCase("Search")) {
    		String patronID = request.getParameter("patronID");
    		borrow.setPatronID(patronID);
    		List<BookBean> borrowedBook = bookDAO.getBorrowedBook(patronID);
    		request.setAttribute("borrow", borrow);
    		request.setAttribute("books", borrowedBook);
    		RequestDispatcher view = request.getRequestDispatcher("/domains/borrow/returnForm.jsp");
		    view.forward(request, response);

		}
		else if(action.equalsIgnoreCase("UpdateMaxBorrow")) {
    		Integer maxBorrow = Integer.parseInt(request.getParameter("maxBorrow"));
    		try {
				LibrarianDAO.updateMaxBorrow(maxBorrow);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    		 List<BookBean> book = bookDAO.getAllNonZeroBook();
	         request.setAttribute("books", book); 
	         List<PatronBean> patron = patronDAO.getAllPatron();
	         request.setAttribute("patrons", patron); 
	         List<StudentBean> student = StudentDAO.getAllStudent();
	         request.setAttribute("students", student); 
	         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
	         request.setAttribute("teachers", teacher); 
	         Integer libID = Integer.parseInt(request.getParameter("libID"));
	         librarian = LibrarianDAO.getUserByID(libID);
	         request.setAttribute("librarian", librarian); 
	         borrowBook = BorrowBookDAO.getExpectedReturnDate();
		        request.setAttribute("borrowBook", borrowBook); 
    		request.setAttribute("successUpdate", "true");
    		RequestDispatcher view = request.getRequestDispatcher("/domains/borrow/borrowForm.jsp");
		    view.forward(request, response);

		}
			
	}	
}


