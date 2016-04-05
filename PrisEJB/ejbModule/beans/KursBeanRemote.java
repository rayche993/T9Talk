package beans;

import javax.ejb.Remote;

@Remote
public interface KursBeanRemote {
	public boolean addKurs(String naziv, String opis, String ishod);
}
