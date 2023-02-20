<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search.jsp</title>
</head>
<body>
 <% 
        String bookName = request.getParameter("book_name");
        if(bookName != null && !bookName.isEmpty()) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam", "root", "3206");
                String sql = "SELECT * FROM book WHERE book_name LIKE ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, "%" + bookName + "%");
                rs = stmt.executeQuery();
                while(rs.next()) {
                    out.println("<p><b>Book Name:</b> " + rs.getString("book_name") + "</p>");
                    out.println("<p><b>Authors:</b> " + rs.getString("authors") + "</p>");
                    out.println("<p><b>Price:</b> " + rs.getDouble("price") + "</p>");
                    out.println("<hr>");
                }
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if(rs != null) rs.close();
                    if(stmt != null) stmt.close();
                    if(conn != null) conn.close();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>