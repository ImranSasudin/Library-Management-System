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


@WebServlet("/LibrarianController")
public class LibrarianController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private String VIEW = "/domains/librarian/viewLibAccount.jsp";
    private String UPDATE = "/domains/librarian/updateLibAccount.jsp";
    private String LIST_LIBRARIAN = "/domains/librarian/listLibrarian.jsp";
    private String LIBRARIAN_REGISTRATION = "/librarianRegistration.jsp";
    private String UPDATE_LIBRARIAN = "/domains/librarian/librarianUpdate.jsp";
    private String VIEW_LIBRARIAN = "/domains/librarian/librarianView.jsp";
	private String forward;
	private String operation;
    private LibrarianDAO dao;

    public LibrarianController() {
        super();
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String action = request.getParameter("action");
    	//update own account
    	if(action.equalsIgnoreCase("updateLibAccount")) {
    		forward = UPDATE;
    		Integer libID = Integer.valueOf(request.getParameter("libID"));
    		LibrarianBean librarian = LibrarianDAO.getUserByID(libID);
    		List<LibrarianBean> headLib = LibrarianDAO.getAllHeadLibrarian();
            request.setAttribute("librarians", headLib); 
    		request.setAttribute("librarian", librarian);
    	}
    	//view own account (before update)
    	else if (action.equalsIgnoreCase("viewLibAccount")) {
    		forward = VIEW;
    		Integer libID = Integer.valueOf(request.getParameter("libID"));
    		LibrarianBean librarian = LibrarianDAO.getUserByID (libID);
    		List<LibrarianBean> headLib = LibrarianDAO.getAllHeadLibrarian();
            request.setAttribute("librarians", headLib); 
    		request.setAttribute("librarian", librarian);
    	}
    	
    	//list all librarians and head librarians
    	else if (action.equalsIgnoreCase("listLibrarian")){
    		forward = LIST_LIBRARIAN;
    		List<LibrarianBean> librarian = LibrarianDAO.getAllUser();
    		List<LibrarianBean> headLib = LibrarianDAO.getAllHeadLibrarian();
            request.setAttribute("librarian", headLib); 
            request.setAttribute("librarians", librarian); 
          
            for (LibrarianBean l : librarian) {
    		System.out.println(l.getLibID());
    		}
    	}
    	
    	//register librarian (done by head librarian only)
    	else if (action.equalsIgnoreCase("librarianRegistration")){
    		forward = LIBRARIAN_REGISTRATION;
    		List<LibrarianBean> librarian = LibrarianDAO.getAllHeadLibrarian();
            request.setAttribute("librarians", librarian); 
    	}
    	
    	//update librarian (done by  head librarian only. only can update their manager id and role) 
    	else if(action.equalsIgnoreCase("updateLibrarian")) {
    		forward = UPDATE_LIBRARIAN;
    		Integer libID = Integer.valueOf(request.getParameter("libID"));
    		LibrarianBean librarian = LibrarianDAO.getUserByID (libID);
    		List<LibrarianBean> headLib = LibrarianDAO.getAllHeadLibrarian();
            request.setAttribute("librarians", headLib); 
    		request.setAttribute("librarian", librarian);
    	}
    	//for view librarian from clicking the librarian_id in the librarianlist
    	else if(action.equalsIgnoreCase("viewLibrarian")) {
    		forward = VIEW_LIBRARIAN;
    		Integer libID = Integer.valueOf(request.getParameter("libID"));
    		LibrarianBean librarian = LibrarianDAO.getUserByID (libID);
    		List<LibrarianBean> headLib = LibrarianDAO.getAllHeadLibrarian();
            request.setAttribute("librarians", headLib); 
			request.setAttribute("librarian", librarian);
    	}
    	
    	RequestDispatcher view = request.getRequestDispatcher(forward);
    	view.forward(request,response);
    	}
    
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//this is for register librarian and update own account only
		LibrarianBean librarian = new LibrarianBean();
        operation = request.getParameter("operation");
		
		
		if(operation.equalsIgnoreCase("Update")) { //if register, no need to get parameter libID because it is auto increment in database
		librarian.setLibID(Integer.parseInt(request.getParameter("libID")));
		}
		
		librarian.setLibName(request.getParameter("libName"));
		
		
		if(operation.equalsIgnoreCase("Register")) { //if update own account, librarian can't update their role, so no need to get parameter role
		librarian.setLibRole(request.getParameter("libRole"));
		librarian.setPassword(request.getParameter("password"));
		String managerID = request.getParameter("managerID");
		if(managerID.equalsIgnoreCase("No Manager"))
			librarian.setManagerID(null);
		else
		librarian.setManagerID(Integer.valueOf(request.getParameter("managerID")));
		}
		
		dao =  new LibrarianDAO();
		librarian = LibrarianDAO.getUser(librarian); //getUser just to identify whether that librarian is exist in database or not
		
		if(!librarian.isValid()) { //if librarian is not valid, means librarian is not exist, so it is for register
		try {
			dao.add(librarian);
			request.setAttribute("librarian", librarian);
			request.setAttribute("successRegister","true"); //this attribute is for success register popup
			RequestDispatcher view = request.getRequestDispatcher("/librarianID.jsp"); //redirect to this page to display the details of that new account
		    view.forward(request, response);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		}
		else { //if librarian is valid
			try {
				dao.updateAccount(librarian);
				librarian = LibrarianDAO.getUserByID(librarian.getLibID());
				request.setAttribute("successUpdate","true");//this attribute is for success update popup
				request.setAttribute("librarian", librarian);
				request.setAttribute("librarians", LibrarianDAO.getAllHeadLibrarian());
				RequestDispatcher view = request.getRequestDispatcher("/domains/librarian/viewLibAccount.jsp"); //redirect to view details of own account
			    view.forward(request, response);
			}catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			}
		
		}
		}
	}


