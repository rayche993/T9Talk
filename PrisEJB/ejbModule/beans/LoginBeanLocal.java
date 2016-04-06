package beans;

import javax.ejb.Local;

import model.User;

@Local
public interface LoginBeanLocal {
	public User login(String username, String password);
	public User registerUser(String ime, String prezime, String username, String password, String role);
}
