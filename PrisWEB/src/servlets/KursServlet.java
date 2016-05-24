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
import beans.LekcijaBeanLocal;
import beans.TestBeanLocal;
import beans.UserBeanLocal;
import beans.UserBeanRemote;
import model.Komentar;
import model.Kurs;
import model.Lekcija;
import model.Ocena;
import model.Test;
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

    @EJB
	KursBeanLocal kursBean;
    
    @EJB
    LekcijaBeanLocal lekcijaBean;
    
    @EJB
    TestBeanLocal testBean;
    
	/** 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tekst = request.getParameter("tekst");
		String naziv = request.getParameter("naziv");
		RequestDispatcher rd = null;
		
		int lekcijaID = -1;
		
		Enumeration<String> imena = request.getParameterNames();
		
		while(imena.hasMoreElements()){
			String ime = imena.nextElement();
			if (request.getParameter(ime).equals("Sacuvaj")){
				try{
					lekcijaID = Integer.parseInt(ime);
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		if (tekst == null || naziv == null)
			rd = getServletContext().getRequestDispatcher("add-lekcija.jsp");
		else{
			if (lekcijaID > -1){
				Lekcija lekcija = lekcijaBean.getLekcija(lekcijaID);
				lekcija.setNaziv(naziv);
				lekcija.setText(tekst);
				lekcijaBean.updateLekcija(lekcija);
				doPost(request, response);
			}else{
				Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
				UserBeanRemote userBean = (UserBeanRemote) request.getSession().getAttribute("user");
				if (kurs != null && userBean != null){
					lekcijaBean.insertLekcija(naziv, tekst, userBean.getMyUser(), kurs);
					doPost(request, response);
				}else{
					rd = getServletContext().getRequestDispatcher("index.jsp");
					rd.forward(request, response);
				}
			}
		}
	}
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
		RequestDispatcher rd = null;
		UserBeanRemote userBean = (UserBeanRemote) request.getSession().getAttribute("user");
		String glasaj = request.getParameter("glasaj");
		int prikazID = -1;
		int prijavaID = -1;
		int predajiID = -1;
		boolean glasanje = false;
		if (glasaj != null)
			glasanje = glasaj.equals("Glasaj");
		
		if (!glasanje){
			boolean hasKurs = kurs != null;
			
			if (hasKurs){
				prikazID = kurs.getKursid();
			}else{
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
					if (request.getParameter(ime).equals("Predaji")){
						try{
							predajiID = Integer.parseInt(ime);
						}catch(Exception e){
							e.printStackTrace();
						}
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
			
			if (predajiID > -1){
				kurs = kursBean.getKurs(predajiID);
				User myUser = null;
				if ((myUser = kursBean.predaji(userBean.getMyUser(), kurs)) != null){
					userBean.setMyUser(myUser);
					prijava = "Uspesno predajete " + myUser.getUsername() + " kurs " + kurs.getNaziv();
				}else
					prijava = "Neuspesno ste se pokusali da predajete";
				
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
			List<Lekcija> lekcije = lekcijaBean.getLekcije(kurs);
			List<Test> testovi = testBean.getTestovi(kurs);
			
			String starDis = new String("");
			String disSub = new String("");
			String disLekcija = new String("");
			String[] arr = new String[20];
			
			boolean disabledSub = false;
			boolean starEnabled = false;
			boolean lekcijaEnable = false;
			boolean logged = userBean != null;
			
			if (logged){
				if (userBean.isPolaznik()){
					User myUser = userBean.getMyUser();
					for (Kurs k : kursBean.getKursevi(myUser)){
						if (k.getKursid() == kurs.getKursid()){
							disabledSub = true;
							starEnabled = true;
							lekcijaEnable = true;
							break;
						}
					}
				}
			}else{
				disabledSub = true;
				starEnabled = false;
				lekcijaEnable = false;
			}
			float sum = 0;
			float avg = 0;
			boolean glasao = false;
			List<Ocena> ocene = kursBean.getOcene(kurs, false);
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
			disLekcija = !lekcijaEnable ? "disabled":"";
			
			request.getSession().setAttribute("kurs", kurs);
			request.setAttribute("komentari", komentari);
			request.setAttribute("lekcije", lekcije);
			request.setAttribute("arr", arr);
			request.setAttribute("disSub", disSub);
			request.setAttribute("starDis", starDis);
			request.setAttribute("disLekcija", disLekcija);
			request.setAttribute("testovi", testovi);
			
			rd = getServletContext().getRequestDispatcher("/kurs.jsp");
		}
		rd.forward(request, response);
	}

}
