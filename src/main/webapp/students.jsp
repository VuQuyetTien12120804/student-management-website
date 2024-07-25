<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="model.student" %>
<%@ page import="database.studentDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>STUDENTS_MANAGEMENT</title>
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
        <!-- Search form -->
        <form class="input-group" method="get" action="SearchStudentServlet">
            <input type="search" name="studentID" id="form1" class="form-control" placeholder="Search by Student ID" aria-label="Search">
            <button class="btn btn-primary" type="submit" id="button-search">
                <i class="fas fa-search"></i>
            </button>
        </form>

        <!-- Add and Delete buttons -->
        <div class="d-flex justify-content-end mt-3 mb-3">
            <button class="btn btn-success me-2" type="button" id="button-add" data-bs-toggle="modal" data-bs-target="#addStudentModal">Add</button>
            <form id="deleteForm" method="post" action="DeleteStudentServlet">
                <button class="btn btn-warning" type="submit" id="button-delete">Delete</button>
            </form>
        </div>

		
        <!-- Student table -->
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">Select</th>
                    <th scope="col">Student ID</th>
                    <th scope="col">Full Name</th>
                    <th scope="col">Gender</th>
                    <th scope="col">Address</th>
                    <th scope="col">View</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ArrayList<student> studentList = (ArrayList<student>) request.getAttribute("studentList");
                    if (studentList == null) {
                        studentDAO studentDao = new studentDAO();
                        studentList = studentDao.selectAll();
                    }

                    int count = 1;
                    for (student s : studentList) {
                %>
                <tr>
                    <th scope="row"><%= count++ %></th>
                    <td><input type="checkbox" name="selectedStudents" value="<%= s.getStudentID() %>"></td>
                    <td><%= s.getStudentID() %></td>
                    <td><%= s.getFullName() %></td>
                    <td><%= s.getGender() %></td>
                    <td><%= s.getAddress() %></td>
                    <td><a href="viewDetail.jsp?studentID=<%= s.getStudentID() %>" class="btn btn-info">View</a></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        </form>

        <!-- Add Student Modal -->
        <div class="modal fade" id="addStudentModal" tabindex="-1" aria-labelledby="addStudentModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addStudentModalLabel">Add Student</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="addStudentForm" method="post" action="AddStudentServlet">
                            <div class="mb-3">
                                <label for="studentID" class="form-label">Student ID</label>
                                <input type="text" class="form-control" id="studentID" name="studentID" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>
                            <div class="mb-3">
                                <label for="fullName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="fullName" name="fullName" required>
                            </div>
                            <div class="mb-3">
                                <label for="gender" class="form-label">Gender</label>
                                <select class="form-control" id="gender" name="gender" required>
                                    <option value="male">Male</option>
                                    <option value="female">Female</option>
                                    <option value="female">Other</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <input type="text" class="form-control" id="address" name="address" required>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="phone" name="phone" required>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Add Student</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
