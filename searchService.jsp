<%@ page import="java.sql.*, java.io.*, java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Search Results - AgroTECH</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f4f9f4;
      margin: 0;
      padding: 0;
    }
    h2 {
      text-align: center;
      color: #2e7d32;
      margin-top: 20px;
    }
    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 20px;
      max-width: 1000px;
      margin: 40px auto;
      padding: 0 20px;
    }
    .product-card {
      background: #fff;
      border-radius: 12px;
      padding: 20px;
      box-shadow: 0 6px 16px rgba(0,0,0,0.1);
      transition: 0.3s;
      text-align: center;
    }
    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.2);
    }
    .product-card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
      border-radius: 10px;
      margin-bottom: 15px;
    }
    .product-card h3 {
      color: #333;
      margin: 10px 0;
    }
    .product-card p {
      color: #666;
      margin-bottom: 10px;
    }
    .product-card button {
      background: #4caf50;
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 25px;
      cursor: pointer;
      transition: 0.3s;
    }
    .product-card button:hover {
      background: #2e7d32;
    }
  </style>
</head>
<body>

<h2>🔍 Search Results</h2>

<%
    String search = request.getParameter("search");

    if (search == null || search.trim().isEmpty()) {
        out.println("<p style='text-align:center;color:red;'>Please enter something to search!</p>");
    } else {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/minor?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "khushi27"
            );

            String query = "SELECT * FROM service WHERE name LIKE ? OR category LIKE ?";
            ps = con.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            rs = ps.executeQuery();

            boolean found = false;
%>

<div class="product-grid">
<%
            while (rs.next()) {
                found = true;
                String name = rs.getString("name");
                String category = rs.getString("category");
                String desc = rs.getString("description");
                double price = rs.getDouble("price");
%>
    <div class="product-card">
        <%
            Blob blob = rs.getBlob("image");
            if (blob != null && blob.length() > 0) {
                byte[] imgData = blob.getBytes(1, (int) blob.length());
                // ✅ Use Java built-in Base64
                String imgBase64 = Base64.getEncoder().encodeToString(imgData);
        %>
            <img src="data:image/jpeg;base64,<%= imgBase64 %>" alt="<%= name %>">
        <% } else { %>
            <img src="https://via.placeholder.com/200x150?text=No+Image" alt="No Image">
        <% } %>

        <h3><%= name %></h3>
        <p><strong>Category:</strong> <%= category %></p>
        <p><%= desc %></p>
        <p><strong>₹<%= price %></strong></p>

        <form action="buy.html" method="get">
            <button type="submit">Rent</button>
        </form>
    </div>
<%
            }
%>
</div>

<%
            if (!found) {
                out.println("<p style='text-align:center;color:gray;'>No matching services found.</p>");
            }
        } catch (Exception e) {
            out.println("<p style='text-align:center;color:red;'>⚠️ Database Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
%>

</body>
</html>
