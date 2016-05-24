package beans;

import java.util.List;

import javax.ejb.Remote;

import model.Komentar;
import model.Kurs;
import model.Ocena;
import model.User;

@Remote
public interface KursBeanRemote {
	public boolean addKurs(String naziv, String opis, String ishod);
	public Kurs getKurs(int id);
	public List<Kurs> getKursevi();
	public List<Komentar> getKomentari(Kurs kurs);
	public boolean postComment(String tekst, Kurs kurs, User user);
	public List<Kurs> getKursevi(String pretraga, String parametar, User user);
	public User subscribeUser(User u, Kurs k);
	public boolean oceni(String ocena, Kurs kurs, User user);
	public List<Ocena> getOcene(Kurs kurs, boolean thisMonth);
	public List<Kurs> getKursevi(User user);
	
	public List<Kurs> getKurseviPredaje(User user);
	public User predaji(User u, Kurs k);
	public List<User> getPredavaci();
}
