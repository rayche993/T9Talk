package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.LoginBeanLocal;

/**
 * Servlet implementation class AddPredavacServlet
 */
@WebServlet("/AddPredavacServlet")
public class AddPredavacServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddPredavacServlet() {
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
		
		RequestDispatcher rd = null;
		rd = getServletContext().getRequestDispatcher("/admin.jsp");
		
		String poruka = null;
		
		if (greske.size() == 0){
			if (logBean.registerPredavac(ime, prezime, username, password))
				poruka = "Uspesno registrovan predavac!";
			else
				poruka = "Neuspesno registrovan predavac!";
		}else{
			request.setAttribute("ime", ime);
			request.setAttribute("prezime", prezime);
			request.setAttribute("username", username);
		}
		
		request.setAttribute("poruka", poruka);
		request.setAttribute("greske", greske);
		rd.forward(request, response);
	}

}
