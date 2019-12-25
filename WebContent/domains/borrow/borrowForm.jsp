<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*" %>
<%


  if(session.getAttribute("currentSessionUser")==null)
      response.sendRedirect("/Library/librarianLogin.jsp");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dang Anum Library</title>
	<link rel="icon" href="/Library/img/library.png">
<script src="/Library/jquery.js"></script>
<script>
var counter = 0;
$(document).ready(function(){

$("#add").click(function (e){
event.preventDefault()
if(counter < ${librarian.maxBorrow - 1}){
counter++;
$('#items').append('<div class="items"><select name="bookISBN" placeholder="Book Title" class="js-example-basic-single border w-75 p-3" required> <option disabled value="" selected> -- Select Book -- </option > <c:forEach items="${books}" var="book"><c:choose><c:when test="${book.bookCurrentQuantity > 0 }">'+
		'<option value="<c:out value="${book.bookISBN}" />"><c:out value="${book.bookName}" />   (ISBN : <c:out value="${book.bookISBN}" />)</option> </c:when>	<c:otherwise><option disabled="disabled" value="<c:out value="${book.bookISBN}" />"><c:out value="${book.bookName}" />   (ISBN : <c:out value="${book.bookISBN}" />) Current Quantity = 0</option>'+
		'</c:otherwise></c:choose></c:forEach></select>' + 
		' <input type="button" value=" Delete" class="btn btn-outline-danger btn-sm" id="delete"></div>');
}

$('.js-example-basic-single').select2();  


});

$('body').on('click','#delete',function (e){
	counter--;
	$(this).parent('div').remove();
});

});

</script>
</head>
	<link href="/Library/css/select2.min.css" rel="stylesheet" />
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="/Library/css/bootstrap.min.css">
    <!-- Custom CSS for header -->
    <link rel="stylesheet" href="/Library/css/style3.css">
    <!-- Scrollbar Custom CSS -->
    <link rel="stylesheet" href="/Library/css/jquery.mCustomScrollbar.min.css">
    <!-- Font Awesome JS -->
    <link rel="stylesheet" href="/Library/fontawesome/js/all.min.js" >
 	<link rel="stylesheet" href="/Library/fontawesome/css/all.min.css" >
