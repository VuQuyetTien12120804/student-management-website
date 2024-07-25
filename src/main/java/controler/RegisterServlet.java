package controler;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.studentDAO;
import model.student;
import util.encryption;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to doPost method
        doPost(request, response);
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentID = request.getParameter("studentID");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");

        request.setAttribute("studentID", studentID);
        request.setAttribute("fullName", fullName);
        request.setAttribute("gender", gender);
        request.setAttribute("dob", dob);
        request.setAttribute("address", address);
        request.setAttribute("phone", phone);
        request.setAttribute("email", email);

        String url = "";
        String error = "";
        studentDAO std = new studentDAO();
        if(std.checkStudentID(studentID)) {
            error += "Student ID already exists, please choose another.";
        }
        password = encryption.toSHA1(password);
        if(error.length() > 0) {
            request.setAttribute("error", error);
            url = "/register.jsp";
        } else {
            student newStudent = new student(studentID, password, fullName, gender, dob, address, phone, email);
            std.insert(newStudent);
            url = "/success.jsp";
        }
        RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
        rd.forward(request, response);
    }
}
