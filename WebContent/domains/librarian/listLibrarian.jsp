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
 	<!-- DataTable CSS -->
 	<link rel="stylesheet" href="css/datatables-select.min.css">
 	<link rel="stylesheet" href="css/datatables.min.css">
 	
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
               			 <div class="col-lg-8 offset-sm-2 text-center">
                 			   <h1 class="display-5">List Librarian</h1>
                 			   <div class="text-left">
                 			   </div>
                   				 <div class="info-form">
                       				 <form method="" action="/Library/LibrarianController" class="form-inlin justify-content-center">
                          			  <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
  										<thead>
   										 <tr>
      										<th class="th-sm">ID</th>
     										 <th class="th-sm">Name</th>
     										 <th class="th-sm">Manager Name</th>
      										<th class="th-sm">Role</th>    
      										 <th class="">Update </th>
      										 <th class="">Delete</th>    
      										
   										 </tr>
  										</thead>
  										<tbody>
  											<c:forEach items="${librarians}" var="librarian">
    											<tr>
													<td><a class="text-primary" href="/Library/LibrarianController?action=viewLibrarian&libID=${librarian.libID}"><c:out value="${librarian.libID}" /></a></td>
													<td><c:out value="${librarian.libName}" /></td>
													
													<c:choose>
			                          			  	 	<c:when test="${librarian.managerID == null || librarian.managerID == 0}">
			                          			  			<td><c:out value="No Manager" /></td>
			                          			  		</c:when>
			                          			  	<c:otherwise>
			                          			  		<c:forEach items="${librarians}" var="headLib">
			                          			  			<c:choose>
			                          			  				<c:when test="${librarian.managerID == headLib.libID}">
			                          			  					<td><c:out value="${headLib.libName}"/>   (ID : <c:out value="${headLib.libID}" />)  </td>
			                          			  				</c:when>
			                          			  			</c:choose>
			                          			  		</c:forEach>
			                          			  	</c:otherwise>
			                          			  	</c:choose>		
                          			  	
												 	<td><c:out value="${librarian.libRole}" /></td>
												 	<td><a href="/Library/LibrarianController?action=updateLibrarian&libID=${librarian.libID}"><i class="fas fa-edit"></i></a></td>
												 	<td><a href="/Library/LibrarianDeleteController?action=delete&libID=${librarian.libID}"><i class="fas fa-trash-alt"></i></a></td>
												</tr>
											 </c:forEach>
    
								    </tbody>
								    </table>
                           			 
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
    <input type="hidden"  id="successDelete" value="${successDelete}">
    
    
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
	<!-- DataTables.JS -->
	<script src="js/datatables-select.min.js"></script>
	<script src="js/datatables.min.js"></script>
	
<script>
$(document).ready(function() {
	
	
	if($('#successDelete').val() == "true"){
		swal("Delete Success!", "", "success");
	}
	
	$('#dtBasicExample').DataTable({
	'columnDefs': [ {

		'targets': [4,5], // column or columns numbers

		'orderable': false,  // set orderable for selected columns

		}]
	});
	

	$('.dataTables_length').addClass('bs-select');
	
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