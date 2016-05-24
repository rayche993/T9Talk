package beans;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import model.Kurs;
import model.Odgovor;
import model.Pitanje;
import model.Polozio;
import model.Test;
import model.Uradio;
import model.Uradioodgovor;
import model.User;

/**
 * Session Bean implementation class TestBean
 */
@Stateless
@LocalBean
public class TestBean implements TestBeanRemote, TestBeanLocal {

	@PersistenceContext
	EntityManager em;
	
    public TestBean() {
        // TODO Auto-generated constructor stub
    }
    
    //Cuva test u bazu
    public boolean saveTest(Test test, List<Pitanje> pitanja, List<Odgovor> odgovori){
    	try{
    		em.persist(test);
    	}catch(Exception e){
    		e.printStackTrace();
    		return false;
    	}
    	for (Pitanje p : pitanja){
	    	try{
	    		em.persist(p);
	    	}catch(Exception e){
	    		e.printStackTrace();
	    		return false;
	    	}
    	}
    	
    	for (Odgovor o : odgovori){
    		try{
    			em.persist(o);
    		}catch(Exception e){
    			e.printStackTrace();
    			return false;
    		}
    	}
    	
    	return true;
    }
    
    //Vraca test za dati ID
    public Test getTestForID(int id){
    	return em.find(Test.class, id);
    }
    
    public List<Pitanje> getPitanjaZaTest(Test test){
    	List<Pitanje> pitanja = null;
    	TypedQuery<Pitanje> query = em.createQuery("SELECT p FROM Pitanje p WHERE p.test = :testt", Pitanje.class);
    	query.setParameter("testt", test);
    	
    	try{
    		pitanja = query.getResultList();
    	}catch(Exception e){
    		return new ArrayList<Pitanje>();
    	}
    	
    	return pitanja;
    }
    
    //Vraca sve testove za kurs
    public List<Test> getTestovi(Kurs kurs){
    	List<Test> testovi = null;
    	TypedQuery<Test> query = em.createQuery("SELECT t FROM Test t WHERE t.kur = :kurs", Test.class);
    	query.setParameter("kurs", kurs);
    	
    	try{
    		testovi = query.getResultList();
    	}catch(NoResultException e){
    		return new ArrayList<Test>();
    	}
    	
    	return testovi;
    }
    
    public Odgovor getOdgovorZaID(String id){
    	return em.find(Odgovor.class, Integer.parseInt(id));
    }
    
    public int bodujPitanje(Pitanje pitanje, String[] odgovori){
    	int bodovi = 0;
    	if(pitanje.getTipodgovora()==1){
    		System.out.println("Trazim odgovor za tekstualno pitanje:"+pitanje.getText());
    		
    		return 0;
    	}else if(pitanje.getTipodgovora()==2){
    		System.out.println("Trazim odgovor za  pitanje sa jednim odgovorom:"+pitanje.getText()+" Odgovor : "+ this.getOdgovorZaID(odgovori[0]).getText());
    		bodovi = this.bodujOdgovor(pitanje, this.getOdgovorZaID(odgovori[0]));
    	}else if(pitanje.getTipodgovora()==3){
    		System.out.println("Trazim odgovor za  pitanje sa vise odgovora:"+pitanje.getText());
    		for(String odgovorID : odgovori){
    			System.out.println("ID odgovora su - "+odgovorID+" Tacan "+this.getOdgovorZaID(odgovorID).getTacan());
    		}
    		for(String odgovorID : odgovori){
    			bodovi = this.bodujOdgovor(pitanje, this.getOdgovorZaID(odgovorID));
    		}
    		if(bodovi<0)
    			return 0;
    		else
    			return bodovi;
    	}
    	return bodovi;
    }
    
    public int bodujOdgovor(Pitanje pitanje, Odgovor odgovor){
    	if(pitanje.getTipodgovora()==1){
    		return 0;
    	}else if((pitanje.getTipodgovora()==2)){
    		System.out.println("Proveravam odgovor za pitanje sa jednim odgovorom:"+odgovor.getText());
    		if(odgovor.getTacan()>0){
    			return 1;
    		}else
    			return 0;
    	}else if((pitanje.getTipodgovora()==3)){
    		System.out.println("Proveravam odgovor za pitanje sa vise odgovora:"+odgovor.getText());
    		if(odgovor.getTacan()>0){
    			return 1;
    		}else{
    			return -1;
    		}
    	}
    	return 0;
    }
    
