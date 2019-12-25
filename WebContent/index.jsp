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
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <title>Dang Anum Library</title>
	<link rel="icon" href="/Library/img/library.png">
    <!-- Bootstrap CSS CDN -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Our Custom CSS -->
    <link rel="stylesheet" href="css/style3.css">
    <!-- Scrollbar Custom CSS -->
    <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
    <!-- Font Awesome JS -->
    <link rel="stylesheet" href="fontawesome/js/all.min.js" >
 	<link rel="stylesheet" href="fontawesome/css/all.min.css" >
 	
</head>

<body>
<%	Integer libID = (Integer)session.getAttribute("currentSessionUser");%>
<%	String libRole = (String)session.getAttribute("libRoleSession");%>
<%	String libName = (String)session.getAttribute("libNameSession");%>

    <div class="wrapper">
    <!-- Page Sidebar  -->
        <jsp:include page="header.jsp" />

        <!-- Page Content  -->
        <div id="content">
        <!-- Page Top Navigation  -->
		<jsp:include page="navigation.jsp" />
			
			<div class="text-center">
            <img class="rounded mx-auto d-block img-responsive" src="img/danganum.png" alt="Dang Anum">
            <h2 class="font-weight-bold">Misi</h2>
			<p>SMK Dang Anum terus mengekalkan kegemilangan di peringkat kebangsaan.</p>

            <div class="line"></div>

            <h2 class="font-weight-bold">Visi</h2>
			<p>Memberi pendidikan berkualiti bagi melahirkan pelajar yang berketerampilan dan berakhlak mulia.</p>
			<p>Meningkatkan budaya ilmu dan menanamkan kesedaran kepada pelajar tentang kepentingan ilmu dalam meningkatkan martabat insan.</p>
			<p>Meningkatkan kesedaran tentang pengisian masa dengan aktiviti-aktiviti yang berfaedah..</p>
			<p>Menanam semangat bekerja tinggi di kalangan warga sekolah.</p>
			<p>Mewujudkan hubungan erat di kalangan warga sekolah - pelajar, guru, staf sokongan dan pentadbir dengan ibu bapa dan masyarakat bagi mencapai kegemilangan.</p>
			<p>Memantapkan budaya kebesihan, keceriaan, kekemasan, keselamatan, kesihatan dan bermaklumat (5K, 1 B).</p>
			<p>Memberi bimbingan dan perhatian kepada semua pelajar supaya proses pendidikan berjalan secara adil dan berkesan.</p>
			<p>Meningkatkan penghayatan nilai-nilai keagamaan dan nilai-nilai murni di kalangan pelajar SMK Dang Anum sebagai satu cara hidup yang syumul.</p>
			
            <div class="line"></div>

            <h2 class="font-weight-bold">Etos</h2>
			<p>Dikelilingi dengan pokok-pokok bunga yang beraneka warna dan jenis, memberikan satu persekitaran yang harmoni dan tenteram bagi aktiviti pengajaran dan pembelajaran. Sekolah dalam taman menjadi etos SMK Dang Anum.</p>
           	<p>Sekolah Ceria Harmoni - Pelajar dan guru sentiasa dalam keadaan ceria serta persekitaran sekolah , bilik darjah sentiasa dalam suasana yang kondusif dan harmoni.</p>
            
            <div class="line"></div>

            <h2 class="font-weight-bold">Falsafah</h2>
			<p>Menginsafi bahawa Allah tidak mengubah nasib sesuatu kaum melainkan kaum itu berusaha mengubahnya.</p>
			<p>Menyedari hakikat itu maka seluruh warga SMK Dang Anum mesti digembeling dengan sebaik cara dan seberkesan mungkin dan bahawa kunci kepada kejayaan ialah perancangan penyusunan, pengamatan ilmu, penilaian kendiri, sains dan teknologi</p>
			<p>Meyakini bahawa manusia tidak dapat hidup dengan kemajuan kebendaan semata-mata tanpa perikemanusiaan, peradaban dan keimanan, maka ke arah itu SMK Dang Anum akan membudayakan sekalian pelajar dan kakitangan sekolah.</p>
        	
        	<div class="line"></div>
        	
        	<h2 class="font-weight-bold">Tagline</h2>
            <p class="font-italic">"Akademik Cemerlang Ditunjangi, Sahsiah Terpuji Diteladani"</p>
            </div>
        </div>
    </div>
	<input type="hidden"  id="successLogin" value="${successLogin}">
    <div class="overlay"></div>
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
    <script>
    
   		if($('#successLogin').val() == "true"){
		swal("Successfully Login", "Welcome <%=libName%> (ID: <%=libID%>) [<%=libRole%>] ", "success");
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
        $('#logout').click(function(e){
            e.preventDefault();
            var link = $(this).attr('href');

            swal({
                title: "Are you sure?",
                text: "By clicking 'OK' you will be redirected to the link.",
                type: "warning",
                showCancelButton: true
            },
            function(){
                window.location.href = link;
            });
        });
    </script>
</body>

</html>