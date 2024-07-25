<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SIGN IN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <style>
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body class="container">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form action="signIn.jsp" method="POST" id="my_form" class="border p-4 bg-light shadow">
                <h2 class="text-center mb-4">Welcome to the Student Management Website!</h2>
                <hr>
                <div class="mb-3">
                    <label for="studentID" class="form-label">Student ID</label>
                    <input type="text" class="form-control" id="studentID" name="studentID">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="exampleCheck1">
                    <label class="form-check-label" for="exampleCheck1">Check me out</label>
                </div>
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-primary">Submit</button>
                    <a class="btn btn-primary" href="register.jsp">Sign up</a>
                </div>
                <%
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        String studentID = request.getParameter("studentID");
                        String password = request.getParameter("password");
                        
                        if (studentID != null && !studentID.isEmpty() && password != null && !password.isEmpty()) {
                            // Handle authentication here (e.g., check credentials in the database)
                            // For now, we just display a success message
                            out.println("<div class='alert alert-success mt-3'>Sign in successful!</div>");
                        } else {
                            out.println("<div class='alert alert-danger mt-3'>Please enter your student ID and password.</div>");
                        }
                    }
                %>
            </form>
        </div>
    </div>
</body>
</html>
>