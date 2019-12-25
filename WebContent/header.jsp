<!-- Sidebar  -->
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%	Integer libID = (Integer)session.getAttribute("currentSessionUser");%>
<%	String libRole = (String)session.getAttribute("libRoleSession");%>
<%	String libName = (String)session.getAttribute("libNameSession");%>

        <nav id="sidebar">
            <div id="dismiss">
                <i class="fas fa-arrow-left"></i>
            </div>

            <div class="sidebar-header text-center">
                <h3>Library Management System</h3>
            </div>

            <ul class="list-unstyled components">
                <li>
                	<a href="/Library/index.jsp">Home</a>
                	<a href="LibrarianController?action=viewLibAccount&libID=<c:out value="<%=libID%>"/>">My Account</a>
                	<%if(String.valueOf(session.getAttribute("libRoleSession")).equalsIgnoreCase("Head Librarian")) {%>
                    <a href="#librarianSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Librarian</a>
                    <ul class="collapse list-unstyled" id="librarianSubmenu">
                        <li>
                            <a href="/Library/LibrarianController?action=librarianRegistration">Register new librarian</a>
                        </li>
                        <li>
                            <a href="/Library/LibrarianController?action=listLibrarian">List of librarians</a>
                        </li>
          
                    </ul>
                    <%} %>
                   	<a href="#patronSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Patron</a>
                    <ul class="collapse list-unstyled" id="patronSubmenu">
                        <li>
                            <a href="/Library/domains/patron/PatronRegistration.jsp">Register new patron</a>
                        </li>
                        <li>
                            <a href="/Library/PatronController?action=listPatron">List of patrons</a>
                        </li>
          
                    </ul>
                   	<a href="#bookSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Book</a>
                    <ul class="collapse list-unstyled" id="bookSubmenu">
                        <li>
                            <a href="/Library/domains/book/addBook.jsp">Add new book</a>
                        </li>
                        <li>
                            <a href="/Library/BookController?action=listBook">List of books</a>
                        </li>
          
                    </ul>
                   	<a href="#borrowReturnSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Borrow & Return</a>
                    <ul class="collapse list-unstyled" id="borrowReturnSubmenu">
                        <li>
                            <a href="/Library/BorrowController?action=borrowBook&libID=<c:out value="<%=libID%>"/>">Borrow</a>
                        </li>
                        <li>
                            <a href="/Library/BorrowController?action=searchBorrower">Return</a>
                        </li>
                        <%if(String.valueOf(session.getAttribute("libRoleSession")).equalsIgnoreCase("Head Librarian")) {%>
                         <li>
                            <a href="/Library/BorrowController?action=maxBorrow&libID=<c:out value="<%=libID%>"/>">Edit Max Borrow Book</a>
                        </li>
                        <%} %>
          
                    </ul>
                    <a href="#reportSubmenu" data-toggle="collapse" aria-expanded="false" class="dropdown-toggle">Report</a>
                    <ul class="collapse list-unstyled" id="reportSubmenu">
                        <li>
                            <a href="/Library/ReportController?action=topBorrowers">Top Borrowers</a>
                        </li>
                        <li>
                            <a href="/Library/ReportController?action=borrowedBooks">Borrowed Books</a>
                        </li>
                        <li>
                            <a href="/Library/ReportController?action=returnedBooks">Returned Books</a>
                        </li>
                        <li>
                            <a href="/Library/ReportController?action=graduatedBorrowers">Graduated Borrowers (not return book yet)</a>
                        </li>
                        <li>
                            <a href="/Library/ReportController?action=borrowByForm">Borrows Frequency (by Form)</a>
                        </li>
                    </ul>
                    
                    
            </ul>

            <ul class="list-unstyled CTAs">
                <li>
                    <a href="/Library/LibrarianLoginController?action=Logout" class="download" onclick="return confirm('are you sure?')">Logout</a>
                </li>
               <!--  <li>
                    <a href="https://bootstrapious.com/p/bootstrap-sidebar" class="article">Back to article</a>
                </li> -->
            </ul>
        </nav>