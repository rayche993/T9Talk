package beans;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import model.Komentar;
import model.Kurs;
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
    	
    	try{
    		em.persist(kurs);
    	}catch(Exception e){
    		e.printStackTrace();
    		return false;
    	}
    	
    	return true;
    }
    
    public User subscribeUser(User u, Kurs k){
    	k.getUsers2().add(u);
    	u.getKurs4().add(k);
    	
    	try{
    		em.merge(k);
    		em.merge(u);
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
    
    public List<Kurs> getKursevi(String pretraga){
    	List<Kurs> kursevi = null;
    	TypedQuery<Kurs> query = em.createQuery("SELECT k FROM Kurs k WHERE k.naziv LIKE :str", Kurs.class);
    	query.setParameter("str", "%" + pretraga + "%");
    	
    	try{
    		kursevi = query.getResultList();
    	}catch(NoResultException e){
    		return new ArrayList<Kurs>();
    	}
    	
    	return kursevi;
    }
}