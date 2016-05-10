package beans;

import java.util.List;

import javax.ejb.Local;

import model.Kurs;
import model.Lekcija;
import model.Odgovor;
import model.Pitanje;
import model.Test;
import model.User;

@Local
public interface LekcijaBeanLocal {
	public boolean insertLekcija(String naziv, String tekst, User user, Kurs kurs);
	public List<Lekcija> getLekcije(Kurs kurs);
	public Lekcija getLekcija(int id);
	public boolean updateLekcija(Lekcija lekcija);
	public boolean saveTest(Test test, List<Pitanje> pitanja, List<Odgovor> odgovori);
}