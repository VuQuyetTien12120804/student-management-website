<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        .navbar-brand {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .table-responsive {
            margin-top: 20px;
        }
        .modal-header {
            background-color: #007bff;
            color: white;
        }
        .modal-title {
            color: white;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }
        .btn-link {
            color: #007bff;
            text-decoration: none;
        }
        .btn-link:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        .navbar-nav .nav-link {
            margin-right: 15px;
        }
        .logout-btn {
            background-color: #dc3545;
            border: none;
            color: white;
        }
        .logout-btn:hover {
            background-color: #c82333;
        }
        .form-inline {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
        }
    </style>
    <script>
        function toggleSelectAll() {
            var checkboxes = document.querySelectorAll('input[name="selectedStudents"]');
            var selectAllButton = document.getElementById('selectAllButton');
            var isSelectAll = selectAllButton.getAttribute('data-select-all') === 'true';
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = isSelectAll;
            });
            
            if (isSelectAll) {
                selectAllButton.innerText = 'Deselect All';
                selectAllButton.setAttribute('data-select-all', 'false');
            } else {
                selectAllButton.innerText = 'Select All';
                selectAllButton.setAttribute('data-select-all', 'true');
            }
        }

        function validateForm() {
            var studentID = document.getElementById('studentID').value;
            if (studentID == '') {
                alert('Student ID is required');
                return false;
            }
            return true;
        }

        function confirmDelete() {
            return confirm('Are you sure you want to delete the selected students?');
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
            <a class="navbar-brand" href="#">Student Management</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="students.jsp">Student List</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#addStudentModal">Add Student</a>
                    </li>
                </ul>
                <form method="post" action="LogoutServlet" class="ms-auto">
                    <button class="btn logout-btn" type="submit">Logout</button>
                </form>
            </div>
        </nav>

        <!-- Search form -->
        <form class="form-inline mb-3" method="get" action="SearchStudentServlet">
            <div class="input-group">
                <input type="search" name="studentID" class="form-control" placeholder="Search by Student ID" aria-label="Search">
                <button class="btn btn-primary" type="submit">
                    <i class="fas fa-search"></i> Search
                </button>
            </div>
        </form>

        <!-- Add, Delete, and Select All buttons -->
        <form id="deleteForm" method="post" action="DeleteStudentServlet" onsubmit="return confirmDelete()">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <button class="btn btn-warning" type="submit">Delete</button>
                <button class="btn btn-info" type="button" id="selectAllButton" data-select-all="true" onclick="toggleSelectAll()">Select All</button>
            </div>

            <!-- Student table -->
            <div class="table-responsive">
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
            </div>
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
                        <form id="addStudentForm" method="post" action="AddStudentServlet" onsubmit="return validateForm()">
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
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="dateOfBirth" name = "dateOfBirth" required>
                            </div>
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="phone" name = "phone" required>
                            </div>
							<div class="mb-3">
                                <label for="phone" class="form-label">email</label>
                                <input type="email" class="form-control" id="email" name = "email" required>
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
