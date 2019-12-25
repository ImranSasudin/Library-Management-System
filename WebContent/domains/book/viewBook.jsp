<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	<link href="css/select2.min.css" rel="stylesheet" />
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Custom CSS for header -->
    <link rel="stylesheet" href="css/style3.css">
    <!-- Scrollbar Custom CSS -->
    <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
    <!-- Font Awesome JS -->
    <link rel="stylesheet" href="fontawesome/js/all.min.js" >
 	<link rel="stylesheet" href="fontawesome/css/all.min.css" >
</head>
<body>
<input type="text" hidden value="${listBook}">
<input type="text" hidden value="${borrowedBooks}">
<input type="text" hidden value="${graduatedBorrowers}">


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
                 			   <h1 class="display-5">View Book</h1>
                   				 <div class="info-form">
                       				 <form id="myForm" method="post" action="/Library/BookController" class="form-inlin justify-content-center">
                          			   <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">ISBN : <c:out value="${book.bookISBN}" /></h3>
                           			 </div>
                          			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Name : <c:out value="${book.bookName}" /></h3>
                           			 </div>
                           			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Price : RM<c:out value="${book.bookPrice}" /></h3>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Publisher : <c:out value="${book.bookPublisher}" /></h3>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Location : <c:out value="${book.bookLocation}" /></h3>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Quantity : <c:out value="${book.bookQuantity}" /></h3>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">CurrentQuantity : <c:out value="${book.bookCurrentQuantity}" /></h3>
                           			 </div>
                           			 <c:choose>
                           			 	<c:when test="${listBook == 'true'}">
                           			 		<a href="/Library/BookController?action=listBook" class="btn btn-success ">Back To Book List</a>
                           			 	</c:when>
                           			 	<c:when test="${borrowedBooks == 'true'}">
                           			 		<a href="/Library/ReportController?action=borrowedBooks" class="btn btn-success ">Back To Borrowed Books</a>
                           			 	</c:when>
                           			 	<c:when test="${graduatedBorrowers == 'true'}">
                           			 		<a href="/Library/ReportController?action=graduatedBorrowers" class="btn btn-success ">Back To Graduated Borrowers</a>
                           			 	</c:when>
                           			 	<c:when test="${returnedBooks == 'true'}">
                           			 		<a href="/Library/ReportController?action=returnedBooks" class="btn btn-success ">Back To Returned Books</a>
                           			 	</c:when>
                           			 </c:choose>
                           			 
                           			 
                           			 <input type="text" hidden id="successUpdate" value="${successUpdate}">
                        			</form>
                    			</div>
                    			<br>

							<!--<a href="#nav-main" class="btn btn-outline-secondary btn-sm" role="button"> 
                       			 More
                    			</a>-->
                		</div>
            		</div>
        		</div>
    		</div>
</section>
</div>
</div>
										
	<div class="overlay"></div>

</body>
	<!-- jQuery -->
	<script src="jquery.js"></script>
	
    <!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="js/jquery-3.3.1.slim.min.js"></script>
    <!-- Popper.JS -->
    <script src="js/popper.min.js"> </script>
    <!-- Bootstrap JS -->
	<script src="js/bootstrap.min.js"></script>  
	<!-- Bootstrap Bundle JS -->
	<script src="js/bootstrap.bundle.min.js"></script>  
	<!-- jQuery Custom Scroller CDN -->
    <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
	<!-- SweetAlert.JS -->
	<script src="js/sweetalert.min.js"></script>
	<script src="js/select2.min.js"></script>
<script>

if($('#successUpdate').val() == "true"){
	swal("Update Success!", "Current Book Quantity for ISBN: ${book.bookISBN} is ${book.bookCurrentQuantity} ", "success");
	}

$(document).ready(function() {
	
		
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