package beans;

import javax.ejb.Remote;

import model.User;

@Remote
public interface UserBeanRemote {
	public User getMyUser();
	public void setMyUser(User myUser);
	public boolean isAdmin();
	public boolean isPredavac();
	public boolean isPolaznik();
	public void remove();
}
