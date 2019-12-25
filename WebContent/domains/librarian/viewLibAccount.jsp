<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<%	Integer libID = (Integer)session.getAttribute("currentSessionUser");%>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<!-- Bootstrap JS -->
	<script src="js/bootstrap.min.js"></script>
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
                 			   <h1 class="display-5">My Account</h1>
                   				 <div class="info-form">
                       				 <form action="" class="form-inlin justify-content-center">
                          			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">ID :</h3>
                              			<input type="text" class="form-control border border-light" value="<c:out value="<%=libID %>" />" readonly>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Name :</h3>
                              			<input type="text" class="form-control border border-light" value="${librarian.libName}" readonly>
                           			 </div>
                                     <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Manager :</h3>
                          			  	<c:choose>
                          			  	 	<c:when test="${librarian.managerID == null || librarian.managerID == 0}">
                          			  			<input type="text" class="text-left form-control border border-light" value="No Manager" readonly>
                          			  		</c:when>
                          			  	<c:otherwise>
                          			  		<c:forEach items="${librarians}" var="headLib">
                          			  			<c:choose>
                          			  				<c:when test="${librarian.managerID == headLib.libID}">
                          			  					<input type="text" class="text-left form-control border border-light" value="<c:out value="${headLib.libName}"/> (ID : <c:out value="${headLib.libID}" />)"  readonly>
                          			  				</c:when>
                          			  			</c:choose>
                          			  		</c:forEach>
                          			  	</c:otherwise>
                          			  	</c:choose>			  	
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Role :</h3>
                              			<input type="text" class="form-control border border-light" value="${librarian.libRole}" readonly>
                           			 </div>
                           			 <a href="LibrarianController?action=updateLibAccount&libID=<c:out value="<%=libID %>"/>" class="btn btn-success ">Update</a>
                        			</form>
                    			</div>
                    			<br>

                    			<!--  <a href="#nav-main" class="btn btn-outline-secondary btn-sm" role="button">
                       			 More
                    			</a>-->
                		</div>
            		</div>
        		</div>
    		</div>
</section>
</div>
</div>
<input type="hidden"  id="successUpdate" value="${successUpdate}">
<input type="hidden"  id="successPass" value="${successPass}">


    <div class="overlay"></div>
</body>
	<!-- jQuery -->
	<script src="jquery.js"></script>
	
    <!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="js/jquery-3.3.1.slim.min.js"></script>
    <!-- Popper.JS -->
    <script src="js/popper.min.js"> </script>
      
	<!-- Bootstrap Bundle JS -->
	<script src="js/bootstrap.bundle.min.js"></script>  
	<!-- jQuery Custom Scroller CDN -->
    <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
	<!-- SweetAlert.JS -->
	<script src="js/sweetalert.min.js"></script>
	<script type="text/javascript">
		if($('#successPass').val() == "true"){
		swal("Success", "Password Updated!", "success");
		}
   		if($('#successUpdate').val() == "true"){
		swal("Successfully Update", "Here is your updated account details", "success");
		}
        $(document).ready(function () {
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