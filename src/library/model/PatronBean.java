package library.model;

public class PatronBean {
	private String patronID;
	private String patronName;
	boolean valid;
	
	public PatronBean() {
		super();
	}
	
	public PatronBean(String patronID, String patronName, boolean valid) {
		super();
		this.patronID = patronID;
		this.patronName = patronName;
		this.valid = valid;
	}

	
	public String getPatronID() {
		return patronID;
	}
	public void setPatronID(String patronID) {
		this.patronID = patronID;
	}
	public String getPatronName() {
		return patronName;
	}
	public void setPatronName(String patronName) {
		this.patronName = patronName;
	}
	public boolean isValid() {
		return valid;
	}
	
	public void setValid(boolean valid) {
		this.valid = valid;
		
	}
}
