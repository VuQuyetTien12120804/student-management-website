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
//@WebServlet("/DeleteStudentServlet")
public class DeleteStudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] outerArray = request.getParameterValues("selectedStudents");

        // Print the selected student IDs for debugging
        if (outerArray != null) {
            System.out.println("Selected students to delete:");
            for (String studentID : outerArray) {
                System.out.println(studentID);
            }
        } else {
            System.out.println("No students were selected for deletion.");
        }

        if (outerArray != null && outerArray.length > 0) {
            studentDAO studentDao = new studentDAO();
            ArrayList<String> studentIdsToDelete = new ArrayList<>();
            for (String studentID : outerArray) {
                studentIdsToDelete.add(studentID);
            }
            studentDao.deleteStudents(studentIdsToDelete);  
        }
        response.sendRedirect("students.jsp");
    }
}
