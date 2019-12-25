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
	<link rel="stylesheet" href="/Library/css/bootstrap.min.css">
	<!-- Bootstrap JS -->
	<script src="/Library/js/bootstrap.min.js"></script>
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
                 			   <h1 class="display-5">Update Password</h1>
                   				 <div class="info-form">
                       				 <form method="post" action="/Library/PasswordController" class="form-inlin justify-content-center">
                          			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Current Password :</h3>
                              			<input type="password" name="currentPassword" class="form-control border border-light" required>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">New Password :</h3>
                              			<input type="password" name="newPassword" class="form-control border border-light" required >
                           			 </div>
                           			 <input type="text" name="libID" class="form-control border border-light" value="<c:out value="<%=libID %>" />" hidden readonly>
                           			 <button type="submit" name="operation" value="UpdatePass" class="btn btn-success ">Update Password</button>
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
<input type="hidden"  id="failPass" value="${failPass}">

</div>
</body>
	<!-- jQuery -->
	<script src="/Library/jquery.js"></script>
	
    <!-- jQuery CDN - Slim version (=without AJAX) -->
    <script src="/Library/js/jquery-3.3.1.slim.min.js"></script>
    <!-- Popper.JS -->
    <script src="/Library/js/popper.min.js"> </script>
      
	<!-- Bootstrap Bundle JS -->
	<script src="/Library/js/bootstrap.bundle.min.js"></script>  
	<!-- jQuery Custom Scroller CDN -->
    <script src="/Library/js/jquery.mCustomScrollbar.concat.min.js"></script>
	<!-- SweetAlert.JS -->
	<script src="/Library/js/sweetalert.min.js"></script>
	<script type="text/javascript">
   		
        $(document).ready(function () {
        	if($('#failPass').val() == "true"){
        		swal("Fail", "Wrong Current Password", "error");
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