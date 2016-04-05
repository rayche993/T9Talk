package beans;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import model.Kurs;

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
}