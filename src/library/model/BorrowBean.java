package library.model;

public class BorrowBean {
	private Integer borrowID;
	private String patronID;
	private Integer libID;
	private String borrowDate;
	
	public BorrowBean(Integer borrowID, String patronID, Integer libID, String borrowDate) {
		super();
		this.borrowID = borrowID;
		this.patronID = patronID;
		this.libID = libID;
		this.borrowDate = borrowDate;
	}
	public BorrowBean() {
		super();
	}
	
	public Integer getBorrowID() {
		return borrowID;
	}
	public void setBorrowID(Integer borrowID) {
		this.borrowID = borrowID;
	}
	public String getPatronID() {
		return patronID;
	}
	public void setPatronID(String patronID) {
		this.patronID = patronID;
	}
	public Integer getLibID() {
		return libID;
	}
	public void setLibID(Integer libID) {
		this.libID = libID;
	}
	public String getBorrowDate() {
		return borrowDate;
	}
	public void setBorrowDate(String borrowDate) {
		this.borrowDate = borrowDate;
	}
}
