package beans;

import java.util.List;

import javax.ejb.Remote;

import model.Komentar;
import model.Kurs;
import model.User;

@Remote
public interface KursBeanRemote {
	public boolean addKurs(String naziv, String opis, String ishod);
	public Kurs getKurs(int id);
	public List<Kurs> getKursevi();
	public List<Komentar> getKomentari(Kurs kurs);
	public boolean postComment(String tekst, Kurs kurs, User user);
	public List<Kurs> getKursevi(String pretraga, String parametar);
	public User subscribeUser(User u, Kurs k);
}
