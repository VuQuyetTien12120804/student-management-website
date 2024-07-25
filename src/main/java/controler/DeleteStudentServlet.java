package controler;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import database.studentDAO;
import java.util.ArrayList;

@WebServlet(name = "DeleteStudentServlet", urlPatterns  = {"/DeleteStudentServlet"})
public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] selectedStudents = request.getParameterValues("selectedStudents");

        if (selectedStudents != null && selectedStudents.length > 0) {
            studentDAO studentDao = new studentDAO();
            ArrayList<String> studentIdsToDelete = new ArrayList<>();
            for (String studentID : selectedStudents) {
                studentIdsToDelete.add(studentID);
            }
            studentDao.deleteStudents(studentIdsToDelete);
        }
        response.sendRedirect("students.jsp");
    }
}
