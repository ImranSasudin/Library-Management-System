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
<input type="text" hidden value="${listPatron}">
<input type="text" hidden value="${topBorrowers}">
<input type="text" hidden value="${borrowedBooks}">

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
								<h1 class="display-5">View Teacher</h1>
               				</c:when>
               				<c:otherwise>
               					<h1 class="display-5">View Student</h1>                            				
               				</c:otherwise>
               			</c:choose>
                 			   <br/>
                   				 <div class="info-form">
                       				 <form method="post" action="/Library/PatronController" class="form-inlin justify-content-center">
                          			  <div class="form-group">
                          			  <h3 class="text-left">ID: <c:out value="${patron.patronID}" /></h3>
                           			 </div>
                           			 <div class="form-group">
                           			  <div class="form-group">
                          			  <h3 class="text-left">Name: <c:out value="${patron.patronName}" /></h3>
                           			 </div>
                           			 </div>
                           			 <c:choose>
			           			  		<c:when test="${patronType == 'Teacher'}">
											 <div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left">Table Number: ${teacher.tableNum}</h3>
		                           			 </div>
		                           			  <div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left ">Specialization : <c:out value="${teacher.specialization}"/></h3>
			                           		</div>
			               				</c:when>
			               				<c:otherwise>
			               					<div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left ">Register Date : ${student.registerDate}</h3>
		                           			 </div>   
		                           			  <div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left ">Form : <c:out value="${student.form}"/></h3>
		                          			  	
			                           		</div>      
			                           		<div class="form-group">
		                          			  	<br/>
		                          			  	<h3 class="text-left ">Status : <c:out value="${student.status}"/></h3>
			                           		</div>                           				
			               				</c:otherwise>
			               			</c:choose>
                           			 <c:choose>
                           			 	<c:when test="${listPatron == 'true'}">
                           			 		<a href="/Library/PatronController?action=listPatron" class="btn btn-success ">Back To Patron List</a>
                           			 	</c:when>
                           			 	<c:when test="${topBorrowers == 'true'}">
                           			 		<a href="/Library/ReportController?action=topBorrowers" class="btn btn-success ">Back To Top Borrowers</a>
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
<input type="hidden"  id="successUpdate" value="${successUpdate}">

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
	
	if($('#successUpdate').val() == "true"){
		swal("Update Success!", "", "success");
		}
	
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