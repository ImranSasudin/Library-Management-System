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
                 			   <h1 class="display-5">Patron Registration</h1>
                 			   </br>
                   				 <div class="info-form">
                       				 <form method="post" action="/Library/PatronController" class="form-inlin justify-content-center">
                          			  <div class="form-group">
                          			  <h3 class="text-left">Category: </h3><br/><select name="typePatron" id="category" onchange="patronForm()" class="form-control border" required>
										<option disabled value="" selected> -- Select Category -- </option >
										<option value="Student">Student</option>
										<option value="Teacher">Teacher</option>
										</select>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">IC Number :</h3>
                              			<input type="text" name="patronID" class="form-control border" placeholder="IC number (without dashes '-')" pattern="^([0-9]{12})$" title="IC number must be a 12 digit number without dashes('-')'" required>
                           			 </div>
                          			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Name :</h3>
                              			<input type="text" name="patronName" class="form-control border" placeholder="Name" pattern="^[_A-z]*((-|\s)*[_A-z])*$" title="Name cannot contain any special character or number" required>
                           			 </div>
                           			 <div style="display:none;" id="TeacherForm">
                           			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Table Number:</h3>
                              			<input type="text" name="tableNum" class="form-control border" placeholder="Example : A001" pattern="[A-Z]{1}[0-9]{3}" title="Table number must start with an letter followed by 3 numbers (ex: A001)" required>
                           			 </div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Specialization: </h3><select name="specialization"  class="form-control border" required>
                          			  	<option disabled selected value=""> -- Select Specialization -- </option>
                          			  	<option value="B.Melayu">B.Melayu</option>
										<option value="B.Inggeris">B.Inggeris</option>
										<option value="Sejarah">Sejarah</option>
										<option value="Geografi">Geografi</option>
										<option value="Matematik">Matematik</option>
										</select>
                           			 </div>
                           			 </div>
                           			 <div style="display:none;" id="StudentForm">
                           			  <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Register Date :</h3>
                          			  <input type="date" name="registerDate" class="form-control border" placeholder="Date" required> 
                           			 </div>
                                     
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left">Form :</h3>                         			  	
                          			  	<select name="form" class="form-control border" required>
                          			  	<option disabled selected value  > -- Select Form -- </option>
										<option value="1">1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
										<option value="5">5</option>
										</select>
                           			 </div>
                           			 </div>
                           			 <button type="submit" name="action" value="Register" class="btn btn-success ">Register</button>
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
	<input type="text" hidden value="${successRegister}" id="successRegister">
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

function patronForm(){
 	if($('#category').val() == "Student"){
		$('#StudentForm').show();
		$('#TeacherForm').hide();
		$('#TeacherForm').find('*').removeAttr('required');
		$('#StudentForm').find('*').attr('required','required');
	}
 	else if($('#category').val() == "Teacher"){
		$('#StudentForm').hide();
		$('#TeacherForm').show();
		$('#StudentForm').find('*').removeAttr('required');
		$('#TeacherForm').find('*').attr('required','required');

	}
 	else{
		$('#StudentForm').hide();
		$('#TeacherForm').hide();
	}
}
$(document).ready(function() {
	if($('#successRegister').val() == "true"){
		swal("Register Success!", "", "success");
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