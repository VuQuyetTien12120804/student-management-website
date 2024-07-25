<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.student" %>
<%@ page import="database.studentDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <style>
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Student Detail</h1>
        <%
            // In ra giá trị studentID được nhận
            String studentID = request.getParameter("studentID");
            out.println("<p>Received studentID: " + studentID + "</p>");

            studentDAO studentDao = new studentDAO();
            student studentDetail = studentDao.selectById(new student(studentID, "", "", "", "", "", "", ""));

            // Kiểm tra và in ra kết quả của truy vấn
            if (studentDetail != null) {
                out.println("<p>Student found: " + studentDetail.getFullName() + "</p>");
        %>
        <table class="table table-bordered">
            <tr>
                <th>Student ID</th>
                <td><%= studentDetail.getStudentID() %></td>
            </tr>
            <tr>
                <th>Password</th>
                <td><%= studentDetail.getPassword() %></td>
            </tr>
            <tr>
                <th>Full Name</th>
                <td><%= studentDetail.getFullName() %></td>
            </tr>
            <tr>
                <th>Gender</th>
                <td><%= studentDetail.getGender() %></td>
            </tr>
            <tr>
                <th>Date of Birth</th>
                <td><%= studentDetail.getDateOfBirth() %></td>
            </tr>
            <tr>
                <th>Address</th>
                <td><%= studentDetail.getAddress() %></td>
            </tr>
            <tr>
                <th>Phone</th>
                <td><%= studentDetail.getPhone() %></td>
            </tr>
            <tr>
                <th>Email</th>
                <td><%= studentDetail.getEmail() %></td>
            </tr>
        </table>
        <%
            } else {
                out.println("<p>Student not found!</p>");
            }
        %>
        <button class="btn btn-secondary" onclick="window.history.back()">Back</button>
    </div>
</body>
</html>
