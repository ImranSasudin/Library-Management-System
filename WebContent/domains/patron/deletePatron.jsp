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
 <input type="text" hidden value="${patronType}">
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
               			 <c:choose>
           			  		<c:when test="${patronType == 'Teacher'}">
								<h1 class="display-5">Delete Teacher Comfirmation</h1>
               				</c:when>
               				<c:otherwise>
               					<h1 class="display-5">Delete Student Comfirmation</h1>                            				
               				</c:otherwise>
               			</c:choose>
                 			   <br/>
                   				 <div class="info-form">
                       				 <form method="post" id="myForm" action="/Library/PatronController" class="form-inlin justify-content-center">
                          			  <div class="form-group">
                          			  <h3 class="text-left">ID: </h3>
                          			  <input type="text" name="patronID" class="form-control border" value="<c:out value="${patron.patronID}" />" readonly/>
                           			 </div>
                           			 <div class="form-group">
                           			  <div class="form-group">
                          			  <h3 class="text-left">Name: </h3>
                          			  <input type="text" name="patronName" class="form-control border" value="<c:out value="${patron.patronName}" />" readonly/>
                           			 </div>
                           			 </div>
                           			 <c:choose>
			           			  		<c:when test="${patronType == 'Teacher'}">
			           			  			<input type="text" hidden value="Teacher" name="typePatron">
											 <div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left">Table Number:</h3>
		                              			<input type="text" name="tableNum" class="form-control border" value="${teacher.tableNum}"  readonly>
		                           			 </div>
		                           			  <div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left ">Specialization :</h3>
		                          			  	<input type="text" name="specialization"  class="form-control border" value="${teacher.specialization}" readonly>
			                           		</div>
			               				</c:when>
			               				<c:otherwise>
			               					<input type="text" hidden value="Student" name="typePatron">
			               					<div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left ">Register Date :</h3>
		                              			<input type="text" name="registerDate" class="form-control border" value="${student.registerDate}" readonly/>
		                           			 </div>   
		                           			  <div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left ">Form :</h3>
		                          			  	<input type="text" name="form"  class="form-control border" value="${student.form}" readonly>
			                           		</div>      
			                           		<div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left ">Status :</h3>
		                          			  	<input type="text" name="status"  class="form-control border" value="${student.status}" readonly>
			                           		</div>                           				
			               				</c:otherwise>
			               			</c:choose>
                           			 <input hidden type="text" name="action" value="Delete">
                           			 <button type="submit" class="btn btn-success" onClick="validateForm()">Delete</button>
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