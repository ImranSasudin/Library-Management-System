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
 	<!-- DataTable CSS -->
 	<link rel="stylesheet" href="/Library/css/datatables-select.min.css">
 	<link rel="stylesheet" href="/Library/css/datatables.min.css">
 	
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
               			 <div class="col-lg-8 offset-sm-2 text-center">
                 			   <h1 class="display-5">List Patrons</h1>
                 			   <div class="text-center">
                 			   <select class="browser-default custom-select custom-select-lg mb-3" id="category" onchange="listPatron()">
								 <option disabled selected value> -- Select Category -- </option >
									<option value="Student">Student</option>
									<option value="Teacher">Teacher</option>
								</select>
                 			   </div>
                 			   <div class="text-left">
                 			   </div>
                   				 <div class="info-form">
                       				 <form  class="form-inlin justify-content-center">
                          			  <div style="display:none;" id="ListTeacher">
                          			  <table id="dtBasicExample" class="table table-striped table-bordered" cellspacing="0" width="100%">
  										<thead>
   										 <tr>
      										<th>ID</th>
							                <th>Name</th>
							                <th>Specialization</th>
							                <th>Table Number</th>
							                <th>Update</th>
							                <th>Delete</th>   
      										
   										 </tr>
  										</thead>
  										<tbody>
  											<c:forEach items="${teachers}" var="teacher">
    											<tr>
													<td><a class="text-primary" href="/Library/PatronController?action=viewPatron&patronID=${teacher.patronID}&type=Teacher"><c:out value="${teacher.patronID}" /></a></td>
								                    <td><c:out value="${teacher.patronName}" /></td>
								                    <td><c:out value="${teacher.specialization}" /></td>
								                    <td><c:out value="${teacher.tableNum}" /></td>
												 	<td><a href="/Library/PatronController?action=updateTeacher&patronID=${teacher.patronID}"><i class="fas fa-edit"></i></a></td>
												 	<td><a href="/Library/PatronController?action=deleteTeacher&patronID=${teacher.patronID}"><i class="fas fa-trash-alt"></i></a></td>
												</tr>
											 </c:forEach>
    
								    </tbody>
								    </table>
                           			 </div>
                           			 <div style="display:none;" id="ListStudent">
                           			 <table id="dtBasicExample2" class="table table-striped table-bordered" cellspacing="0" width="100%">
  										<thead>
   										 <tr>
      										<th>ID</th>
							                <th>Name</th>
							                <th>Register Date</th>
							                <th>Status</th>
							                <th>Form</th>
							                <th>Update</th>
							                <th>Delete</th>   
      										
   										 </tr>
  										</thead>
  										<tbody>
  											<c:forEach items="${students}" var="student">
    											<tr>
													<td><a class="text-primary" href="/Library/PatronController?action=viewPatron&patronID=${student.patronID}&type=Student"><c:out value="${student.patronID}" /></a></td>
								                    <td><c:out value="${student.patronName}" /></td>
								                    <td><c:out value="${student.registerDate}" /></td>
								                    <td><c:out value="${student.status}" /></td>
								                    <td><c:out value="${student.form}" /></td>
								                    <c:choose>
								                    <c:when test="${student.status == 'Graduated'}">
								                    <td>Cannot Update</td>
								                    </c:when>
								                    <c:otherwise>
								                    <td><a href="/Library/PatronController?action=updateStudent&patronID=${student.patronID}"><i class="fas fa-edit"></i></a></td>
								                    </c:otherwise>
								                    </c:choose>
												 	<td><a href="/Library/PatronController?action=deleteStudent&patronID=${student.patronID}"><i class="fas fa-trash-alt"></i></a></td>
												</tr>
											 </c:forEach>
    
								    </tbody>
								    </table>
                           			 </div>
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
	<!-- DataTables.JS -->
	<script src="/Library/js/datatables-select.min.js"></script>
	<script src="/Library/js/datatables.min.js"></script>
	
<script>
function listPatron(){
 	if($('#category').val() == "Student"){
		$('#ListStudent').show();
		$('#ListTeacher').hide();
		
	}
 	else if($('#category').val() == "Teacher"){
		$('#ListStudent').hide();
		$('#ListTeacher').show();
		
	}
 	else{
		$('#ListStudent').hide();
		$('#ListTeacher').hide();
	}
}

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
	$('#dtBasicExample2').DataTable({
		'columnDefs': [ {

			'targets': [5,6], // column or columns numbers

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