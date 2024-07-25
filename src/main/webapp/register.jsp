<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>Student Registration</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
    crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
    integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
    crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js"
    integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz"
    crossorigin="anonymous"></script>
<style>
.red {
    color: red;
}
</style>
</head>
<body>
    <%
        String error = request.getAttribute("error")+"";
        error = (error.equals("null"))?"":error;

        String studentID = request.getAttribute("studentID")+"";
        studentID = (studentID.equals("null"))?"":studentID;
    
        String fullName = request.getAttribute("fullName")+"";
        fullName = (fullName.equals("null"))?"":fullName;
    
        String gender = request.getAttribute("gender")+"";
        gender = (gender.equals("null"))?"":gender;
    
        String dob = request.getAttribute("dob")+"";
        dob = (dob.equals("null"))?"":dob;
    
        String address = request.getAttribute("address")+"";
        address = (address.equals("null"))?"":address;
    
        String phone = request.getAttribute("phone")+"";
        phone = (phone.equals("null"))?"":phone;
    
        String email = request.getAttribute("email")+"";
        email = (email.equals("null"))?"":email;
    %>
    <div class="container">
        <div class="text-center">
            <h1>Student Registration</h1>
        </div>
        
        <div class="red" id="error">
            <%=error %>
        </div>
        <form class="form" action="/DebutProject/RegisterServlet" method="post">
            <div class="row">
                <div class="col-sm-6">
                    <h3>Account Information</h3>
                    <div class="mb-3">
                        <label for="studentID" class="form-label">Student ID<span class="red">*</span></label>
                        <input type="text" class="form-control" id="studentID" name="studentID" required="required" value="<%=studentID%>">
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password<span class="red">*</span></label>
                        <input type="password" class="form-control" id="password" name="password" required="required" onkeyup="checkPassword()">
                    </div>
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm Password<span class="red">*</span>
                            <span id="msg" class="red"></span>
                        </label>
                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required="required" onkeyup="checkPassword()">
                    </div>
                    <hr />
                    <h3>Personal Information</h3>
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" value="<%=fullName%>">
                    </div>
                    <div class="mb-3">
                        <label for="gender" class="form-label">Gender</label>
                        <select class="form-control" id="gender" name="gender">
                            <option></option>
                            <option value="Male" <%=(gender.equals("Male"))?"selected='selected'":"" %> >Male</option>
                            <option value="Female" <%=(gender.equals("Female"))?"selected='selected'":"" %> >Female</option>
                            <option value="Other" <%=(gender.equals("Other"))?"selected='selected'":"" %> >Other</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="dob" class="form-label">Date of Birth</label>
                        <input type="date" class="form-control" id="dob" name="dob" value="<%=dob%>">
                    </div>
                </div>
                <div class="col-sm-6">
                    <h3>Contact Information</h3>
                    <div class="mb-3">
                        <label for="address" class="form-label">Address</label>
                        <input type="text" class="form-control" id="address" name="address" value="<%=address%>">
                    </div>
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" class="form-control" id="phone" name="phone" value="<%=phone%>">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="<%=email%>">
                    </div>
                    <hr />
                    <div class="mb-3">
                        <label for="agreeTerms" class="form-label">Agree to <a href="#">terms and conditions</a><span class="red">*</span></label>
                        <input type="checkbox" class="form-check-input" id="agreeTerms" name="agreeTerms" required="required" onchange="toggleSubmitButton()">
                    </div>
                    <input class="btn btn-primary form-control" type="submit" value="Register" name="submit" id="submit" style="visibility: hidden;" />
                </div>
            </div>
        </form>
    </div>
</body>

<script>
function checkPassword(){
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    if(password !== confirmPassword){
        document.getElementById("msg").innerHTML = "Passwords do not match!";
        return false;
    } else {
        document.getElementById("msg").innerHTML = "";
        return true;
    }
}

function toggleSubmitButton(){
    const agreeTerms = document.getElementById("agreeTerms");
    if(agreeTerms.checked){
        document.getElementById("submit").style.visibility="visible";
    } else {
        document.getElementById("submit").style.visibility="hidden";
    }
}
</script>

</html>
