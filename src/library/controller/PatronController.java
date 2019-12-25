package library.controller;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.dao.PatronDAO;
import library.dao.StudentDAO;
import library.dao.TeacherDAO;
import library.model.PatronBean;
import library.model.StudentBean;
import library.model.TeacherBean;


@WebServlet("/PatronController")
public class PatronController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	PatronDAO patronDAO;
	StudentDAO studentDAO;
	TeacherDAO teacherDAO;
	String UPDATE = "/domains/patron/updatePatron.jsp";
	String DELETE = "/domains/patron/deletePatron.jsp";
	String LIST_PATRON = "/domains/patron/listPatron.jsp";
	String VIEW = "/domains/patron/viewPatron.jsp";
	String forward ="";
	
    
    public PatronController() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
    	patronDAO =  new PatronDAO();
		studentDAO = new StudentDAO();
		teacherDAO = new TeacherDAO();
		//for all patron (for both student and teacher)
		if (action.equalsIgnoreCase("listPatron")){ 		
            forward = LIST_PATRON;
            List<TeacherBean> teacher = TeacherDAO.getAllTeacher();
            List<StudentBean> student = StudentDAO.getAllStudent();
            request.setAttribute("students", student);
            request.setAttribute("teachers", teacher); 
            request.setAttribute("listPatron", "true");
		}
		//for update teacher (get teacher details from both tables (patron and teacher)
		if(action.equalsIgnoreCase("updateTeacher")) {
			PatronBean patron = new PatronBean();
        	TeacherBean teacher = new TeacherBean();
        	forward= UPDATE;
        	String patronID = request.getParameter("patronID");
        	patron.setPatronID(patronID);
        	patron = patronDAO.getUserByID(patronID);
        	request.setAttribute("patron", patron);
        	request.setAttribute("patronType", "Teacher");
        	teacher.setPatronID(patronID);
        	teacher = teacherDAO.getUserByID(patronID);
        	request.setAttribute("teacher", teacher);
		}
		//for update student (get student details from both tables (patron and student)
		else if(action.equalsIgnoreCase("updateStudent")) {
			PatronBean patron = new PatronBean();
        	StudentBean student = new StudentBean();
        	forward= UPDATE;
        	String patronID = request.getParameter("patronID");
        	patron.setPatronID(patronID);
        	patron = patronDAO.getUserByID(patronID);
        	request.setAttribute("patron", patron);
        	request.setAttribute("patronType", "Student");
        	student.setPatronID(patronID);
        	student = studentDAO.getUserByID(patronID);
        	request.setAttribute("student", student);
		}
		//for delete teacher (get teacher details from both tables (patron and teacher)
		else if(action.equalsIgnoreCase("deleteTeacher")) {
			PatronBean patron = new PatronBean();
			TeacherBean teacher = new TeacherBean();
        	forward= DELETE;
        	String patronID = request.getParameter("patronID");
        	patron.setPatronID(patronID);
        	patron = patronDAO.getUserByID(patronID);
        	request.setAttribute("patron", patron);
        	request.setAttribute("patronType", "Teacher");
        	teacher.setPatronID(patronID);
        	teacher = teacherDAO.getUserByID(patronID);
        	request.setAttribute("teacher", teacher);
		}
		//for delete student (get student details from both tables (patron and student)
		else if(action.equalsIgnoreCase("deleteStudent")) {
			PatronBean patron = new PatronBean();
        	StudentBean student = new StudentBean();
        	forward= DELETE;
        	String patronID = request.getParameter("patronID");
        	patron.setPatronID(patronID);
        	patron = patronDAO.getUserByID(patronID);
        	request.setAttribute("patron", patron);
        	request.setAttribute("patronType", "Student");
        	student.setPatronID(patronID);
        	student = studentDAO.getUserByID(patronID);
        	request.setAttribute("student", student);
		}
		else if(action.equalsIgnoreCase("viewPatron")) {
			PatronBean patron = new PatronBean();
        	StudentBean student = new StudentBean();
        	TeacherBean teacher = new TeacherBean();
        	forward= VIEW;
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
        	request.setAttribute("listPatron", "true");
		}
       	RequestDispatcher view = request.getRequestDispatcher(forward);
        view.forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				PatronBean patron = new PatronBean();
				StudentBean student = new StudentBean();
            	TeacherBean teacher = new TeacherBean();
            	patronDAO =  new PatronDAO();
				studentDAO = new StudentDAO();
				teacherDAO = new TeacherDAO();
				boolean valid = false; //just to initialize
				String action = request.getParameter("action");
				//for delete student / teacher
				if(action.equalsIgnoreCase("Delete")) {
					String patronID = (request.getParameter("patronID"));
					patron.setPatronID(patronID);
		            patronDAO.deletePatron(patronID);
		            List<TeacherBean> teacher1 = teacherDAO.getAllTeacher();
		            List<StudentBean> student1 = studentDAO.getAllStudent();
		            request.setAttribute("students", student1);
		            request.setAttribute("teachers", teacher1);
		            request.setAttribute("successDelete", "true"); //use for delete success popup
			        RequestDispatcher view = request.getRequestDispatcher("/domains/patron/listPatron.jsp");
					view.forward(request, response); 
				}
				//register or update 
				else if(action.equalsIgnoreCase("Register") || action.equalsIgnoreCase("Update")) {
				String typePatron = request.getParameter("typePatron");
				String patronID = request.getParameter("patronID");
				String patronName = request.getParameter("patronName");
				
				patron.setPatronID(patronID);
				patron.setPatronName(patronName);
				
				patronDAO.getUser(patron);
				//if patron is invalid (patron doesn't exist in database), means, it is register 
				if(!patron.isValid()) {
					patronDAO.add(patron); //add in table patron first
					if(typePatron.equalsIgnoreCase("Student")) { //for student
						String status = "Studying";
						String registerDate = request.getParameter("registerDate");
						Integer form = Integer.valueOf(request.getParameter("form"));
						student = new StudentBean(patronName, patronID, valid, status, registerDate, form);

						try {
							studentDAO.add(student); //add in table student
							
						} catch (ParseException e) {
							e.printStackTrace();
						}
					
						}
					else {//if typepatron is teacher (for teacher)
						String specialization = request.getParameter("specialization");
						String tableNum = request.getParameter("tableNum");
						teacher = new TeacherBean(patronID,patronName, valid, specialization, tableNum);
						teacherDAO.add(teacher); //add in table teacher
						}
					request.setAttribute("successRegister", "true"); //use for register success popup
					RequestDispatcher view = request.getRequestDispatcher("/domains/patron/PatronRegistration.jsp");
					view.forward(request, response); 
				
				}
				else {// for update (if user  exist ( valid)
		    		if(typePatron.equalsIgnoreCase("Student")) {
						try {
							patronDAO.updateAccount(patron); //update in patron table first (for teacher)
							request.setAttribute("patron", patron);
						} catch (NoSuchAlgorithmException e) {
							e.printStackTrace();
						}
						String status = request.getParameter("status");
						if(status.equalsIgnoreCase("Graduated")) {
							Integer form = null;
							String registerDate = request.getParameter("registerDate");
							student = new StudentBean(patronName, patronID, valid, status, registerDate, form);
						}
						else {
							Integer form = Integer.valueOf(request.getParameter("form"));
							String registerDate = request.getParameter("registerDate");
							student = new StudentBean(patronName, patronID, valid, status, registerDate, form);
						}
						
						try {
							studentDAO.updateAccount(student); //update in table student
				            request.setAttribute("patronType", "Student");
							request.setAttribute("student", student);
						} catch (NoSuchAlgorithmException | ParseException e) {
							e.printStackTrace();
						}
					}
					else {
						try {
							patronDAO.updateAccount(patron); //update in patron table first (for teacher)
							request.setAttribute("patron", patron);
						} catch (NoSuchAlgorithmException e) {
							e.printStackTrace();
						}
						String specialization = request.getParameter("specialization");
						String tableNum = request.getParameter("tableNum");
						teacher = new TeacherBean(patronID, patronName, valid, specialization, tableNum);
						try {
							teacherDAO.updateAccount(teacher); //update in table teacher
				            request.setAttribute("patronType", "Teacher");
							request.setAttribute("teacher", teacher);
						} catch (NoSuchAlgorithmException | ParseException e) {
							e.printStackTrace();
						}
					}
		    		
		    		//below is just for redirect use
		            request.setAttribute("successUpdate", "true"); //for success update use
			        RequestDispatcher view = request.getRequestDispatcher("/domains/patron/viewPatron.jsp");
					view.forward(request, response); 
				}
				
			}
	            
		}
	}

