package beans;

import java.util.ArrayList;
import java.util.List;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

import model.Kurs;
import model.User;
import model.UserRole;

/**
 * Session Bean implementation class LoginBean
 */
@Stateless
public class LoginBean implements LoginBeanRemote, LoginBeanLocal {

	@PersistenceContext
	EntityManager em;
	
    /**
     * Default constructor. 
     */
    public LoginBean() {
    }
    
    public User login(String username, String password){
    	TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :user", User.class);
    	query.setParameter("user", username);
    	User user = null;
    	
    	try{
    		user = query.getSingleResult();
    	}catch(NoResultException e){
    		return null;
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    	
    	return user.getPassword().equals(password) ? user : null;
    }
    
    public boolean isAllreadyRegistred(String username){
    	TypedQuery<User> query = em.createQuery("SELECT u FROM User u WHERE u.username = :user", User.class);
    	query.setParameter("user", username);
    	
    	User user = null;
    	
    	try{
    		user = query.getSingleResult();
    	}catch(NoResultException e){
    		return false;
    	}
    	
    	return true;
    }
    
    public boolean registerPredavac(String ime, String prezime, String username, String password){
    	if (isAllreadyRegistred(username))
    		return false;
    	
    	TypedQuery<UserRole> query = em.createQuery("SELECT r FROM UserRole r WHERE r.opis = :opis", UserRole.class);
    	query.setParameter("opis", "Predavac");
    	
    	UserRole ur = null;
    	if (query.getSingleResult() != null)
    		ur = query.getSingleResult();
    	else
    		return false;
    	
    	User user = new User();
    	user.setIme(ime);
    	user.setPrezime(prezime);
    	user.setUsername(username);
    	user.setPassword(password);
    	user.setUserrole(ur);
    	
    	try{
    		em.persist(user);
    	}catch(Exception e){
    		e.printStackTrace();
    		return false;
    	}
    	
    	return true;
    }
    
    public User registerUser(String ime, String prezime, String username, String password, String role){
    	if (isAllreadyRegistred(username))
    		return null;
    	
    	TypedQuery<UserRole> query = em.createQuery("SELECT r FROM UserRole r WHERE r.opis = :opis", UserRole.class);
    	query.setParameter("opis", role);
    	
    	UserRole ur = null;
    	
    	try{
    		ur = query.getSingleResult();
    	}catch(NoResultException e){
    		return null;
    	}
    	
    	User user = new User();
    	user.setIme(ime);
    	user.setPrezime(prezime);
    	user.setUsername(username);
    	user.setPassword(password);
    	user.setUserrole(ur);
    	
    	try{
    		em.persist(user);
    	}catch(Exception e){
    		e.printStackTrace();
    		return null;
    	}
    	
    	return user;
    }
}