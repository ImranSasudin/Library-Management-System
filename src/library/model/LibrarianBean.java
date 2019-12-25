package library.model;

public class LibrarianBean {
	int libID;
	String libName;
	String password,libRole;
	Integer managerID = null;
	Integer maxBorrow;
	
	public Integer getMaxBorrow() {
		return maxBorrow;
	}
	public void setMaxBorrow(Integer maxBorrow) {
		this.maxBorrow = maxBorrow;
	}

	boolean valid;
	
	public int getLibID() {
		return libID;
	}
	public void setLibID(int libID) {
		this.libID = libID;
	}
	public String getLibName() {
		return libName;
	}
	public void setLibName(String libName) {
		this.libName = libName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
		
	}
	public String getLibRole() {
		return libRole;
	}
	public void setLibRole(String libRole) {
		this.libRole = libRole;
	}
	public Integer getManagerID() {
		return managerID;
	}
	public void setManagerID(Integer managerID) {
		this.managerID = managerID;
	}
	
	public boolean isValid() {
		return valid;
	}
	
	public void setValid(boolean valid) {
		this.valid = valid;
		
	}
}
