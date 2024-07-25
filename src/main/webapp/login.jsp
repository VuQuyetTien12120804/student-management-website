<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>STUDENT MANAGER WEB</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    <script>
        function my_submit() {
            let error = "";
            let studentID = document.getElementById("studentID").value;
            let password = document.getElementById("password").value;
        
            if (studentID.length === 0) {
                error += "You must enter your student ID!\n";
            }
            if (password.length === 0) {
                error += "You must enter your password!\n";
            }
            if (error.length > 0) {
                alert(error);
                return;
            } else {
                // Submit form
                document.getElementById("my_form").submit();
            }
        }
    </script>
</head>
<body class="container" style="background-color: powderblue">
    <div class="row justify-content-center mt-5">
        <div class="col-md-6">
            <form action="/DebutProject/SignInServlet" method="POST" id="my_form" class="border p-4 bg-light shadow" autocomplete="off" >
                <h2 class="text-center mb-4">Welcome to the Student Management Website!</h2>
                <%
                    String baoLoi = request.getAttribute("error")+"";
                    if(baoLoi.equals("null")){
                        baoLoi = "";
                    }
                %>
                <div class="text-center"><span class="red"><%=baoLoi %></span></div>
                <hr>
                <div class="mb-3">
                    <label for="studentID" class="form-label">Student ID</label>
                    <input type="text" class="form-control" id="studentID" name="studentID" autocomplete="off">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" autocomplete="off">
                </div>
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="exampleCheck1">
                    <label class="form-check-label" for="exampleCheck1">Check me out</label>
                </div>
                <div class="d-flex justify-content-between">
                    <button type="button" class="btn btn-primary" onclick="my_submit()">Sign in</button>
                    <a class="btn btn-primary" href="register.jsp">Sign up</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
