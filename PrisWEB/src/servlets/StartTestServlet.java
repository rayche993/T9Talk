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
import model.Odgovor;
import model.Pitanje;
import model.Test;
import model.Uradio;

/**
 * Servlet implementation class StartTestServlet
 */
@WebServlet("/StartTestServlet")
public class StartTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	@EJB
	TestBeanLocal testBean;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StartTestServlet() {
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
		Uradio uradio = null;
		Test test = null;
		int testID = -1;
		int pregledajID = -1;
		int pogledajID = -1;
		int bodovi = 0;
		int gotov = -1;
		
		//Sluzi za pokretanje testa sa kurs.jsp strane
		Enumeration<String> imena = request.getParameterNames();
		while(imena.hasMoreElements()){
			String ime = imena.nextElement();
			if (request.getParameter(ime).equals("Pokreni")){
				try{
					testID = Integer.parseInt(ime);
				}catch(Exception e){
					e.printStackTrace();
				}
			} else if(request.getParameter(ime).equals("Pregledaj")){
				try{
					pregledajID = Integer.parseInt(ime);
				}catch(Exception e){
					e.printStackTrace();
				}
			} else if(request.getParameter(ime).equals("Pogledaj")){
				try{
					pogledajID = Integer.parseInt(ime);
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		if(testID > 0){
			test = testBean.getTestForID(testID);
			request.getSession().setAttribute("test", test);
			rd = getServletContext().getRequestDispatcher("/start-test.jsp");
		}else if(pregledajID > 0){
			test = testBean.getTestForID(pregledajID);
			request.getSession().setAttribute("test", test);
			rd = getServletContext().getRequestDispatcher("/lista-uradjenih.jsp");
		}else if(pogledajID > 0){
			uradio = testBean.getUradioZaID(pogledajID);
			request.getSession().setAttribute("uradio", uradio);
			rd = getServletContext().getRequestDispatcher("/uradjen-oceni.jsp");
		}
		
		
		doGet(request, response);
		rd.forward(request, response);
	}

}
