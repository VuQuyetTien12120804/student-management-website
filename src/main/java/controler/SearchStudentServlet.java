package controler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.student;
import database.studentDAO;
import java.util.ArrayList;

@WebServlet(name = "SearchStudentServlet", urlPatterns  = {"/SearchStudentServlet"})
public class SearchStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentID = request.getParameter("studentID");

        studentDAO studentDao = new studentDAO();
        ArrayList<student> studentList = studentDao.selectByStudentID(studentID);

        request.setAttribute("studentList", studentList);
        request.getRequestDispatcher("students.jsp").forward(request, response);
    }
}
