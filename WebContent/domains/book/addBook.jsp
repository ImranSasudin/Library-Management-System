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
</head>
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
                 			   <h1 class="display-5">Add New Book</h1>
                 			   <br/>
                   				 <div class="info-form">
                       				 <form method="post" action="/Library/BookController" class="form-inlin justify-content-center">
                          			  <div class="form-group">
                          			  <br/>
                          			  <h3 class="text-left">ISBN: </h3>
                          			  <input type="text"  name="bookISBN" placeholder="Enter ISBN (10 digits or 13 digits without '-' and space)" class="form-control border" pattern="^([0-9]{13}||[0-9]{10})$" title="ISBN Number must be either 10 or 13 digits number without (-) and space" required>
									</div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Name :</h3>
                              			<input type="text" name="bookName" class="form-control border" placeholder="Book Title" required>
                           			 </div>
                          			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Price :</h3>
                          			  	<div class="input-group">
                          			  	<span class="input-group-addon"><h3 class="display-6">RM</h3></span>
                              			<input type="text" name="bookPrice" class="form-control border" placeholder="Book Price (ex: RM10.00)" pattern="^[0-9]*\.[0-9]{2}$" title="(Example: RM20.00)" required>
                           				</div>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Publisher :</h3>
                              			<input type="text" name="bookPublisher" class="form-control border" placeholder="Book Publisher" required>
                           			 </div>
                           			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Location :</h3>
                          			  <input type="text" name="bookLocation" class="form-control border" placeholder="Location of the book (3 digits number ex: 100)" pattern="[0-9]{3}" title="3 digits number only" required> 
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Quantity: </h3>
                          			  	<input type="text" name="bookQuantity" class="form-control border" pattern="^[0-9]*$" title="Number only" placeholder="Quantity" required> 
                           			 </div>
                           			 <button type="submit" name="action" value="Add" class="btn btn-success ">Add</button>
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
	<input type="hidden"  id="successAdd" value="${successAdd}">

</body>
	<!-- jQuery -->
	<script src="/Library/jquery.js"></script>
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


$(document).ready(function() {
	if($('#successAdd').val() == "true"){
		swal("Add Book Success! ", "", "success");
		}
	else if($('#successAdd').val() == "false"){
		swal("ISBN already exist", "", "error");
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