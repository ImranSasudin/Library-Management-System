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
import library.model.StudentBean;
import library.model.TeacherBean;

public class TeacherDAO {
	static Connection currentCon = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement stat = null;
	static String patronID;
	static String specialization;
	static String tableNum;

	//register teacher
	public void add(TeacherBean bean) {
		patronID = bean.getPatronID();
		specialization = bean.getSpecialization();
		tableNum = bean.getTableNum();	
		
		try {
			currentCon = ConnectionManager.getConnection();
			ps=currentCon.prepareStatement("insert into teacher (patron_id, teacher_specialization, table_number) values(?,?,?)");
			ps.setString(1,patronID);
			ps.setString(2,specialization);
			ps.setString(3,tableNum);
			ps.executeUpdate();
			
			System.out.println("Teacher specizalization is " + specialization);
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
	//update teacher account
	public void updateAccount(TeacherBean bean) throws NoSuchAlgorithmException, ParseException {

        patronID = bean.getPatronID();
        specialization = bean.getSpecialization();
        tableNum = bean.getTableNum();
             
        String searchQuery = "UPDATE teacher SET teacher_specialization ='" + specialization + "', table_number ='" + tableNum + "' WHERE patron_id= '" + patronID + "'";
    	
    	try {

            currentCon = ConnectionManager.getConnection();
            stat = currentCon.createStatement();
            stat.executeUpdate(searchQuery);
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	//get detail about a teacher from its id
	public  TeacherBean getUserByID(String patronID) {
	    TeacherBean teacher = new TeacherBean();
	    try {
	    	currentCon = ConnectionManager.getConnection();
	        ps=currentCon.prepareStatement("select * from teacher where patron_id=?");
	        
	        ps.setString(1, patronID);

	        ResultSet rs = ps.executeQuery();

	        if (rs.next()) {
	            teacher.setPatronID(rs.getString("patron_id"));
	            teacher.setSpecialization(rs.getString("teacher_specialization"));
				teacher.setTableNum(rs.getString("table_number"));
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return teacher;
	}
	//get all teachers
	 public static List<TeacherBean> getAllTeacher() {
	        List<TeacherBean> teachers = new ArrayList<TeacherBean>();
	        try {
	        	currentCon = ConnectionManager.getConnection();
	        	stat = currentCon.createStatement();
	            ResultSet rs = stat.executeQuery("select p.patron_id, p.patron_name, t.teacher_specialization , t.table_number from patron p join teacher t on (t.patron_id = p.patron_id)");
	            
	            while (rs.next()) {
	                TeacherBean teacher = new TeacherBean();
	                teacher.setPatronID(rs.getString(1));
	                teacher.setPatronName(rs.getString(2));
	                teacher.setSpecialization(rs.getString(3));
	                teacher.setTableNum(rs.getString(4));
	                teachers.add(teacher);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }

	        return teachers;
	    }
}
