<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<%@ include file="config.jsp" %>

<%
    HttpSession session1 = request.getSession();
    String allowed =(String) session1.getAttribute("userprofile");
%>
<html>
<head></head>
<body>


<%@ include file="menu.jsp" %>

<h1>Categories</h1>

<%
if( allowed != null ){

	out.println("<p>"+allowed+"</p>");

    Statement stmt = null;
    ResultSet rs = null;

    try {
    
        stmt = conn.createStatement();
        String sql = "SELECT * FROM category";
        rs = stmt.executeQuery(sql);

        if (!rs.next()) {
            out.println("Aucune cat�gorie trouv�e<br /><br />");
        } else {
            out.println("<table><tr><th>ID</th><th>LABEL</th><th>ACTIONS</th></tr>");
            do {
                int id = rs.getInt("id");
                String label = rs.getString("label");
%>
                <tr>
                    <td><%= id %></td>
                    <td><%= label %></td>
                    <td><a href="products.jsp?category_id=<%= id %>">Products</a></td>
                </tr>
<%
            } while (rs.next());
            out.println("</table>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (Exception e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
    }


}else{
	%>
	
	<%@ include file="logout.jsp" %>
<%
}
%>



</body>
</html>