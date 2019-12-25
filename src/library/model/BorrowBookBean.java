package library.model;

public class BorrowBookBean {
	private Integer borrowID;
	private String bookISBN;
	private String status;
	private String returnDate;
	private String expectedReturnDate;
	private Integer paidFine;
	
	public BorrowBookBean(Integer borrowID, String bookISBN, String status, String returnDate, String expectedReturnDate, Integer paidFine) {
		super();
		this.borrowID = borrowID;
		this.bookISBN = bookISBN;
		this.status = status;
		this.returnDate = returnDate;
		this.expectedReturnDate = expectedReturnDate;
		this.paidFine = paidFine;
	}
	
	public BorrowBookBean() {
		super();
	}
	
	public Integer getBorrowID() {
		return borrowID;
	}
	public void setBorrowID(Integer borrowID) {
		this.borrowID = borrowID;
	}
	public String getBookISBN() {
		return bookISBN;
	}
	public void setBookISBN(String bookISBN) {
		this.bookISBN = bookISBN;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	public String getExpectedReturnDate() {
		return expectedReturnDate;
	}

	public void setExpectedReturnDate(String expectedReturnDate) {
		this.expectedReturnDate = expectedReturnDate;
	}

	public Integer getPaidFine() {
		return paidFine;
	}

	public void setPaidFine(Integer paidFine) {
		this.paidFine = paidFine;
	}
	
}
