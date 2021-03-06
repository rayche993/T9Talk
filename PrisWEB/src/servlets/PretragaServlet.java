package servlets;

import java.io.IOException;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.KursBeanLocal;
import beans.UserBeanRemote;
import model.Kurs;
import model.User;

/**
 * Servlet implementation class PretragaServlet
 */
@WebServlet("/PretragaServlet")
public class PretragaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PretragaServlet() {
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
	KursBeanLocal kursBean;
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pretraga = request.getParameter("pretraga");
		String parametar = request.getParameter("parametar");
		User user = null;
		List<Kurs> kursevi;
		
		try {
			UserBeanRemote userBean = (UserBeanRemote) request.getSession().getAttribute("user");
			user = userBean.getMyUser();
		} catch (Exception e) {
			
		}
		
		if(user != null)
			kursevi = kursBean.getKursevi(pretraga, parametar, user);
		else
			kursevi = kursBean.getKursevi(pretraga, parametar, null);
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/index.jsp");
		request.setAttribute("kursevi", kursevi);
		rd.forward(request, response);
	}

}
