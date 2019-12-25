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
                 			   <h1 class="display-5">Search Borrower</h1>
                 			   <br/>
                   				 <div class="info-form">
                       				 <form method="post" action="/Library/BorrowController" class="form-inlin justify-content-center">
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<div class="text-left">
                          			  	<h3 class="text-left ">Patron ID :</h3><select name="patronID" placeholder="Patron" class="js-example-basic-single form-control border" required>
											<option value="" disabled selected> -- Select Patron -- </option >
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
                          			 
                           			 <br/>
                           			 <button type="Submit" name="action" value="Search" class="btn btn-success ">Search</button>
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
	

<input type="hidden"  id="successReturn" value="${successReturn}">
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
	if($('#successReturn').val() == "true"){
		swal("Return Success! ", "", "success");
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