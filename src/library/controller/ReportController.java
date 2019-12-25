package library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.dao.BookDAO;
import library.dao.PatronDAO;
import library.dao.ReportDAO;
import library.dao.StudentDAO;
import library.dao.TeacherDAO;
import library.model.BookBean;
import library.model.PatronBean;
import library.model.ReportBean;
import library.model.StudentBean;
import library.model.TeacherBean;


@WebServlet("/ReportController")
public class ReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String TOP_BORROWERS = "/domains/report/topBorrowers.jsp";
	private String BORROWED_BOOKS = "/domains/report/borrowedBooks.jsp";
	private String RETURNED_BOOKS = "/domains/report/returnedBooks.jsp";
	private String GRADUATED_BORROWERS = "/domains/report/graduatedBorrowers.jsp";
	private String BORROW_FORM = "/domains/report/borrowByForm.jsp";

	private String VIEW_PATRON = "/domains/patron/viewPatron.jsp";
	private String VIEW_BOOK = "/domains/book/viewBook.jsp";

	private String forward;
       

    public ReportController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
    	PatronBean patron = new PatronBean();
    	
    	BookBean book = new BookBean();
    	
    	PatronDAO patronDAO = new PatronDAO();
    	StudentDAO studentDAO = new StudentDAO();
    	TeacherDAO teacherDAO = new TeacherDAO();
    	BookDAO bookDAO = new BookDAO();
    	
    	//for top borrower list
	    if(action.equalsIgnoreCase("topBorrowers")) {
	    	forward = TOP_BORROWERS;
	    
	    	List<ReportBean> report = ReportDAO.topBorrowers();
	        request.setAttribute("reports", report); 
	    }
	  //for borrowed books list
	    else if(action.equalsIgnoreCase("borrowedBooks")) {
	    	forward = BORROWED_BOOKS;
	    	
	    	List<ReportBean> report = ReportDAO.borrowedBooks();
	        request.setAttribute("reports", report); 
	        List<StudentBean> student = StudentDAO.getAllStudent();
	         request.setAttribute("students", student); 
	         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
	         request.setAttribute("teachers", teacher); 
	    }
	    else if(action.equalsIgnoreCase("returnedBooks")) {
	    	forward = RETURNED_BOOKS;
	    	
	    	List<ReportBean> report = ReportDAO.returnedBooks();
	        request.setAttribute("reports", report); 
	        List<StudentBean> student = StudentDAO.getAllStudent();
	         request.setAttribute("students", student); 
	         List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
	         request.setAttribute("teachers", teacher); 
	    }
	  //for graduated student list
	    else if(action.equalsIgnoreCase("graduatedBorrowers")) {
	    	forward = GRADUATED_BORROWERS;
	    	
	    	List<ReportBean> report = ReportDAO.graduatedBorrowers();
	        request.setAttribute("reports", report); 
	    }
	    //for borrow frequency by form
	    else if(action.equalsIgnoreCase("borrowByForm")) {
	    	forward = BORROW_FORM;
	    	
	    	List<ReportBean> report = ReportDAO.borrowByForm();
	        request.setAttribute("reports", report); 
	    }
	    //to filter button in viewBook.jsp (for back navigation)
	    else if(action.equalsIgnoreCase("viewBook")) {
	    	forward = VIEW_BOOK;
	    	String report = request.getParameter("report");
	    	String bookISBN = request.getParameter("bookISBN");
	    	book.setBookISBN(bookISBN);
	    	book = bookDAO.getBookByID(bookISBN);
	    	request.setAttribute("book", book);
	    	if(report.equalsIgnoreCase("borrowedBooks"))
	    	request.setAttribute("borrowedBooks", "true");
	    	else if(report.equalsIgnoreCase("graduatedBorrowers"))
        		request.setAttribute("graduatedBorrowers", "true");
	    	else if(report.equalsIgnoreCase("returnedBooks"))
        		request.setAttribute("returnedBooks", "true");
	    }
	  //to filter button in viewPatron.jsp (for back navigation)
	    else if(action.equalsIgnoreCase("viewPatron")) {
	    	StudentBean student = new StudentBean();
	    	TeacherBean teacher = new TeacherBean();
	    	forward = VIEW_PATRON;	    	
	    	String report = request.getParameter("report");
        	String patronID = request.getParameter("patronID");
        	String type = request.getParameter("type");
        	patron.setPatronID(patronID);
        	patron = patronDAO.getUserByID(patronID);
        	request.setAttribute("patron", patron);
        	if(type.equalsIgnoreCase("Student")) {
	        	request.setAttribute("patronType", "Student");
	        	student.setPatronID(patronID);
	        	student = studentDAO.getUserByID(patronID);
	        	request.setAttribute("student", student);
			}
        	else {
        		request.setAttribute("patronType", "Teacher");
	        	teacher.setPatronID(patronID);
	        	teacher = teacherDAO.getUserByID(patronID);
	        	request.setAttribute("teacher", teacher);
        	}
        	
        	if(report.equalsIgnoreCase("topBorrowers"))
        		request.setAttribute("topBorrowers", "true");
        	else if(report.equalsIgnoreCase("borrowedBooks"))
        		request.setAttribute("borrowedBooks", "true");
        	else if(report.equalsIgnoreCase("returnedBooks"))
        		request.setAttribute("returnedBooks", "true");
        	else if(report.equalsIgnoreCase("graduatedBorrowers"))
        		request.setAttribute("graduatedBorrowers", "true");
	    }
	    RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
	    
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
