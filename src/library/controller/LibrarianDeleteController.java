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


@WebServlet("/LibrarianDeleteController")
public class LibrarianDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private static String DELETE = "/domains/librarian/librarianDelete.jsp";
	 String forward ="";
	 //String operation ="";

	 private LibrarianDAO dao;

    public LibrarianDeleteController() {
        super();
        dao = new LibrarianDAO();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
       String action = request.getParameter("action");
       int libID = Integer.parseInt(request.getParameter("libID"));
		
       //this is to get the detail of that librarian to redirect to delete page
       if (action.equalsIgnoreCase("delete")){
			forward = DELETE;
        	libID = Integer.parseInt(request.getParameter("libID"));
        	LibrarianBean librarian = LibrarianDAO.getUserByID(libID);
        	request.setAttribute("librarian", librarian);      	
	}
    RequestDispatcher view = request.getRequestDispatcher(forward);
   	view.forward(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//this is for delete librarian and update librarian(done by head librarian)
		LibrarianBean librarian = new LibrarianBean();
        String operation = request.getParameter("operation");
       
       //for update librarian (done by head librarian)
       if(operation.equalsIgnoreCase("Update")) { 
			int libID = Integer.parseInt(request.getParameter("libID"));
			String libName = request.getParameter("libName");
			String libRole = request.getParameter("libRole");
			String managerID = request.getParameter("managerID");

			if(managerID.equalsIgnoreCase("No Manager"))
				librarian.setManagerID(null);
			else
				librarian.setManagerID(Integer.valueOf(request.getParameter("managerID")));

			librarian.setLibID(libID);
			librarian.setLibName(libName);
			librarian.setLibRole(libRole);

            try {
				dao.updateAccount2(librarian);
				request.setAttribute("successUpdate", "true"); //use for success update popup
				List<LibrarianBean> headLib = LibrarianDAO.getAllHeadLibrarian();
	            request.setAttribute("librarians", headLib); 
				request.setAttribute("librarian", librarian);
				RequestDispatcher view = request.getRequestDispatcher("/domains/librarian/librarianView.jsp");
				view.forward(request, response); 

			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}     			 	
		}

       else { //if operation equal to delete
			int libID = Integer.parseInt(request.getParameter("libID"));
			librarian.setLibID(libID);
            LibrarianDAO.deleteLibrarian(libID);
            request.setAttribute("successDelete", "true");//use for success delete popup 
            //use for redirect to list librarian page
    		List<LibrarianBean> librarian1 = LibrarianDAO.getAllUser();
            request.setAttribute("librarians", librarian1); 
            RequestDispatcher view = request.getRequestDispatcher("/domains/librarian/listLibrarian.jsp");
    		view.forward(request, response); 
		}	
		
      
		
	}

}
