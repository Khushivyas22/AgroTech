<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Our Services</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f4f9f4; margin:0; padding:0; }
    h2 { text-align: center; color: #2e7d32; margin: 20px 0; }

    .container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 20px;
      padding: 20px;
    }

    .card {
      width: 250px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      text-align: center;
      overflow: hidden;
      transition: transform 0.2s ease-in-out;
    }
    .card:hover { transform: scale(1.05); }

    .card img {
      width: 100%;
      height: 160px;
      object-fit: cover;
    }
    .card h3 {
      margin: 10px 0 5px;
      color: #333;
    }
    .card p {
      color: #666;
      font-size: 14px;
      padding: 0 10px;
      height: 40px;
    }
    .price {
      font-weight: bold;
      margin: 10px 0;
      color: #2e7d32;
    }
    .btn {
      display: inline-block;
      margin: 10px 0 15px;
      padding: 8px 16px;
      background: #2e7d32;
      color: white;
      border-radius: 20px;
      text-decoration: none;
      font-size: 14px;
    }
    .btn:hover { background: #1b5e20; }
  </style>
</head>
<body>
  <h2>🚜 Our Products</h2>
  <div class="container">
    <%
      String url = "jdbc:mysql://localhost:3306/minor?useSSL=false&allowPublicKeyRetrieval=true";
      String user = "root";
      String password = "khushi27";

      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;

      try {
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn = DriverManager.getConnection(url, user, password);

          // PreparedStatement ka use
          String sql = "SELECT id, name, description, price FROM service"; // id included

          pstmt = conn.prepareStatement(sql);
          rs = pstmt.executeQuery();

          while(rs.next()) {
    %>
      <div class="card">
        <img src="GetImageServlet?id=<%= rs.getInt("id") %>" alt="Service Image">

        <h3><%= rs.getString("name") %></h3>
        <p><%= rs.getString("description") %></p>
        <div class="price">₹<%= rs.getDouble("price") %> per acr.</div>
       
        <a href="buy.html" class="btn" target="_blank">Rent</a>

      </div>
    <%
          }
      } catch(Exception e) {
          out.println("<p style='color:red; text-align:center;'>Error: " + e.getMessage() + "</p>");
      } finally {
          if (rs != null) try { rs.close(); } catch(Exception ex) {}
          if (pstmt != null) try { pstmt.close(); } catch(Exception ex) {}
          if (conn != null) try { conn.close(); } catch(Exception ex) {}
      }
    %>
  </div>
</body>
</html>
