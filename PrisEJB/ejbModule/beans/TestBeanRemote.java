package beans;

import java.util.List;

import javax.ejb.Remote;

import model.Kurs;
import model.Odgovor;
import model.Pitanje;
import model.Test;
import model.Uradio;
import model.Uradioodgovor;
import model.User;

@Remote
public interface TestBeanRemote {

	public boolean saveTest(Test test, List<Pitanje> pitanja, List<Odgovor> odgovori);
	public Test getTestForID(int id);
	public List<Test> getTestovi(Kurs kurs);
	public List<Pitanje> getPitanjaZaTest(Test test);
	public Odgovor getOdgovorZaID(String id);
	public int bodujPitanje(Pitanje pitanje, String[] odgovori);
	
	public void uradioTest(User user,Test test,float brbodova);
	public Uradio getUradio(Test test,User user);
	public boolean proveriDalJePolozioKurs(User user, Kurs kurs);
	public void polozio(Kurs kurs ,User user);
	
	public float getBodovi(User user,Test test);
	public List<Uradio> uradioZaTest(Test test);
	public List<Uradioodgovor> getUradioTekstualna(Uradio uradio);
	public Uradio getUradioZaID(int id);
	public void noviTxtOdgovor(Uradio uradio, Pitanje pitanje,String text);
}
