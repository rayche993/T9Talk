package servlets;

import java.io.IOException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.LoginBeanRemote;
import beans.UserBeanRemote;
import model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		RequestDispatcher rd = null;
		
		InitialContext ic = null;
		LoginBeanRemote logBean = null;
		UserBeanRemote userBean = null;
		try {
			ic = new InitialContext();
			logBean = (LoginBeanRemote) ic.lookup("java:global/PrisEAR/PrisEJB/LoginBean!beans.LoginBeanRemote");
			userBean = (UserBeanRemote) ic.lookup("java:global/PrisEAR/PrisEJB/UserBean!beans.UserBeanRemote");
		} catch (NamingException e) {
			e.printStackTrace();
		}
		
		if (logBean != null){
			User user = logBean.login(username, password);
			if (user != null){
				if (userBean != null){
					userBean.setMyUser(user);
					request.getSession().setAttribute("user", userBean);
					
					if (userBean.isAdmin())
						rd = getServletContext().getRequestDispatcher("/admin.jsp");
					if (userBean.isPolaznik())
						rd = getServletContext().getRequestDispatcher("/index.jsp");
					if (userBean.isPredavac())
						rd = getServletContext().getRequestDispatcher("/index.jsp");
					
					rd.forward(request, response);
				}else
					System.out.println("userBean je null!");
			}else{
				rd = getServletContext().getRequestDispatcher("/login.jsp");
				rd.forward(request, response);
			}
		}else
			System.out.println("logBean je null!");
	}
}