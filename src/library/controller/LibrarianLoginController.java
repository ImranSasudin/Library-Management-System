package library.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import library.dao.LibrarianDAO;
import library.dao.ReportDAO;
import library.model.LibrarianBean;

@WebServlet("/LibrarianLoginController")
public class LibrarianLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       String forward ="";
       String action ="";

    public LibrarianLoginController() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			action = request.getParameter("action");
			HttpSession session = request.getSession(true);
			if (action.equalsIgnoreCase("Logout")){ //logout
			request.setAttribute("libNameLogout", session.getAttribute("libNameSession"));
			session.setAttribute("currentSessionUser", null);
			session.setAttribute("libRoleSession", null);
			session.setAttribute("libNameSession", null);
			session.invalidate();
			
			request.setAttribute("logoutSuccess", "true");
			RequestDispatcher view = request.getRequestDispatcher("/librarianLogin.jsp");
		    view.forward(request, response);		
		    }

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		action = request.getParameter("action");
		HttpSession session = request.getSession(true);
		
    	try {
			
			LibrarianBean librarian = new LibrarianBean();
			ReportDAO reportDAO = new ReportDAO();
			librarian.setLibID(Integer.parseInt(request.getParameter("libID")));
			librarian.setPassword(request.getParameter("password"));

			librarian = LibrarianDAO.login(librarian);
			reportDAO.updateForm(); //automatic update form
			//if is it head librarian, set the role session to head librarian
			if(librarian.isValid() && librarian.getLibRole().equalsIgnoreCase("Head Librarian")) {
				
				session.setAttribute("currentSessionUser", librarian.getLibID());
				session.setAttribute("libRoleSession", librarian.getLibRole());
				session.setAttribute("libNameSession", librarian.getLibName());
				request.setAttribute("successLogin", "true"); //use for success login popup
				RequestDispatcher view = request.getRequestDispatcher("/index.jsp");
			    view.forward(request, response);

			}
			
			//if it is librarian, set the role session to librarian
			else if(librarian.isValid() && librarian.getLibRole().equalsIgnoreCase("Librarian"))
			{
				session.setAttribute("currentSessionUser", librarian.getLibID());
				session.setAttribute("libRoleSession", librarian.getLibRole());
				session.setAttribute("libNameSession", librarian.getLibName());
				request.setAttribute("successLogin", "true"); //use for success login popup
		        RequestDispatcher view = request.getRequestDispatcher("/index.jsp");
		        view.forward(request, response);
			}
			
			else
			{
				request.setAttribute("invalidLogin", "true"); //use for invalid login popup
		        RequestDispatcher view = request.getRequestDispatcher("/librarianLogin.jsp");
		        view.forward(request, response);
			}

			
		}
	

		catch (Throwable ex) {
			System.out.println(ex);
		}
	}
		
}


