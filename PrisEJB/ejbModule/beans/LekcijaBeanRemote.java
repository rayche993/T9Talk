package beans;

import java.util.List;

import javax.ejb.Remote;

import model.Kurs;
import model.Lekcija;
import model.Odgovor;
import model.Pitanje;
import model.Test;
import model.User;

@Remote
public interface LekcijaBeanRemote {
	public boolean insertLekcija(String naziv, String tekst, User user, Kurs kurs);
	public List<Lekcija> getLekcije(Kurs kurs);
	public Lekcija getLekcija(int id);
	public boolean updateLekcija(Lekcija lekcija);
	public boolean saveTest(Test test, List<Pitanje> pitanja, List<Odgovor> odgovori);
}