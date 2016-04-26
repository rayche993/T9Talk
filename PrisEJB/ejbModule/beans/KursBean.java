package beans;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import model.Komentar;
import model.Kurs;
import model.Ocena;
import model.User;

/**
 * Session Bean implementation class KursBean
 */
@Stateless
public class KursBean implements KursBeanRemote, KursBeanLocal {
	@PersistenceContext
	EntityManager em;
	
    /**
     * Default constructor. 
     */
    public KursBean() {
        // TODO Auto-generated constructor stub
    }
    
    public boolean addKurs(String naziv, String opis, String ishod){
    	Kurs kurs = new Kurs();
    	kurs.setNaziv(naziv);
    	kurs.setIshod(ishod);
    	kurs.setOpis(opis);
    	kurs.setUsers2(new ArrayList<User>());
    	
    	try{
    		em.persist(kurs);
    	}catch(Exception e){
    		e.printStackTrace();
    		return false;
    	}
    	
    	return true;
    }
    
    public User subscribeUser(User u, Kurs k){
    	u.getKurs4().add(k);
    	
    	try{
    		u = em.merge(u);
    	}catch(Exception e){
    		e.printStackTrace();
    		return null;
    	}
    	return u;
    }
    
    public Kurs getKurs(int id){
    	return em.find(Kurs.class, id);
    }
    
    public List<Kurs> getKursevi(){
    	TypedQuery<Kurs> query = em.createQuery("SELECT k FROM Kurs k", Kurs.class);
    	List<Kurs> kursevi = null;
    	
    	try{
    		kursevi = query.getResultList();
    	}catch(NoResultException e){
    		return null;
    	}
    	return kursevi;
    }
    
    public List<Ocena> getOcene(Kurs kurs, boolean thisMonth){
    	List<Ocena> ocene = null;
    	if (thisMonth){
	    	TypedQuery<Ocena> query = em.createQuery("SELECT o FROM Ocena o WHERE o.kur = :kurs AND o.datum >= :datum", Ocena.class);
	    	query.setParameter("kurs", kurs);
	    	
	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    	Calendar cal = sdf.getCalendar();
	    	cal.setTime(new Date());
	    	cal.add(Calendar.MONTH, -1);
	    	Date datum = cal.getTime();
	    	
	    	query.setParameter("datum", datum);
	    	
	    	try{
	    		ocene = query.getResultList();
	    	}catch(NoResultException e){
	    		return null;
	    	}
    	}else{
    		TypedQuery<Ocena> query = em.createQuery("SELECT o FROM Ocena o WHERE o.kur = :kurs", Ocena.class);
	    	query.setParameter("kurs", kurs);
	    	
	    	try{
	    		ocene = query.getResultList();
	    	}catch(NoResultException e){
	    		return null;
	    	}
    	}
    	return ocene;
    }
    
    public boolean oceni(String ocena, Kurs kurs, User user){
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	Date datum = new Date();
    	
    	try {
			datum = sdf.parse(sdf.format(datum));
		} catch (ParseException e1) {
			return false;
		}
    	
    	Ocena o = new Ocena();
    	o.setDatum(datum);
    	o.setKur(kurs);
    	o.setUser(user);
    	o.setOpis(ocena);
    	
    	try{
    		em.persist(o);
    	}catch(Exception e){
    		return false;
    	}
    	
    	return true;
    }
    
    public List<Komentar> getKomentari(Kurs kurs){
    	TypedQuery<Komentar> query = em.createQuery("SELECT k FROM Komentar k WHERE k.kur = :kurs", Komentar.class);
    	query.setParameter("kurs", kurs);
    	
    	List<Komentar> komentari = null;
    	
    	try{
    		komentari = query.getResultList();
    	}catch(NoResultException e){
    		return null;
    	}
    	
    	return komentari;
    }
    
    public boolean postComment(String tekst, Kurs kurs, User user){
    	Komentar komentar = new Komentar();
    	komentar.setKur(kurs);
    	komentar.setOpis(tekst);
    	komentar.setUser(user);
    	
    	try{
    		em.persist(komentar);
    	}catch(Exception e){
    		e.printStackTrace();
    		return false;
    	}
    	return true;
    }
    
    public List<Kurs> getKursevi(String pretraga, String parametar){
    	List<Kurs> kursevi = null;
    	
    	String polje = null;
    	switch(parametar){
	    	case "Naziv": polje = "naziv"; break;
	    	case "Opis": polje = "opis"; break;
	    	case "Ishod": polje = "ishod"; break;
	    	case "Top_Kursevi": polje = "Top_Kursevi"; break;
	    	default : polje = ""; break;
    	}
    	
    	if (!polje.equals("Top_Kursevi")){
	    	TypedQuery<Kurs> query = em.createQuery("SELECT k FROM Kurs k WHERE k." + polje + " LIKE :str", Kurs.class);
	    	query.setParameter("str", "%" + pretraga + "%");
	    	
	    	try{
	    		kursevi = query.getResultList();
	    	}catch(NoResultException e){
	    		return new ArrayList<Kurs>();
	    	}
    	}else{
    		TypedQuery<Kurs> query = em.createQuery("SELECT k FROM Kurs k", Kurs.class);
    		try{
    			kursevi = query.getResultList();
    			Comparator<Kurs> comp = new Comparator<Kurs>(){
    				@Override
    				public int compare(Kurs k1, Kurs k2) {
    					float avg1 = getAvg(k1);
    					float avg2 = getAvg(k2);
    					
    					if (avg1 > avg2)
    						return -1;
    					else if (avg1 == avg2)
    						return 0;
    					else
    						return 1;
    				}
    			};
    			Collections.sort(kursevi, comp);
    		}catch(NoResultException e){
    			return new ArrayList<Kurs>();
    		}
    	}
    	return kursevi;
    }
    
    private float getAvg(Kurs k){
    	float sum = 0;
    	for (Ocena o : getOcene(k, true)){
    		sum += Float.parseFloat(o.getOpis());
    	}
    	if (k.getOcenas().size() > 0){
    		return sum / k.getOcenas().size();
    	}else
    		return 0;
    }
}