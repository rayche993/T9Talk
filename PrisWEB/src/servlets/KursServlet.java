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
import model.Ocena;
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
		Kurs kurs = null;
		RequestDispatcher rd = null;
		UserBeanRemote userBean = (UserBeanRemote) request.getSession().getAttribute("user");
		String glasaj = request.getParameter("glasaj");
		int prikazID = -1;
		int prijavaID = -1;
		boolean glasanje = false;
		if (glasaj != null)
			glasanje = glasaj.equals("Glasaj");
		
		if (!glasanje){
			Enumeration<String> imena = request.getParameterNames();
			
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
			
			String prijava = "";
			
			if (prijavaID > -1){
				kurs = kursBean.getKurs(prijavaID);
				User myUser = null;
				if ((myUser = kursBean.subscribeUser(userBean.getMyUser(), kurs)) != null){
					userBean.setMyUser(myUser);
					prijava = "Uspesno ste se prijavili " + myUser.getUsername() + " na kurs " + kurs.getNaziv();
				}else
					prijava = "Neuspesno ste se prijavili";
				
				request.setAttribute("prijava", prijava);
				rd = getServletContext().getRequestDispatcher("/index.jsp");
			}
		}
		
		if (glasanje || prikazID > -1){
			if (prikazID > -1)
				kurs = kursBean.getKurs(prikazID);
			else
				kurs = (Kurs)request.getSession().getAttribute("kurs");
			
			if (glasanje){
				String value = "0";
				value = request.getParameter("star2");
				if (value != null)
					kursBean.oceni(value, kurs, userBean.getMyUser());
			}
			
			List<Komentar> komentari = kursBean.getKomentari(kurs);
			
			String starDis = new String("");
			String disSub = new String("");
			String[] arr = new String[20];
			
			boolean disabledSub = false;
			boolean starEnabled = false;
			boolean logged = userBean != null;
			
			if (logged){
				if (userBean.isPolaznik()){
					User myUser = userBean.getMyUser();
					for (Kurs k : myUser.getKurs4()){
						if (k.getKursid() == kurs.getKursid()){
							disabledSub = true;
							starEnabled = true;
							break;
						}
					}
				}
			}else{
				disabledSub = true;
				starEnabled = false;
			}
			float sum = 0;
			float avg = 0;
			boolean glasao = false;
			List<Ocena> ocene = kursBean.getOcene(kurs);
			for (Ocena o : ocene){
				sum += Float.parseFloat(o.getOpis());
				if (logged)
					if (o.getUser().getUserid() == userBean.getMyUser().getUserid())
						glasao = true;
			}
			
			int size = ocene.size();
			if (size > 0)
				avg = sum / size;
			else
				avg = 0;
			
			arr = new String[20];
			int j = 0;
			
			for (int i = j; i<arr.length; i++){
				if (avg >= ((i+1) * 0.25) - 0.125 && avg < ((i+1)*0.25) + 0.125){
					arr[i] = "checked";
					j = i + 1;
					break;
				}else
					arr[i] = new String("");
			}
			
			while (j < arr.length){
				arr[j] = new String("");
				j++;
			}
			
			disSub = disabledSub ? "disabled" : "";
			starDis = !starEnabled || glasao ? "disabled" : "";
			
			request.getSession().setAttribute("kurs", kurs);
			request.setAttribute("komentari", komentari);
			request.setAttribute("arr", arr);
			request.setAttribute("disSub", disSub);
			request.setAttribute("starDis", starDis);
			
			rd = getServletContext().getRequestDispatcher("/kurs.jsp");
		}
		rd.forward(request, response);
	}

}