    public void uradioTest(User user,Test test,float brbodova){
    	Uradio uradio = getUradio(test, user);
    	if(uradio != null){
    		uradio.setBrojbodova(brbodova);
    		try{
    			em.merge(uradio);
    			this.polozio(test.getKur(), user);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	}else{
    		uradio = new Uradio();
	    	uradio.setBrojbodova(brbodova);
	    	uradio.setUser(user);
	    	uradio.setTest(test);
	    	
	    	try {
				em.persist(uradio);
			} catch (Exception e) {
				e.printStackTrace();
			}
	    	this.polozio(test.getKur(), user);
    	}
    }
    
    
    public Uradio getUradio(Test test,User user){
    	try {
    		Uradio uradio;
			TypedQuery<Uradio> query = em.createQuery("SELECT u FROM Uradio u WHERE u.test = :test AND u.user = :user", Uradio.class);
			query.setParameter("test", test);
			query.setParameter("user", user);
			
			uradio = query.getSingleResult();
			if(uradio != null)
				return uradio;
			else 
				return null;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
    }
    
    public boolean proveriDalJePolozioKurs(User user, Kurs kurs){
    	boolean polozio = true;
    	List<Test> kursTestovi = getTestovi(kurs);
    	for(Test test : kursTestovi){
    		float maxBodova= getPitanjaZaTest(test).size();
    		Uradio uradio = getUradio(test, user);
    		if(uradio != null){
	    		if(maxBodova/uradio.getBrojbodova() < 0.4)
	    			polozio = false;
    		}else{
    			polozio = false;
    		}
    	}
    	return polozio;
    }

    public void polozio(Kurs kurs ,User user){
    	Polozio polozio = null;
    	TypedQuery<Polozio> query = em.createQuery("SELECT p FROM Polozio p WHERE p.kur = :kurs AND p.user = :user", Polozio.class);
    	query.setParameter("kurs", kurs);
		query.setParameter("user", user);
		try{
			polozio = query.getSingleResult();
		}catch(Exception e){
			polozio = null;
		}
    	if(proveriDalJePolozioKurs(user, kurs) && !(polozio != null)){
    		try{
    			polozio = new Polozio();
    			polozio.setKur(kurs);
    			polozio.setUser(user);
    			polozio.setOcena(6);
    			polozio.setProsek(3);
    			
    			em.persist(polozio);
    		}catch(Exception e){
    			e.printStackTrace();
    		}	
    	}
    }
    
    //Vraca osvojene bodove u procentima za dati test
    public float getBodovi(User user,Test test){
    	float bodovi = 0;
    	try{
    		Uradio uradio = getUradio(test, user);
    		bodovi = uradio.getBrojbodova()/getPitanjaZaTest(test).size();
    		return bodovi*100;
    	}catch(Exception e){
    		e.printStackTrace();
    		return 0;
    	}
    }
    
    //Deo koji sluzi za dobijanje tekstualnih odgovora
    
    public List<Uradio> uradioZaTest(Test test){
    	try{
    		List<Uradio> uradjeni = null;
    		TypedQuery<Uradio> query = em.createQuery("SELECT u FROM Uradio u WHERE u.test = :test", Uradio.class);
			query.setParameter("test", test);
			
			uradjeni = query.getResultList();
			return uradjeni;
    	}catch(Exception e){
    		return new ArrayList<Uradio>();
    	}
    }
    
    public List<Uradioodgovor> getUradioTekstualna(Uradio uradio){
    	try{
    		List<Uradioodgovor> uradjeni = null;
    		TypedQuery<Uradioodgovor> query = em.createQuery("SELECT u FROM Uradioodgovor u WHERE u.uradio = :uradio", Uradioodgovor.class);
			query.setParameter("uradio", uradio);
			
			uradjeni = query.getResultList();
			return uradjeni;
    	}catch(Exception e){
    		return new ArrayList<Uradioodgovor>();
    	}
    }
    
    public Uradio getUradioZaID(int id){
    	return em.find(Uradio.class, id);
    }
    
    public void noviTxtOdgovor(Uradio uradio, Pitanje pitanje,String text){
    	Uradioodgovor odgovor = null;
    	TypedQuery<Uradioodgovor> query = em.createQuery("SELECT u FROM Uradioodgovor u WHERE u.uradio = :uradio AND u.pitanje = :pitanje", Uradioodgovor.class);
    	query.setParameter("uradio", uradio);
    	query.setParameter("pitanje", pitanje);
    	try{
    		odgovor = query.getSingleResult();
    	}catch(Exception e){}
    	if(odgovor != null){
    		odgovor.setText(text);
    		em.merge(odgovor);
    	}else{
    		odgovor = new Uradioodgovor();
    		odgovor.setPitanje(pitanje);
    		odgovor.setUradio(uradio);
    		odgovor.setText(text);
    			
    		em.persist(odgovor);
    	}
    }
}
