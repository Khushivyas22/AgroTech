<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Get user details from session
    String name = (String) session.getAttribute("name");
    String contact = (String) session.getAttribute("contact");
    String email = (String) session.getAttribute("email");
    String address = (String) session.getAttribute("address");
    String area = (String) session.getAttribute("area");
    String state = (String) session.getAttribute("state");
    String pincode = (String) session.getAttribute("pincode");

    // Default values if not logged in
    if(name == null) name = "Guest User";
    if(contact == null) contact = "0000000000";
    if(email == null) email = "guest@example.com";
    if(address == null) address = "Unknown";
    if(area == null) area = "Unknown";
    if(state == null) state = "Unknown";
    if(pincode == null) pincode = "000000";
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>My Account - AgroTECH</title>
<style>
body { font-family: 'Segoe UI', sans-serif; margin:0; background:#f4f9f4; color:#333; display:flex; flex-direction:column; min-height:100vh; padding:20px; }
header { background: linear-gradient(90deg,#2e7d32,#66bb6a); color:white; padding:20px; text-align:center; font-size:1.8rem; border-radius:10px; margin-bottom:20px; }
main { max-width:800px; margin:0 auto; background:#fff; border-radius:12px; box-shadow:0 4px 12px rgba(0,0,0,0.15); padding:30px; }
h2 { text-align:center; margin-bottom:20px; color:#2e7d32; }
label { font-weight:600; display:block; margin:10px 0 5px; }
input { width:100%; padding:10px; border:1px solid #ccc; border-radius:8px; margin-bottom:15px; }
.btn { background:#2e7d32; color:white; border:none; padding:10px 20px; border-radius:8px; cursor:pointer; margin-top:15px; }
.btn:hover { background:#1b5e20; }
</style>
</head>
<body>
<header>My Account</header>
<main>
<h2>Account Details</h2>
<form action="UpdateAccountServlet" method="post">
  <label>Full Name</label>
  <input type="text" name="name" value="<%= name %>" />

  <label>Contact</label>
  <input type="text" name="contact" value="<%= contact %>" />

  <label>Email</label>
  <input type="email" name="email" value="<%= email %>" />

  <label>Address</label>
  <input type="text" name="address" value="<%= address %>" />

  <label>Area</label>
  <input type="text" name="area" value="<%= area %>" />

  <label>State</label>
  <input type="text" name="state" value="<%= state %>" />

  <label>Pincode</label>
  <input type="text" name="pincode" value="<%= pincode %>" />

  <button type="submit" class="btn">Save Changes</button>
</form>
</main>
</body>
</html>
