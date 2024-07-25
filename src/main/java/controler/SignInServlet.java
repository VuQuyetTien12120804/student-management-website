package controler;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.studentDAO;
import model.student;
import util.encryption;

/**
 * Servlet implementation class DangNhap
 */
@WebServlet(name = "SignInServlet", urlPatterns  = {"/SignInServlet"})
public class SignInServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignInServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String studentID = request.getParameter("studentID");
		String password = request.getParameter("password");
		password = encryption.toSHA1(password);
		
		student st = new student();
		st.setStudentID(studentID);
		st.setPassword(password);
		
		studentDAO std = new studentDAO();
		System.out.println(studentID);
		System.out.println(password);
		student student = std.selectByIdAndPassword(st);
		
		String url = "";
		if(student!=null) {
			HttpSession	session = request.getSession();
			session.setAttribute("student", student);
			url = "/students.jsp";
		}else {
			request.setAttribute("error", "error password or studentID!");
			url = "/login.jsp";
		}
		RequestDispatcher rd = getServletContext().getRequestDispatcher(url);
		rd.forward(request, response);
	}

}