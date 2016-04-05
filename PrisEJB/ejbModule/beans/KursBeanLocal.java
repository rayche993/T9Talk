package beans;

import javax.ejb.Local;

@Local
public interface KursBeanLocal {
	public boolean addKurs(String naziv, String opis, String ishod);
}
