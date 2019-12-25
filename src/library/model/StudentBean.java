package library.model;


public class StudentBean extends PatronBean {
	private String registerDate;
	private String patronID, status;
	private Integer form;
	boolean valid;
	private String last_modified;

	public StudentBean() {
		super();
	}
	
	public StudentBean(String patronName, String patronID, boolean valid, String status, String registerDate, Integer form) {
		super(patronName, patronID, valid);
		this.patronID = patronID;
		this.status = status;
		this.registerDate = registerDate;
		this.form = form;
		
	}
	
	public String getLast_modified() {
		return last_modified;
	}

	public void setLast_modified(String last_modified) {
		this.last_modified = last_modified;
	}
	public String getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(String registerDate) {
		this.registerDate = registerDate;
	}
	public String getPatronID() {
		return patronID;
	}
	public void setPatronID(String patronID) {
		this.patronID = patronID;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Integer getForm() {
		return form;
	}
	public void setForm(Integer form) {
		this.form = form;
	}
	public boolean isValid() {
		return valid;
	}
	
	public void setValid(boolean valid) {
		this.valid = valid;
		
	}
}
