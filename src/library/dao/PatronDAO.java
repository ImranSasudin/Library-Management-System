package library.dao;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import library.connection.ConnectionManager;
import library.model.LibrarianBean;
import library.model.PatronBean;
import library.model.StudentBean;

public class PatronDAO {

	static Connection currentCon = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement stat = null;
	static String patronName;
	static String patronID;
	
	//register patron
	public void add(PatronBean bean) {
		patronID = bean.getPatronID();
		patronName = bean.getPatronName();
		
		try {
			currentCon = ConnectionManager.getConnection();
			ps=currentCon.prepareStatement("insert into patron (patron_id, patron_name) values(?,?)");
			ps.setString(1,patronID);
			ps.setString(2,patronName);
			ps.executeUpdate();
			
			System.out.println("Patron name is " + patronName);
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
	//update patron
	 public void updateAccount(PatronBean bean) throws NoSuchAlgorithmException {

	        patronID = bean.getPatronID();
	        patronName = bean.getPatronName();
	      
	        String searchQuery = "UPDATE patron SET patron_name='" + patronName + "' WHERE patron_id= '" + patronID + "'";
	    	
	    	try {

	            currentCon = ConnectionManager.getConnection();
	            stat = currentCon.createStatement();
	            stat.executeUpdate(searchQuery);
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	 //delete patron
public  void deletePatron(String patronID) {
        try {
        	currentCon = ConnectionManager.getConnection();
        	ps=currentCon.prepareStatement("delete from patron where patron_ID=?");
            ps.setString(1,patronID);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
		
    }
	//get patron to identify his/her existence. if patron exist, set valid
public PatronBean getUser(PatronBean bean)  {
    	
        patronID = bean.getPatronID();

        String searchQuery = "select * from patron where patron_id='" + patronID + "'";

        try {
            currentCon = ConnectionManager.getConnection();
            stat = currentCon.createStatement();
            rs = stat.executeQuery(searchQuery);
            boolean more = rs.next();

            // if user exists set the isValid variable to true
            if (more) {
            	String patronID = rs.getString("patron_id");
           
                bean.setPatronID(patronID);
                bean.setValid(true);
           	}
           
            else if (!more) {
            	System.out.println("Sorry");
            	bean.setValid(false);
            }
           
        }

        catch (Exception ex) {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
        }

        finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (Exception e) {
                }
                rs = null;
            }

            if (stat != null) {
                try {
                    stat.close();
                } catch (Exception e) {
                }
                stat = null;
            }

            if (currentCon != null) {
                try {
                    currentCon.close();
                } catch (Exception e) {
                }

                currentCon = null;
            }
        }

        return bean;
    }
	//get detail about a patron from its id
public  PatronBean getUserByID(String patronID) {
    PatronBean patron = new PatronBean();
    try {
    	currentCon = ConnectionManager.getConnection();
        ps=currentCon.prepareStatement("select * from patron where patron_id=?");
        
        ps.setString(1, patronID);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            patron.setPatronID(rs.getString("patron_id"));
            patron.setPatronName(rs.getString("patron_name"));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return patron;
}
public List<PatronBean> getAllPatron() {
	
	  List<PatronBean> patrons = new ArrayList<PatronBean>();
	  
	  try {
	  	currentCon = ConnectionManager.getConnection();
	  	stat = currentCon.createStatement();
	  
	  	  String q = "select * from patron";
	      ResultSet rs = stat.executeQuery(q);
	      while (rs.next()) {
	    	  PatronBean patron = new PatronBean();
	    	  patron.setPatronID(rs.getString("patron_id"));
	    	  patron.setPatronName(rs.getString("patron_name"));
	        
	          patrons.add(patron);
	      }
	  } catch (SQLException e) {
	      e.printStackTrace();
	  }

	  return patrons;
	}
public List<PatronBean> getAllBorrowers() {
	
	  List<PatronBean> patrons = new ArrayList<PatronBean>();
	  
	  try {
	  	currentCon = ConnectionManager.getConnection();
	  	stat = currentCon.createStatement();
	  
	  	  String q = "select DISTINCT p.patron_id, p.patron_name from patron p join borrow b on(p.patron_id = b.patron_id) join borrow_book bb on(b.borrow_id = bb.borrow_id) where bb.status = 'Borrowed'";
	      ResultSet rs = stat.executeQuery(q);
	      while (rs.next()) {
	    	  PatronBean patron = new PatronBean();
	    	  patron.setPatronID(rs.getString("patron_id"));
	    	  patron.setPatronName(rs.getString("patron_name"));
	        
	          patrons.add(patron);
	      }
	  } catch (SQLException e) {
	      e.printStackTrace();
	  }

	  return patrons;
	}

}
