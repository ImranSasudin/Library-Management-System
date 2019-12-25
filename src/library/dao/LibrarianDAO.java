package library.dao;

import java.security.MessageDigest;
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

public class LibrarianDAO {
	static Connection currentCon = null;
	static ResultSet rs = null;
	static PreparedStatement ps = null;
	static Statement stat = null;
	static String libName, password, libRole;
	static int libID;
	static Integer managerID, maxBorrow;
	
	public void add(LibrarianBean bean) throws NoSuchAlgorithmException {
		libName = bean.getLibName();
		password = bean.getPassword();
		managerID = bean.getManagerID();
		libRole = bean.getLibRole();
		
		 MessageDigest md = MessageDigest.getInstance("MD5");
	        md.update(password.getBytes());
	 
	        byte byteData[] = md.digest();
	 
	        //convert the byte to hex format
	        StringBuffer sb = new StringBuffer();
	        for (int i = 0; i < byteData.length; i++) {
	         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
	        }
	        
	        String pass = sb.toString();
	        String searchQuery = "select  LIBRARIAN_SEQ1.currval from dual";
		try {
			currentCon = ConnectionManager.getConnection();
			
			
			if(bean.getManagerID()==null) {
			ps=currentCon.prepareStatement("insert into librarian (librarian_id,librarian_name, librarian_password, librarian_managerID, librarian_role) values(LIBRARIAN_SEQ1.nextval,?,?,?,?)");
			ps.setString(1,libName);
			ps.setString(2,pass);
			ps.setString(3,null);
			ps.setString(4,libRole);
			ps.executeUpdate();
			
			stat = currentCon.createStatement();
	        rs = stat.executeQuery(searchQuery);
            boolean more = rs.next();
            
            if (more) {
            	Integer libID = rs.getInt(1);
            	
            	bean.setPassword(password);
                bean.setLibID(libID);
                bean.setLibName(libName);
           	}
           
            else if (!more) {
            	System.out.println("Sorry");
            }
			}
			else {
			ps=currentCon.prepareStatement("insert into librarian (librarian_id,librarian_name, librarian_password, librarian_managerID,librarian_role) values(LIBRARIAN_SEQ1.nextval,?,?,?,?)");
			ps.setString(1,libName);
			ps.setString(2,pass);
			ps.setInt(3,managerID);
			ps.setString(4,libRole);
			ps.executeUpdate();
			
			stat = currentCon.createStatement();
	        rs = stat.executeQuery(searchQuery);
            boolean more = rs.next();
            
            if (more) {
            	Integer libID = rs.getInt(1);
            	
            	bean.setPassword(password);
                bean.setLibID(libID);
                bean.setLibName(libName);

           	}
           
            else if (!more) {
            	System.out.println("Sorry");
            }
			}
			System.out.println("librarian name is " + libName);
			System.out.println("Your password is " + password);
			System.out.println("Your password (encrypted) is " + pass);

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
	public static LibrarianBean login(LibrarianBean bean) throws NoSuchAlgorithmException {
		libID = bean.getLibID();
		password = bean.getPassword();
		libRole = bean.getLibRole();

		
		//convert the password to MD5
        MessageDigest md = MessageDigest.getInstance("MD5");
        md.update(password.getBytes());
 
        byte byteData[] = md.digest();
 
        //convert the byte to hex format
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < byteData.length; i++) {
         sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
        }
        
        String searchQuery = "select * from librarian where librarian_ID = '" + libID + "' AND librarian_password = '" + sb.toString() + "'";
        
        System.out.println("Your password is = " + password);
        System.out.println("Query: " + searchQuery);
        
        try {
            currentCon = ConnectionManager.getConnection();
            stat = currentCon.createStatement();
            rs = stat.executeQuery(searchQuery);
            boolean more = rs.next();

            // if user exists set the isValid variable to true
            if (more) {
            	int libID = rs.getInt("librarian_ID");
            	String libRole = rs.getString("librarian_role");
            	String libName = rs.getString("librarian_name");
           		System.out.println("Welcome " + libID);
           		System.out.println("Welcome " + libRole);
                bean.setLibID(libID);
                bean.setLibRole(libRole);
                bean.setLibName(libName);
                bean.setValid(true);
           	}
           
            // if user does not exist set the isValid variable to false
            else if (!more) {
            	System.out.println("Sorry, you are not a registered librarian! Please sign up first");
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
	
	public static void deleteLibrarian(int libID) {
        try {
        	currentCon = ConnectionManager.getConnection();
        	ps=currentCon.prepareStatement("delete from librarian where librarian_ID=?");
            ps.setInt(1, libID);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
		
    }
	
	//this is for update own account
	public void updateAccount(LibrarianBean bean) throws NoSuchAlgorithmException{
			libID = bean.getLibID();
			libName = bean.getLibName();
			managerID = bean.getManagerID();
			
			
		    String searchQuery = "UPDATE librarian SET librarian_name ='" + libName + "' WHERE librarian_id = '" + libID + "'";
			
			try {
				currentCon = ConnectionManager.getConnection();
				stat = currentCon.createStatement();
				stat.executeUpdate(searchQuery);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	//this is for update librarian account (done by head librarian)
	public void updateAccount2(LibrarianBean bean) throws NoSuchAlgorithmException{
		libID = bean.getLibID();
		libName = bean.getLibName();
		password = bean.getPassword();
		managerID = bean.getManagerID();
		libRole = bean.getLibRole();
		String searchQuery;
		
		if(managerID != null)
			searchQuery = "UPDATE librarian SET librarian_name ='" + libName + "', librarian_role = '" + libRole + "', librarian_managerID = '" + managerID + "' WHERE librarian_id = '" + libID + "'";
		else
			searchQuery = "UPDATE librarian SET librarian_name ='" + libName + "', librarian_role = '" + libRole + "', librarian_managerID = null WHERE librarian_id = '" + libID + "'";
			
		
	    
		try {
			currentCon = ConnectionManager.getConnection();
			stat = currentCon.createStatement();
			stat.executeUpdate(searchQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	}
	public static void updateMaxBorrow(Integer maxBorrow) throws NoSuchAlgorithmException{
		String searchQuery;
		
		searchQuery = "UPDATE librarian SET max_borrow ='" + maxBorrow + "' WHERE librarian_role = 'Head Librarian'";
	    
		try {
			currentCon = ConnectionManager.getConnection();
			stat = currentCon.createStatement();
			stat.executeUpdate(searchQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	
	}
	
	//array to get all librarian to display in listlibrarian
	public static List<LibrarianBean> getAllUser() {
        List<LibrarianBean> librarians = new ArrayList<LibrarianBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select * from librarian order by librarian_id");
            
            while (rs.next()) {
                LibrarianBean librarian = new LibrarianBean();
                librarian.setLibID(rs.getInt("librarian_id"));
                librarian.setLibName(rs.getString("librarian_name"));
                librarian.setManagerID(rs.getInt("librarian_ManagerID"));
                librarian.setLibRole(rs.getString("librarian_role"));

                librarians.add(librarian);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return librarians;
    }
	
	//array to get all headlibrarian use for autocomplete in manager id input (textbox)
	public static List<LibrarianBean> getAllHeadLibrarian() {
        List<LibrarianBean> librarians = new ArrayList<LibrarianBean>();
        try {
        	currentCon = ConnectionManager.getConnection();
        	stat = currentCon.createStatement();
            ResultSet rs = stat.executeQuery("select librarian_id, librarian_managerid, upper(librarian_name), librarian_password, librarian_role from librarian where librarian_role = 'Head Librarian'");
            
            while (rs.next()) {
                LibrarianBean librarian = new LibrarianBean();
                librarian.setLibID(rs.getInt("librarian_id"));
                librarian.setLibName(rs.getString(3));
                librarian.setManagerID(rs.getInt("librarian_ManagerID"));
                librarian.setLibRole(rs.getString("librarian_role"));

                librarians.add(librarian);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return librarians;
    }
	
	//get user use to check if user is exist or not
public static LibrarianBean getUser(LibrarianBean bean)  {
    	
        libID = bean.getLibID();

        String searchQuery = "select * from librarian where librarian_id='" + libID + "'";

        try {
            currentCon = ConnectionManager.getConnection();
            stat = currentCon.createStatement();
            rs = stat.executeQuery(searchQuery);
            boolean more = rs.next();

            // if user exists set the isValid variable to true
            if (more) {
            	int libID = rs.getInt("librarian_id");
           
                bean.setLibID(libID);
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
	//get details about a librarian from its ID
public static LibrarianBean getUserByID(int libID) {
    LibrarianBean librarian = new LibrarianBean();
    try {
    	currentCon = ConnectionManager.getConnection();
        ps=currentCon.prepareStatement("select * from librarian where librarian_id=?");
        
        ps.setInt(1, libID);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            librarian.setLibID(rs.getInt("librarian_id"));
            librarian.setLibName(rs.getString("librarian_name"));
            librarian.setPassword(rs.getString("librarian_password"));
            librarian.setManagerID(rs.getInt("librarian_managerID"));
            librarian.setLibRole(rs.getString("librarian_role"));
            librarian.setMaxBorrow(rs.getInt("max_borrow"));

        }
    } catch (SQLException e) {
        e.printStackTrace();
    }

    return librarian;
}
public static LibrarianBean getPassword(LibrarianBean bean) throws NoSuchAlgorithmException  {
	
    libID = bean.getLibID();
    password = bean.getPassword();
  //convert the password to MD5
    MessageDigest md = MessageDigest.getInstance("MD5");
    md.update(password.getBytes());

    byte byteData[] = md.digest();

    //convert the byte to hex format
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < byteData.length; i++) {
     sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
    }
    
    String pass = sb.toString();

    String searchQuery = "select * from librarian where librarian_id='" + libID + "' AND librarian_password='" + pass + "'";

    try {
        currentCon = ConnectionManager.getConnection();
        stat = currentCon.createStatement();
        rs = stat.executeQuery(searchQuery);
        boolean more = rs.next();

        // if user exists set the isValid variable to true
        if (more) {
        	int libID = rs.getInt("librarian_id");
        	String pass1 = rs.getString("librarian_password");
            bean.setLibID(libID);
            bean.setPassword(pass1);
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
public static void updatePassword(LibrarianBean bean) throws NoSuchAlgorithmException{
	libID = bean.getLibID();
	password = bean.getPassword();
	 //convert the password to MD5
    MessageDigest md = MessageDigest.getInstance("MD5");
    md.update(password.getBytes());

    byte byteData[] = md.digest();

    //convert the byte to hex format
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < byteData.length; i++) {
     sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
    }
    
    String pass = sb.toString();
	
    String searchQuery = "UPDATE librarian SET librarian_password ='" + pass + "' WHERE librarian_id = '" + libID + "'";
	
	try {
		currentCon = ConnectionManager.getConnection();
		stat = currentCon.createStatement();
		stat.executeUpdate(searchQuery);
	} catch (SQLException e) {
		e.printStackTrace();
	}
}
    
	}

