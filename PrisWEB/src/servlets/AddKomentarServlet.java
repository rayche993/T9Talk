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
import beans.UserBeanLocal;
import beans.UserBeanRemote;
import model.Komentar;
import model.Kurs;

/**
 * Servlet implementation class AddKomentarServlet
 */
@WebServlet("/AddKomentarServlet")
public class AddKomentarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddKomentarServlet() {
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
		Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
		String komentar = request.getParameter("komentar");
		UserBeanRemote userBean = (UserBeanRemote)request.getSession().getAttribute("user");
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/kurs.jsp");
		String poruka = "Neuspesno ste poslali komentar!";
		
		if (kurs != null && userBean.getMyUser() != null){
			if (kursBean.postComment(komentar, kurs, userBean.getMyUser()))
				poruka = "Uspesno ste poslali komentar!";
			
			List<Komentar> komentari = kursBean.getKomentari(kurs);
			request.setAttribute("komentari", komentari);
		}else
			System.out.println("kurs je null ili user nije ulogovan");
		
		request.setAttribute("poruka", poruka);
		rd.forward(request, response);
	}
}