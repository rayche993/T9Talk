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
import model.Ocena;
import model.User;

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
		
		String starDis = new String("");
		String disSub = new String("");
		String[] arr = new String[20];
		
		boolean disabledSub = false;
		boolean starEnabled = false;
		boolean logged = userBean != null;
		
		if (logged){
			if (userBean.isPolaznik()){
				User myUser = userBean.getMyUser();
				for (Kurs k : kursBean.getKursevi(myUser)){
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
		
		request.setAttribute("arr", arr);
		request.setAttribute("disSub", disSub);
		request.setAttribute("starDis", starDis);
		
		request.setAttribute("poruka", poruka);
		rd.forward(request, response);
	}
}