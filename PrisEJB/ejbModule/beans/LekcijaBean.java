package beans;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import model.Kurs;
import model.Lekcija;
import model.Odgovor;
import model.Pitanje;
import model.Test;
import model.User;

/**
 * Session Bean implementation class LekcijaBean
 */
@Stateless
public class LekcijaBean implements LekcijaBeanRemote, LekcijaBeanLocal {
	@PersistenceContext
	EntityManager em;
	
    /**
     * Default constructor. 
     */
    public LekcijaBean() {
        // TODO Auto-generated constructor stub
    }

    public boolean updateLekcija(Lekcija lekcija){
    	try{
    		lekcija = em.merge(lekcija);
    	}catch(Exception e){
    		return false;
    	}
    	return true;
    }
    
    public boolean insertLekcija(String naziv, String tekst, User user, Kurs kurs){
    	Lekcija lekcija = new Lekcija();
    	lekcija.setNaziv(naziv);
    	lekcija.setText(tekst);
    	lekcija.setTiplekcije(0);
    	lekcija.setKur(kurs);
    	lekcija.setUser(user);
    	
    	try{
    		em.persist(lekcija);
    	}catch(Exception e){
    		return false;
    	}
    	return true;
    }
    
    public List<Lekcija> getLekcije(Kurs kurs){
    	List<Lekcija> lekcije = null;
    	TypedQuery<Lekcija> query = em.createQuery("SELECT l FROM Lekcija l WHERE l.kur = :kurs", Lekcija.class);
    	query.setParameter("kurs", kurs);
    	
    	try{
    		lekcije = query.getResultList();
    	}catch(NoResultException e){
    		return new ArrayList<Lekcija>();
    	}
    	
    	return lekcije;
    }
    
    public Lekcija getLekcija(int id){
    	return em.find(Lekcija.class, id);
    }
    
    
}