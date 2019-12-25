package library.dao;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import library.connection.ConnectionManager;
import library.model.PatronBean;
import library.model.StudentBean;

public class StudentDAO {
	static Connection currentCon = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement stat = null;
	static String patronID;
	static String status;
	static Integer form;
	static String registerDate;

	//register student
	public void add(StudentBean bean) throws ParseException {
		patronID = bean.getPatronID();
		status = bean.getStatus();
		form = bean.getForm();
		registerDate =  bean.getRegisterDate();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date date = sdf1.parse(registerDate);
		java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
		/*String startDate="01-02-2013";
		SimpleDateFormat sdf1 = new SimpleDateFormat("dd-mm-yyyy");
		java.util.Date date = sdf1.parse(startDate);
		java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());*/
		try {
			currentCon = ConnectionManager.getConnection();
			ps=currentCon.prepareStatement("insert into student (patron_id, register_date, status, form, last_modified) values(?,?,?,?,sysdate)");
			ps.setString(1,patronID);
			ps.setDate(2, sqlStartDate);
			ps.setString(3,status);
			ps.setInt(4,form);
			ps.executeUpdate();
			
			System.out.println("Student status is " + status);
			System.out.println("Patron ID is " + patronID);
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
	//update student
	public void updateAccount(StudentBean bean) throws NoSuchAlgorithmException, ParseException {

        patronID = bean.getPatronID();
        status = bean.getStatus();
        form = bean.getForm();
       
      
        String searchQuery = "UPDATE student SET  status='" + status + "', form=" + form + "  WHERE patron_id= '" + patronID + "'";
    	System.out.println(searchQuery);
    	try {

            currentCon = ConnectionManager.getConnection();
            stat = currentCon.createStatement();
            stat.executeUpdate(searchQuery);
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	//get detail about a student from its id
public  StudentBean getUserByID(String patronID) {
	    StudentBean student = new StudentBean();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select patron_id, to_char(register_date,'dd-MON-yyyy'), status, form from student where patron_id=?");
	        
	        ps.setString(1, patronID);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            student.setPatronID(rs.getString("patron_id"));
	            student.setRegisterDate(rs.getString(2));
				student.setStatus(rs.getString("status"));
				student.setForm(rs.getInt("form"));	       
				}
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return student;
	}
	//get all students
public static List<StudentBean> getAllStudent() {
	
	  List<StudentBean> students = new ArrayList<StudentBean>();
	  
	  try {
	  	currentCon = ConnectionManager.getConnection();
	  	stat = currentCon.createStatement();
	  
	  	  String q = "select p.patron_id, p.patron_name, to_char(s.register_date,'dd-MON-yyyy'), s.status, s.form from patron p join student s on (s.patron_id = p.patron_id)";
	      ResultSet rs = stat.executeQuery(q);
	      while (rs.next()) {
	          StudentBean student = new StudentBean();
	          student.setPatronID(rs.getString(1));
	          student.setPatronName(rs.getString(2));
	          student.setRegisterDate(rs.getString(3));
	          student.setStatus(rs.getString(4));
	          student.setForm(rs.getInt(5));
	          students.add(student);
	      }
	  } catch (SQLException e) {
	      e.printStackTrace();
	  }

	  return students;
	}
	
}
