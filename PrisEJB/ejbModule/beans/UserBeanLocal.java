package beans;

import javax.ejb.Local;

import model.User;

@Local
public interface UserBeanLocal {
	public User getMyUser();
	public void setMyUser(User myUser);
	public boolean isAdmin();
	public boolean isPredavac();
	public boolean isPolaznik();
	public void remove();
}
