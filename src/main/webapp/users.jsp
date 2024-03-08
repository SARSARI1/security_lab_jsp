<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>

<%@ include file="config.jsp" %>
<html>
<head></head>
<body>

<%@ include file="menu.jsp" %>

<h1>Users</h1>

<%
    Statement stmt = null;
    ResultSet rs = null;

    try {
    
        stmt = conn.createStatement();
        String sql = "SELECT * FROM account";
        rs = stmt.executeQuery(sql);

        if (!rs.isBeforeFirst()) {
            out.println("Aucun utilisateur trouvé<br /><br />");
        } else {
            out.println("<table><tr><th>ID</th><th>NAME</th><th>EMAIL</th><th>PASSWORD</th><th>PROFILE</th></tr>");
            while (rs.next()) {
                String id = rs.getString("id");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String profile = rs.getString("profile");
%>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= email %></td>
                    <td><%= password %></td>
                    <td><%= profile %></td>
                </tr>
<%
            }
            out.println("</table>");
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch(Exception e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch(Exception e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch(Exception e) { e.printStackTrace(); }
    }
%>
<br /><a href="add-user.jsp">+ Add new user</a>

</body>
</html>
    