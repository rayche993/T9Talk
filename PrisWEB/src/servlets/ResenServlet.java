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

import beans.TestBeanLocal;
import beans.UserBeanRemote;
import model.Pitanje;
import model.Test;
import model.Uradio;

/**
 * Servlet implementation class ResenServlet
 */
@WebServlet("/ResenServlet")
public class ResenServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@EJB
	TestBeanLocal testBean;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ResenServlet() {
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
		RequestDispatcher rd = null;
		
		UserBeanRemote userBean = (UserBeanRemote) request.getSession().getAttribute("user");
		Test test = null;
		float bodovi = 0;
		
		
		test = (Test) request.getSession().getAttribute("test");
		
		List<Pitanje> pitanja = testBean.getPitanjaZaTest(test);
		System.out.println("broj pitanja je"+pitanja.size());
		
		for(Pitanje pitanje : pitanja){
				System.out.println("Usao sam u petlju za pitanje: "+pitanje.getPitanjeid());
				String nazivPolja = Integer.toString(pitanje.getPitanjeid());
				System.out.println(nazivPolja);
				String[] odgovori = request.getParameterValues(nazivPolja);
				System.out.println("Duzina string[] odgovori "+odgovori.length);
				System.out.println(odgovori[0]);
				if(odgovori.length !=0)
				bodovi += testBean.bodujPitanje(pitanje, odgovori);
				System.out.println("Osvojeni bodovi su " + bodovi);
		}
		
		
		request.setAttribute("pitanja", pitanja);
		
		System.out.println("Ukupno bodova "+ bodovi);
		testBean.uradioTest(userBean.getMyUser(), test, bodovi);
//		for(Pitanje pitanje : pitanja){
//			if(pitanje.getTipodgovora() == 1){
//				String text = request.getParameter(Integer.toString(pitanje.getPitanjeid()));
//				System.out.println(text);
//				Uradio uradio = testBean.getUradio(test, userBean.getMyUser());
//				System.out.println("uradio "+uradio.getUradioid());
//				testBean.noviTxtOdgovor(uradio, pitanje, text );
//			}
//		}
		request.getRequestDispatcher("/index.jsp").forward(request, response); 
		
		doGet(request, response);
		rd.forward(request, response);
	}

}
