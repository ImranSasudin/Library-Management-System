<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*" %>
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
                 			   <h1 class="display-5">Return Form</h1>
                 			   <br/>
                   				 <div class="info-form">
                       				 <form method="post" id="myForm" action="/Library/BorrowController" class="form-inlin justify-content-center">
                          			  <div class="form-group">
                          			  <br/>
                          			  <h3 class="text-left">Patron ID: </h3>
                          			  <input type="text"  name="patronID" class="form-control border"  value="<c:out value="${borrow.patronID}"/>" readonly>
									</div>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<div class="text-left">
                          			  	<h3 class="text-left ">Borrowed Book(s) : </h3> 
                          			  	<c:forEach items="${books}" var="borrowedBook"><br/>
											<div class="custom-control custom-checkbox">
											<input type="checkbox" name="bookISBN" value="<c:out value="${borrowedBook.bookISBN}" /> <c:out value="${borrowedBook.fine}"/>" > <c:out value="${borrowedBook.bookName}"/>  (ISBN:<c:out value="${borrowedBook.bookISBN}"/>)	
											<c:choose>
												<c:when test="${borrowedBook.fine != 0}">
												<b style="color:red">FINE: RM<c:out value="${borrowedBook.fine}"/> [<c:out value="${borrowedBook.count}"/> Days Late]</b>   
												</c:when>
											</c:choose>
											
											</div>
										</c:forEach>
										</div>
                           			 </div>
                          			 <input id=total hidden>
                           			 <div class="form-group">
                          			  	<br/>
                          			  	<h3 class="text-left ">Return Date :</h3>
                              			<input class="form-control border" value="<%= (new java.util.Date()).toLocaleString()%>" readonly>
                           			 </div>
                           			 <br/>
                           			 <input name="action" hidden value="Return">
                           			 <button type="submit" name="" value="Return" class="btn btn-success " onClick="validateForm()">Submit</button>
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
$('input:checkbox').change(function ()
		{
	      var total = 0;
	      $('input:checkbox:checked').each(function(){
			var res = parseFloat($(this).val().split(" ")[1]);
	       total += res;
	      });   
	      $("#total").val(total.toFixed(2));
		});

function validateForm() {
   
   event.preventDefault(); // prevent form submit
    var form = document.forms["myForm"]; // storing the form
    swal({
           title: "Total Fine is RM" + $("#total").val(),
           text: "Click Ok if fine has been paid",
           icon: "warning",
           buttons: true,
           dangerMode: true,
         })
        .then((willDelete) => {
             if (willDelete) {
                   form.submit();
             } else {
                    swal("Cancelled");
         }
      });
}
$(document).ready(function() {
	
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