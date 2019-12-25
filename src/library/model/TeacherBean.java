package library.model;


public class TeacherBean extends PatronBean {
	private String patronID, specialization, tableNum;
	boolean valid;
	
	public TeacherBean() {
		// TODO Auto-generated constructor stub
	}
	public TeacherBean(String patronID, String patronName, boolean valid, String specialization, String tableNum) {
		super(patronID, patronName, valid);
		this.patronID = patronID;
		this.specialization = specialization;
		this.tableNum = tableNum;
		
	}
	
	public String getPatronID() {
		return patronID;
	}
	public void setPatronID(String patronID) {
		this.patronID = patronID;
	}
	public String getSpecialization() {
		return specialization;
	}
	public void setSpecialization(String specialization) {
		this.specialization = specialization;
	}
	public String getTableNum() {
		return tableNum;
	}
	public void setTableNum(String tableNum) {
		this.tableNum = tableNum;
	}
	public boolean isValid() {
		return valid;
	}
	public void setValid(boolean valid) {
		this.valid = valid;
	}
}
