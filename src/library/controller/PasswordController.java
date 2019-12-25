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

import library.dao.LibrarianDAO;
import library.model.LibrarianBean;

/**
 * Servlet implementation class PasswordController
 */
@WebServlet("/PasswordController")
public class PasswordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PasswordController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String currentPassword = request.getParameter("currentPassword");
		String newPassword = request.getParameter("newPassword");
		int libID = Integer.parseInt(request.getParameter("libID"));
		
		LibrarianBean librarian = new LibrarianBean();
		librarian.setLibID(libID);
		librarian.setPassword(currentPassword);
		try {
			librarian = LibrarianDAO.getPassword(librarian);
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(librarian.isValid()) {
			librarian.setPassword(newPassword);
			try {
				LibrarianDAO.updatePassword(librarian);
				librarian = LibrarianDAO.getUserByID(libID);
				request.setAttribute("successPass", "true");
	    		List<LibrarianBean> headLib = LibrarianDAO.getAllHeadLibrarian();
	            request.setAttribute("librarians", headLib); 
				request.setAttribute("librarian", librarian);	
				RequestDispatcher view = request.getRequestDispatcher("/domains/librarian/viewLibAccount.jsp"); //redirect to view details of own account
			    view.forward(request, response);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
		else {
				request.setAttribute("failPass", "true");
				RequestDispatcher view = request.getRequestDispatcher("/domains/librarian/updatePass.jsp"); //redirect to view details of own account
			    view.forward(request, response);
			
		}
		
	}

}
