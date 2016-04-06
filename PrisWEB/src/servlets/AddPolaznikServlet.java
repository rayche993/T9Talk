package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.LoginBeanLocal;
import beans.LoginBeanRemote;
import beans.UserBeanRemote;
import model.User;

/**
 * Servlet implementation class AddPolaznikServlet
 */
@WebServlet("/AddPolaznikServlet")
public class AddPolaznikServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPolaznikServlet() {
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

	@EJB
	LoginBeanLocal logBean;
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ime = request.getParameter("ime");
		String prezime = request.getParameter("prezime");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		List<String> greske = new ArrayList<String>();
		
		if (ime.isEmpty())
			greske.add("Morate uneti ime!");
		if (prezime.isEmpty())
			greske.add("Morate uneti prezime!");
		if (username.isEmpty())
			greske.add("Morate uneti username!");
		if (password.isEmpty())
			greske.add("Morate uneti password!");
		
		String path = "";
		
		RequestDispatcher rd = null;
		
		User user = null;
		
		InitialContext ic = null;
		UserBeanRemote userBean = null;
		
		String poruka = null;
		if (greske.size() == 0){
			if ((user = logBean.registerUser(ime, prezime, username, password, "Predavac")) != null){
				path = "/index.jsp";
				
				try {
					ic = new InitialContext();
					userBean = (UserBeanRemote) ic.lookup("java:global/PrisEAR/PrisEJB/UserBean!beans.UserBeanRemote");
					userBean.setMyUser(user);
					request.getSession().setAttribute("user", userBean);
				} catch (NamingException e) {
					e.printStackTrace();
				}
			}else{
				path = "/register.jsp";
				poruka = "Neuspesno registrovan predavac!";
				request.setAttribute("poruka", poruka);
			}
		}else{
			path = "/register.jsp";
			request.setAttribute("ime", ime);
			request.setAttribute("prezime", prezime);
			request.setAttribute("username", username);
		}
		
		rd = getServletContext().getRequestDispatcher(path);
		
		request.setAttribute("greske", greske);
		rd.forward(request, response);
	}
}
