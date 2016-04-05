package beans;

import javax.ejb.Remove;
import javax.ejb.Stateful;

import model.User;

/**
 * Session Bean implementation class UserBean
 */
@Stateful
public class UserBean implements UserBeanRemote, UserBeanLocal {
	private User myUser;
	
    /**
     * Default constructor. 
     */
    public UserBean() {
        // TODO Auto-generated constructor stub
    }

    public boolean isAdmin(){
    	return myUser.getUserrole().getOpis().equals("Admin");
    }
    
    public boolean isPredavac(){
    	return myUser.getUserrole().getOpis().equals("Predavac");
    }
    
    public boolean isPolaznik(){
    	return myUser.getUserrole().getOpis().equals("Polaznik");
    }
    
    @Remove
    public void remove(){
    	myUser = null;
    }
    
	public User getMyUser() {
		return myUser;
	}

	public void setMyUser(User myUser) {
		this.myUser = myUser;
	}
}
