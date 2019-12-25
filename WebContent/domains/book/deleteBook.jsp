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
</head>
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
<body>

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
                 			   <h1 class="display-5">Book Delete Confirmation</h1>
                   				 <div class="info-form">
                       				 <form id="myForm" method="post" action="/Library/BookController" class="form-inlin justify-content-center">
                          			   <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">ISBN :</h3>
                              			<input type="text" name="bookISBN" class="form-control border" value="<c:out value="${book.bookISBN}" />" readonly>
                           			 </div>
                          			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Name :</h3>
                              			<input type="text" name="bookName" class="form-control border" value="<c:out value="${book.bookName}" />" readonly>
                           			 </div>
                           			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Price :</h3>
                          			  	<input type="text" name="bookPrice" class="form-control border" value="RM<c:out value="${book.bookPrice}" />" readonly>         
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Publisher :</h3>
                          			  	<input type="text" name="bookPublisher" class="form-control border" value="<c:out value="${book.bookPublisher}" />" readonly> 
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Location :</h3>
                          			  	<input type="text" name="bookLocation" class="form-control border" value="<c:out value="${book.bookLocation}" />" readonly> 
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Quantity :</h3>
                          			  	<input type="text" name="bookQuantity" class="form-control border" value="<c:out value="${book.bookQuantity}" />" readonly> 
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">CurrentQuantity :</h3>
                          			  	<input type="text" name="bookCurrentQuantity" class="form-control border" value="<c:out value="${book.bookCurrentQuantity}" />" readonly> 
                           			 </div>
                           			<input hidden type="text" value="Delete" name="action">
                           			 <button type="submit" name="action" value="Delete" class="btn btn-success" onClick="validateForm()" >Delete</button>
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
function validateForm() {
	
    event.preventDefault(); // prevent form submit
    var form = document.forms["myForm"]; // storing the form
    swal({
           title: "Are you sure?",
           text: "Once deleted, you will not be able to recover this book!",
           icon: "warning",
           buttons: true,
           dangerMode: true,
         })
        .then((willDelete) => {
             if (willDelete) {
                   form.submit();
             } else {
                    swal("This book is safe!");
         }
      });
}
$(document).ready(function() {
	
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