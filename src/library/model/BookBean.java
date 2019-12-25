package library.model;

public class BookBean {
	private String bookISBN;
	private String bookName;
	private String bookPrice;
	private String bookPublisher;
	private String bookLocation;
	private Integer bookQuantity, bookCurrentQuantity, count;
	private Double fine;
	boolean valid;
	
	public BookBean() {
		super();
	}
	public BookBean(String bookISBN, String bookName, String bookPrice, String bookPublisher, String bookLocation,
			Integer bookQuantity, Integer bookCurrentQuantity, boolean valid) {
		super();
		this.bookISBN = bookISBN;
		this.bookName = bookName;
		this.bookPrice = bookPrice;
		this.bookPublisher = bookPublisher;
		this.bookLocation = bookLocation;
		this.bookQuantity = bookQuantity;
		this.bookCurrentQuantity = bookCurrentQuantity;
		this.valid = valid;
	}
	
	public Integer getBookQuantity() {
		return bookQuantity;
	}
	public void setBookQuantity(Integer bookQuantity) {
		this.bookQuantity = bookQuantity;
	}
	public Integer getCount() {
		return count;
	}
	public void setCount(Integer count) {
		this.count = count;
	}
	public Integer getBookCurrentQuantity() {
		return bookCurrentQuantity;
	}
	public void setBookCurrentQuantity(Integer bookCurrentQuantity) {
		this.bookCurrentQuantity = bookCurrentQuantity;
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
	public String getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(String bookPrice) {
		this.bookPrice = bookPrice;
	}
	public Double getFine() {
		return fine;
	}
	public void setFine(Double fine) {
		this.fine = fine;
	}
	public String getBookPublisher() {
		return bookPublisher;
	}
	public void setBookPublisher(String bookPublisher) {
		this.bookPublisher = bookPublisher;
	}
	public String getBookLocation() {
		return bookLocation;
	}
	public void setBookLocation(String bookLocation) {
		this.bookLocation = bookLocation;
	}
	public boolean isValid() {
		return valid;
	}
	
	public void setValid(boolean valid) {
		this.valid = valid;
		
	}
}
