<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
     <%

  if((Integer)session.getAttribute("currentSessionUser") == null )
	    response.sendRedirect("/Library/librarianLogin.jsp");
	else if(!String.valueOf(session.getAttribute("libRoleSession")).equalsIgnoreCase("Head Librarian"))
	    response.sendRedirect("/Library/index.jsp");
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
                 			   <h1 class="display-5">Update Librarian</h1>
                   				 <div class="info-form">
                       				 <form method="post" name="myForm" action="/Library/LibrarianDeleteController" class="form-inlin justify-content-center">
                          			   <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">ID :</h3>
                              			<input type="text" name="libID" class="form-control border" value="<c:out value="${librarian.libID}"/>" readonly>
                           			 </div>
                          			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Name :</h3>
                              			<input type="text" name="libName" class="form-control border" value="<c:out value="${librarian.libName}"/>" readonly>
                           			 </div>
                           			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Manager ID :</h3>
                          			  	 <input type="text" name="managerID" class="form-control border" value="<c:out value="${librarian.managerID}"/>" readonly>             
                           			 </div>
                                     
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Role :</h3>
                          			  	<input type="text" name="libRole" class="form-control border" value="<c:out value="${librarian.libRole}"/>" readonly>
                           			 </div>
                           			 <input hidden type="text" name="operation" value="Delete">
                           			 <input type="Submit" name="operation" value="Delete" class="btn btn-success" onClick="validateForm()">
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
										
	<div class="overlay"></div>

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
function validateForm() {
	
    event.preventDefault(); // prevent form submit
    var form = document.forms["myForm"]; // storing the form
    swal({
           title: "Are you sure?",
           text: "Once deleted, you will not be able to recover this account!",
           icon: "warning",
           buttons: true,
           dangerMode: true,
         })
        .then((willDelete) => {
             if (willDelete) {
                   form.submit();
             } else {
                    swal("This account is safe!");
         }
      });
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