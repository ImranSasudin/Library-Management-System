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
                 			   <h1 class="display-5">Book Update</h1>
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
                              			<input type="text" name="bookName" class="form-control border" value="<c:out value="${book.bookName}" />" required>
                           			 </div>
                           			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Price :</h3>
                          			  	<div class="input-group">
                          			  	<span class="input-group-addon"><h3 class="display-6">RM</h3></span>
                          			  	<input type="text" name="bookPrice" class="form-control border" value="<c:out value="${book.bookPrice}" />" pattern="^[0-9]*\.[0-9]{2}$" title="(Example: RM20.00)" required >         
                           			 	</div>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Publisher :</h3>
                          			  	<input type="text" name="bookPublisher" class="form-control border" value="<c:out value="${book.bookPublisher}" />" placeholder="Book Publisher" required> 
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Location :</h3>
                          			  	<input type="text" name="bookLocation" class="form-control border" value="<c:out value="${book.bookLocation}" />"  pattern="[0-9]{3}" title="3 digits number only" required> 
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">If quantity need to change, justify the reason below :</h3><select name="reason" id="reason" onchange="reasonUpdate()" class="form-control border">
                          			  	<option selected value=""></option>
                          			  	<option value="add">Add Book</option>
                          			  	<option value="lost">Lost Book</option>
                          			  	<option value="throw">Throw Away Book (ex: broken)</option>
                          			  	<option value="audit">Audit Process</option>
                          			  	</select>
                           			 </div>
                           			 <div id="deleteReason" style="display:none;">
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">New Quantity :</h3>
                          			  	<input type="text" name="bookQuantity" class="form-control border Qty" value="<c:out value="${book.bookQuantity}" />" placeholder="Location of the book" pattern="^[0-9]*$" title="Number only"> 
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">CurrentQuantity (Automatic Update):</h3>
                          			  	<input type="text" name="bookCurrentQuantity" class="form-control border currentQty" value="<c:out value="${book.bookCurrentQuantity}" />" readonly> 
                           			 </div>
                           			 </div>
                           			 <button type="submit" name="action" value="Update" class="btn btn-success">Update</button>
                           			 <input type="text" hidden name="currentQuantity" value="<c:out value="${book.bookQuantity}" />">
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

function reasonUpdate(){
 	if($('#reason').val() == ""){
		$('#deleteReason').hide();
		$('#deleteReason').find('*').removeAttr('required');

	}
 	else if($('#reason').val() == "audit"){
		$('#deleteReason').show();
		$('#deleteReason').find('*').attr('required','required');
		$('#deleteReason').find('.currentQty').removeAttr('readonly');

	}
 	else {
		$('#deleteReason').show();
		$('#deleteReason').find('*').attr('required','required');
		$('#deleteReason').find('.currentQty').attr('readonly','readonly');
	}
 	
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
