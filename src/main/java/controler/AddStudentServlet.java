package controler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.student;
import util.encryption;
import database.studentDAO;

@WebServlet(name = "AddStudentServlet", urlPatterns  = {"/AddStudentServlet"})
public class AddStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentID = request.getParameter("studentID");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        
        password = encryption.toSHA1(password);

        student newStudent = new student(studentID, password, fullName, gender, dateOfBirth, address, phone, email);
        studentDAO studentDao = new studentDAO();
        studentDao.insert(newStudent);

        response.sendRedirect("students.jsp");
    }
}
