package beans;

import javax.ejb.Remote;

import model.User;

@Remote
public interface LoginBeanRemote {
	public User login(String username, String password);
	public boolean registerPredavac(String ime, String prezime, String username, String password);
}
