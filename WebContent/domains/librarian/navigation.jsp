<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%	Integer libID = (Integer)session.getAttribute("currentSessionUser");%>
<%	String libRole = (String)session.getAttribute("libRoleSession");%>
<%	String libName = (String)session.getAttribute("libNameSession");%>
 <%
 
  if((Integer)session.getAttribute("currentSessionUser") == null )
      response.sendRedirect("/Library/librarianLogin.jsp");
  else if(!String.valueOf(session.getAttribute("libRoleSession")).equalsIgnoreCase("Head Librarian"))
      response.sendRedirect("/Library/index.jsp");

%> 

<nav class="navbar navbar-expand-lg navbar-light bg-light">
                <div class="container-fluid">

                    <button type="button" id="sidebarCollapse" class="btn btn-info">
                        <i class="fas fa-align-left"></i>
                        <span>Menu</span>
                    </button>
                    <a class="text-uppercase">Welcome <c:out value="<%=libName%>"/> (ID : <c:out value="<%=libID%>"/>)  [<c:out value="<%=libRole%>"/>]</a>
                </div>
</nav>
