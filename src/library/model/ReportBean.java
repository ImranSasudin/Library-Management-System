package library.model;

public class ReportBean {
	private String patronID;
	private String patronName;
	private int count;
	private int form;
	private String status;
	private String bookISBN;
	private String bookName;
	private String statusBook;
	private String borrowDate;
	private String expectedReturnDate;
	private String late;
	private String returnDate;
	private Double paidFine;
	
	
	public String getReturnDate() {
		return returnDate;
	}
	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}
	public Double getPaidFine() {
		return paidFine;
	}
	public void setPaidFine(Double paidFine) {
		this.paidFine = paidFine;
	}
	public String getBorrowDate() {
		return borrowDate;
	}
	public void setBorrowDate(String borrowDate) {
		this.borrowDate = borrowDate;
	}
	public String getLate() {
		return late;
	}
	public void setLate(String late) {
		this.late = late;
	}
	public String getExpectedReturnDate() {
		return expectedReturnDate;
	}
	public void setExpectedReturnDate(String expectedReturnDate) {
		this.expectedReturnDate = expectedReturnDate;
	}
	public String getBookISBN() {
		return bookISBN;
	}
	public void setBookISBN(String bookISBN) {
		this.bookISBN = bookISBN;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getStatusBook() {
		return statusBook;
	}
	public void setStatusBook(String statusBook) {
		this.statusBook = statusBook;
	}	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getForm() {
		return form;
	}
	public void setForm(int form) {
		this.form = form;
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
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
}
