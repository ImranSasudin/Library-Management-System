<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Dang Anum Library</title>
	<link rel="icon" href="/Library/img/library.png">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css" >
	<link rel="stylesheet" href="css/lobsterfont.css" >
	<link href="css/mdb.min.css" rel="stylesheet">
	<script src="jquery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap.bundle.min.js"></script>
	<script src="js/sweetalert.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/mdb.min.js"></script>
	<style>
	h1 {
    font-family: Lobster, Monospace;
  	}
  	.couriernew{
  	font-family: Courier New;
  	}
  	.jumbotron{
  	background-color: #e2e2e2;
  	}
  	}
	.modal-login {
		color: #636363;
		width: 350px;
	}
	.modal-login .modal-content {
		padding: 20px;
		border-radius: 5px;
		border: none;
	}
	.modal-login .modal-header {
		border-bottom: none;
		position: relative;
		justify-content: center;
	}
	.modal-login h4 {
		text-align: center;
		font-size: 26px;
	}
	.modal-login  .form-group {
		position: relative;
	}
	.modal-login i {
		position: absolute;
		left: 13px;
		top: 11px;
		font-size: 18px;
	}
	.modal-login .form-control {
		padding-left: 40px;
	}
	.modal-login .form-control:focus {
		border-color: #00ce81;
	}
	.modal-login .form-control, .modal-login .btn {
		min-height: 40px;
		border-radius: 3px; 
	}
	.modal-login .hint-text {
		text-align: center;
		padding-top: 10px;
	}
	.modal-login .close {
        position: absolute;
		top: -5px;
		right: -5px;
	}
	.modal-login .btn {
		background: #00ce81;
		border: none;
		line-height: normal;
	}
	.modal-login .btn:hover, .modal-login .btn:focus {
		background: #00bf78;
	}
	.modal-login .modal-footer {
		background: #ecf0f1;
		border-color: #dee4e7;
		text-align: center;
		margin: 0 -20px -20px;
		border-radius: 5px;
		font-size: 13px;
		justify-content: center;
	}
	.modal-login .modal-footer a {
		color: #999;
	}
	.trigger-btn {
		display: inline-block;
		margin: 100px auto;
	}
	
	</style>
</head>
<body>
<%	String invalidLogin = (String)session.getAttribute("invalidLogin");%>
<div class="container-fluid text-center" >
<div class="jumbotron">
	<img src="img/danganum.png" alt="Dang Anum">
  <h1 class="display-4 ">SMK DANG ANUM LIBRARY</h1>
  <p class="lead"><i>"A room without books is like a body without a soul."</i> <br/> - Marcus Tullius Cicero</p>
</div>
 <p class="my-4 couriernew"><i class="far fa-heart"></i> Dear librarians <i class="far fa-heart"></i> <br/> Please login first <i class="fas fa-sign-in-alt"></i></p>
  <button type="button" class="btn peach-gradient my-4" data-toggle="modal" data-target="#myModal">
    Login
  </button>
<!-- The Modal -->
  <div class="modal fade" id="myModal">
    <div class="modal-dialog modal-dialog-centered modal-md modal-login">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
        <div class="container-fluid text-center">
          <h4 class="modal-title"><img src="img/librarian.png" class="rounded" alt="Librarian"></h4>
        </div>
          <button type="button" class="close" data-dismiss="modal">x</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
         <form action="LibrarianLoginController" method="post">
         
       	<div class="form-group">
     	<i class="fa fa-user"></i><input type="text" class="form-control" name="libID" placeholder="Enter your ID" required="required">
   		</div>
 		 
 		<br/>
  		<div class="form-group">	
     	<i class="fa fa-lock"></i><input type="password" class="form-control" name="password"  placeholder="Enter your password" required="required">    		
  		</div>
		<br/><br/><button type="submit" class="btn btn-lg btn-outline-success waves-effect text-uppercase" name="action" value="Login">login</button>
		</form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
          <button type="button" class="btn btn-danger float-right" data-dismiss="modal">Close</button>
        </div>
        
      </div>
    </div>
  </div>
</div>
<input type="hidden"  id="invalidLogin" value="${invalidLogin}">
<input type="hidden"  id="logoutSuccess" value="${logoutSuccess}">
<input type="hidden"  id="libNameLogout" value="${libNameLogout}">

</body>
<script>
	$(document).ready(function(){
	 	if($('#invalidLogin').val() == "true"){
		swal("Error", "Invalid ID / Password. \nMake sure you enter correct ID & password", "error");
		}
	 	else if($('#logoutSuccess').val() == "true"){
			swal("Logout Success", "Logout Success \n Thank you for your service \nMr./Mrs. ${libNameLogout}", "success");
			}
	 	
	});
</script>
</html>
