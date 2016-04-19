package servlets;

import java.io.IOException;
import java.util.Enumeration;

import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.LekcijaBeanLocal;
import beans.UserBeanRemote;
import model.Kurs;
import model.Lekcija;

/**
 * Servlet implementation class AddLekcijaServlet
 */
@WebServlet("/AddLekcijaServlet")
public class AddLekcijaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddLekcijaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    @EJB
    LekcijaBeanLocal lekcijaBean;
    
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
		Kurs kurs = (Kurs)request.getSession().getAttribute("kurs");
		Lekcija lekcija = null;
		RequestDispatcher rd = null;
		UserBeanRemote userBean = (UserBeanRemote) request.getSession().getAttribute("user");
		
		int prikazID = -1;
		int editID = -1;
		
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
			if (request.getParameter(ime).equals("Izmeni")){
				try{
					editID = Integer.parseInt(ime);
				}catch(Exception e){
					e.printStackTrace();
				}
			}
		}
		
		if (prikazID > -1){
			lekcija = lekcijaBean.getLekcija(prikazID);
		}else{
			lekcija = lekcijaBean.getLekcija(editID);
			
			request.setAttribute("lekcija", lekcija);
			request.setAttribute("naziv", lekcija.getNaziv());
			request.setAttribute("text", lekcija.getText());
			request.setAttribute("id", lekcija.getLekcijaid());
			rd = getServletContext().getRequestDispatcher("/add-lekcija.jsp");
		}
		
		rd.forward(request, response);
	}

}
