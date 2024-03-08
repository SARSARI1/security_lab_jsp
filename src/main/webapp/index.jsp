<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    HttpSession session1 = request.getSession();

%>
<%@page import="java.sql.*"%>
<%@page import="javax.sql.*"%>
<%@ include file="config.jsp" %>

<%@ page import="javax.servlet.http.*" %>
<%@ page import="javax.servlet.*" %>


<%
   // Statement stmt = null;
   // ResultSet rs = null;

    String connectedId = null;
    String connectedName = null;
    String connectedProfile = null;
    String message = "";
   
    
   
   
    if(request.getParameter("email") != null) { 
    try{
    	String sql = "SELECT * FROM account WHERE email  = ? AND password = ?";
   	    String email = request.getParameter("email");
        String user_password = request.getParameter("password");
        
        PreparedStatement pst = conn.prepareStatement(sql);
       // ResultSet rs = pst.executeQuery();
        pst.setString(1,email );
        pst.setString(2, user_password);
        ResultSet rs = pst.executeQuery();

        if(rs.next()){
        	connectedId = rs.getString("id");
            connectedName = rs.getString("name");
            connectedProfile = rs.getString("profile");
            session.setAttribute("userprofile", connectedProfile);
            pst.executeQuery();
        } else {
            message = "Données invalides";
        }
        
        
		        if(connectedId != null) {
		            response.sendRedirect("./categories.jsp");
		            return;
		        }
		        
		    }catch(Exception ex){
		        ex.printStackTrace();
		        }
        
    
    }
    
  
    
    
    
    
    
    
    
    
    
    
    
%>
<html>
    <head></head>
    <body>
        <h1>Login</h1>
        <% if(connectedId == null) { %>
            <span style="color:red; font-weight: bold;"><%=message%></span><br /><br />
        <% } %>
        
        <form action='index.jsp' method="post">
            <table>
                <tr>
                    <td>Email :</td>
                    <td><input type="text" name="email" required="required"/></td>
                </tr>
                <tr>
                    <td>Password :</td>
                    <td><input type="password" name="password" value=""/></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="submit" value="Connexion" /></td>
                </tr>        
            </table>    
        </form>
    </body>
</html>
    