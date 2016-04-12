package servlets;

import java.io.IOException;
import java.util.Enumeration;
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
import model.User;

/**
 * Servlet implementation class KursServlet
 */
@WebServlet("/KursServlet")
public class KursServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public KursServlet() {
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
		
		Enumeration<String> imena = request.getParameterNames();
		int prikazID = -1;
		int prijavaID = -1;
		while(imena.hasMoreElements()){
			String ime = imena.nextElement();
			if (request.getParameter(ime).equals("Prikazi")){
				try{
					prikazID = Integer.parseInt(ime);
				}catch(Exception e){
					e.printStackTrace();
				}
			}
			if (request.getParameter(ime).equals("Prijavi se")){
				try{
					prijavaID = Integer.parseInt(ime);
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		RequestDispatcher rd = null;
		
		if (prikazID > -1){
			Kurs kurs = kursBean.getKurs(prikazID);
			List<Komentar> komentari = kursBean.getKomentari(kurs);
			
			request.getSession().setAttribute("kurs", kurs);
			request.setAttribute("komentari", komentari);
			
			rd = getServletContext().getRequestDispatcher("/kurs.jsp");
		}else{
			rd = getServletContext().getRequestDispatcher("/index.jsp");
		}
		
		String prijava = "";
		
		if (prijavaID > -1){
			Kurs kurs = kursBean.getKurs(prijavaID);
			UserBeanRemote userBean = (UserBeanRemote) request.getSession().getAttribute("user");
			User myUser = null;
			if ((myUser = kursBean.subscribeUser(userBean.getMyUser(), kurs)) != null){
				userBean.setMyUser(myUser);
				prijava = "Uspesno ste se prijavili " + myUser.getUsername() + " na kurs " + kurs.getNaziv();
			}else
				prijava = "Neuspesno ste se prijavili";
			
			request.setAttribute("prijava", prijava);
			rd = getServletContext().getRequestDispatcher("/index.jsp");
		}
		
		rd.forward(request, response);
	}

}