<body>
<%	Integer libID = (Integer)session.getAttribute("currentSessionUser");%>

	<div class="wrapper">
    <!-- Page Sidebar  -->
        <jsp:include page="header.jsp" />

        <!-- Page Content  -->
        <div id="content">
        <!-- Page Top Navigation  -->
		<jsp:include page="navigation.jsp" />
			<!-- Default form login -->
		<section id="cover">
    		<div id="cover-caption">
       			 <div id="container" class="container">
          			  <div class="row text-black">
               			 <div class="col-sm-6 offset-sm-3 text-center">
                 			   <h1 class="display-5">Borrow Form</h1>
                 			   <br/>
                   				 <div class="info-form">
                       				 <form method="post" action="/Library/BorrowController" class="form-inlin justify-content-center">
                          			  <div class="form-group">
                          			  <br/>
                          			  <h3 class="text-left">Librarian ID: </h3>
                          			  <input type="text"  name="libID" class="form-control border"  value="<c:out value="<%=libID %>"/>" readonly>
									</div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<div class="text-left">
                          			  	<h3 class="text-left ">Patron ID :</h3><select name="patronID" class="js-example-basic-single form-control border" required>
											<option disabled value="" selected> -- Select Patron -- </option >
											<c:forEach items="${patrons}" var="patron">
											<c:forEach items="${students}" var="student">
												<c:choose>
													<c:when test="${patron.patronID == student.patronID && student.status == 'Studying'}">
													<option value="<c:out value="${patron.patronID}" />"><c:out value="${patron.patronName}" />   (ID : <c:out value="${patron.patronID}" />) [Student]</option>
													</c:when>
												</c:choose>
											</c:forEach>
											<c:forEach items="${teachers}" var="teacher">
												<c:choose>
													<c:when test="${patron.patronID == teacher.patronID}">
													<option value="<c:out value="${patron.patronID}" />"><c:out value="${patron.patronName}" />   (ID : <c:out value="${patron.patronID}" />) [Teacher]</option>
													</c:when>
												</c:choose>
											</c:forEach>
											
											</c:forEach>
											</select>
										</div>
                           			 </div>
                          			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Book Title :</h3>
                          			  	<div class="text-left">
                          			  	<div id="items">
										<div class="items">
										<select name="bookISBN" class="js-example-basic-single border w-75 p-3" required>
										<option disabled value="" selected> -- Select Book -- </option >
										<c:forEach items="${books}" var="book">
										<c:choose>
										<c:when test="${book.bookCurrentQuantity > 0 }">
										<option value="<c:out value="${book.bookISBN}" />"><c:out value="${book.bookName}" />   (ISBN : <c:out value="${book.bookISBN}" />)</option>
										</c:when>
										<c:otherwise>
										<option disabled="disabled" value="<c:out value="${book.bookISBN}" />"><c:out value="${book.bookName}" />   (ISBN : <c:out value="${book.bookISBN}" />) Current Quantity = 0</option>
										</c:otherwise>
										</c:choose>
										</c:forEach>
										</select>
										</div>
										</div><br/><br/><p>Maximum <c:out value="${librarian.maxBorrow}"/> Books</p>
										
										<button type="button" value="Add Book" id="add" class="btn btn-outline-secondary btn-sm" role="button"> 
                       				 Add Book
                    				</button>
										</div>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Expected Return Date :</h3>
                              			<input class="form-control border" name="expectedReturnDate" value="${borrowBook.expectedReturnDate}" readonly>
                           			 </div>
                           			 <br/>
                           			 <button type="submit" name="action" value="Borrow" class="btn btn-success ">Submit</button>
									</form>
                    			</div>
                    			<br>

							
                		</div>
            		</div>
        		</div>
    		</div>
</section>
</div>
</div>

	<div class="overlay"></div>
	<input type="hidden"  id="successBorrow" value="${successBorrow}">
	<input type="hidden"  id="duplicateBook" value="${duplicateBook}">
	<input type="hidden"  id="notReturnYet" value="${notReturnYet}">
	<input type="hidden"  id="Book" value="${Book}">
	<input id="successUpdate" type="hidden" value="${successUpdate}">
	


</body>

    <!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="/Library/js/jquery-3.3.1.slim.min.js"></script>
    <!-- Popper.JS -->
    <script src="/Library/js/popper.min.js"> </script>
    <!-- Bootstrap JS -->
	<script src="/Library/js/bootstrap.min.js"></script>  
	<!-- Bootstrap Bundle JS -->
	<script src="/Library/js/bootstrap.bundle.min.js"></script>  
	<!-- jQuery Custom Scroller CDN -->
    <script src="/Library/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<!-- SweetAlert.JS -->
	<script src="/Library/js/sweetalert.min.js"></script>
	<script src="/Library/js/select2.min.js"></script>
<script>
$('.js-example-basic-single').select2();
$(document).ready(function() {
	if($('#successBorrow').val() == "true"){
		swal("Borrow Success! ", "", "success");
		}
	else if($('#duplicateBook').val() == "true"){
		swal("Error! ", "Cannot borrow same book", "error");
		}
	else if($('#notReturnYet').val() == "true"){
		swal("Error! ", "Patron doesn't return Book: (ISBN: ${Book}) yet", "error");
		}
	else if($('#successUpdate').val() == "true"){
		swal("Update Success! ", "", "success");
		}
    $('.autocomplete').select2();
    $("#sidebar").mCustomScrollbar({
        theme: "minimal"
    });

    $('#dismiss, .overlay').on('click', function () {
        $('#sidebar').removeClass('active');
        $('.overlay').removeClass('active');
    });

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').addClass('active');
        $('.overlay').addClass('active');
        $('.collapse.in').toggleClass('in');
        $('a[aria-expanded=true]').attr('aria-expanded', 'false');
    });    
          		        		
});
</script>
</html>