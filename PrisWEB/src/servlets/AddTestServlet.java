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

import beans.LekcijaBeanLocal;
import model.Lekcija;
import model.Odgovor;
import model.Pitanje;
import model.Test;

/**
 * Servlet implementation class AddTestServlet
 */
@WebServlet("/AddTestServlet")
public class AddTestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTestServlet() {
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
	private LekcijaBeanLocal lekcijaBean;
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String naslov = request.getParameter("naslov");
		String opis = request.getParameter("opis");
		
		int brojPitanja = Integer.parseInt(request.getParameter("broj_pitanja"));
		String odgovori = request.getParameter("odgovori");
		String[] arr = odgovori.split(" ");
		int[] niz = new int[arr.length];
		for (int i=0; i<niz.length; i++){
			niz[i] = Integer.parseInt(arr[i]);
		}
		Test test = new Test();
		test.setNaslov(naslov);
		test.setOpis(opis);
		
		Lekcija lekcija = (Lekcija) request.getSession().getAttribute("lekcija");
		test.setLekcija(lekcija);
		
		List<Pitanje> pitanja = new ArrayList<Pitanje>();
		List<Odgovor> answers = new ArrayList<Odgovor>();
		
		for (int i=1; i<=brojPitanja; i++){
			Pitanje pitanje = new Pitanje();
			pitanje.setText(request.getParameter("tekst-" + i));
			pitanje.setTipodgovora(Integer.parseInt(request.getParameter("radio-pitanje-" + i)));
			pitanje.setTest(test);
			
			String check = request.getParameter("odg-radio-" + i);
			
			for (int j=0; j<niz[i-1]; j++){
				Odgovor odg = new Odgovor();
				odg.setPitanje(pitanje);
				
				if (pitanje.getTipodgovora() == 1){
					odg.setText("");
					odg.setTacan(false);
				}
				else if (pitanje.getTipodgovora() == 2){
					odg.setText(request.getParameter("txt-odg-"+j+"-pitanje-"+i));
					
					if (Integer.parseInt(check) == j)
						odg.setTacan(true);
					else
						odg.setTacan(false);
				}else if (pitanje.getTipodgovora() == 3){
					odg.setText(request.getParameter("txt-odg-vise-"+j+"-pitanje-"+i));
					String checkirani = request.getParameter("odg-check-" + i);
					String[] arrCheck = checkirani.split(",");
					System.out.println(checkirani);
					for (String s : arrCheck){
						if (Integer.parseInt(s) == j)
							odg.setTacan(true);
					}
				}
				answers.add(odg);
			}
			
			pitanja.add(pitanje);
		}
		
		String path = "";
		
		if (lekcijaBean.saveTest(test, pitanja, answers))
			path = "/index.jsp";
		else
			path = "/test.jsp";
		
		RequestDispatcher rd = getServletContext().getRequestDispatcher(path);
		rd.forward(request, response);
	}

}
