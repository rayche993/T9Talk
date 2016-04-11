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
import model.Komentar;
import model.Kurs;

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

	//OVDE REALIZUJ I PRIJAVU NA KURS
	@EJB
	KursBeanLocal kursBean;
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Enumeration<String> imena = request.getParameterNames();
		int prikazId = -1;
		while(imena.hasMoreElements()){
			String ime = imena.nextElement();
			if (request.getParameter(ime).equals("Prikazi")){
				try{
					prikazId = Integer.parseInt(ime);
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		RequestDispatcher rd = null;
		
		if (prikazId > -1){
			Kurs kurs = kursBean.getKurs(prikazId);
			List<Komentar> komentari = kursBean.getKomentari(kurs);
			
			request.getSession().setAttribute("kurs", kurs);
			request.setAttribute("komentari", komentari);
			
			rd = getServletContext().getRequestDispatcher("/kurs.jsp");
		}else{
			rd = getServletContext().getRequestDispatcher("/index.jsp");
		}
		
		rd.forward(request, response);
	}

}
