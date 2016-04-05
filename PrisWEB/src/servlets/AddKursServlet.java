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

import beans.KursBeanLocal;

/**
 * Servlet implementation class AddKursServlet
 */
@WebServlet("/AddKursServlet")
public class AddKursServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddKursServlet() {
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
		String naziv = request.getParameter("naziv");
		String opis = request.getParameter("opis");
		String ishod = request.getParameter("ishod");
		
		List<String> greske = new ArrayList<String>();
		
		if (naziv.isEmpty())
			greske.add("Morate uneti naziv kursa!");
		
		if (opis.isEmpty())
			greske.add("Morate uneti opis kursa!");
		
		if (ishod.isEmpty())
			greske.add("Morate uneti ocekivani ishod kursa!");
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher("/admin.jsp");
		String porukaKurs = null;
		
		if (greske.isEmpty()){
			if (kursBean.addKurs(naziv, opis, ishod))
				porukaKurs = "Uspesno ste uneli kurs!";
			else
				porukaKurs = "Neuspesno ste uneli kurs!";
		}else{
			request.setAttribute("naziv", naziv);
			request.setAttribute("opis", opis);
			request.setAttribute("ishod", ishod);
		}
		
		request.setAttribute("greskeKurs", greske);
		request.setAttribute("porukaKurs", porukaKurs);
		
		rd.forward(request, response);
	}
}