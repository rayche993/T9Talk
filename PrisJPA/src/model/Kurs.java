package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the kurs database table.
 * 
 */
@Entity
@NamedQuery(name="Kurs.findAll", query="SELECT k FROM Kurs k")
public class Kurs implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int kursid;

	private String ishod;

	private String naziv;

	private String opis;

	//bi-directional many-to-one association to Komentar
	@OneToMany(mappedBy="kur")
	private List<Komentar> komentars;

	//bi-directional many-to-one association to Lekcija
	@OneToMany(mappedBy="kur")
	private List<Lekcija> lekcijas;

	//bi-directional many-to-one association to Ocena
	@OneToMany(mappedBy="kur")
	private List<Ocena> ocenas;

	//bi-directional many-to-one association to Polozio
	@OneToMany(mappedBy="kur")
	private List<Polozio> polozios;

	//bi-directional many-to-one association to Predaje
	@OneToMany(mappedBy="kur")
	private List<Predaje> predajes;

	//bi-directional many-to-one association to Prijava
	@OneToMany(mappedBy="kur")
	private List<Prijava> prijavas;

	//bi-directional many-to-one association to Test
	@OneToMany(mappedBy="kur")
	private List<Test> tests;

	public Kurs() {
	}

	public int getKursid() {
		return this.kursid;
	}

	public void setKursid(int kursid) {
		this.kursid = kursid;
	}

	public String getIshod() {
		return this.ishod;
	}

	public void setIshod(String ishod) {
		this.ishod = ishod;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getOpis() {
		return this.opis;
	}

	public void setOpis(String opis) {
		this.opis = opis;
	}

	public List<Komentar> getKomentars() {
		return this.komentars;
	}

	public void setKomentars(List<Komentar> komentars) {
		this.komentars = komentars;
	}

	public Komentar addKomentar(Komentar komentar) {
		getKomentars().add(komentar);
		komentar.setKur(this);

		return komentar;
	}

	public Komentar removeKomentar(Komentar komentar) {
		getKomentars().remove(komentar);
		komentar.setKur(null);

		return komentar;
	}

	public List<Lekcija> getLekcijas() {
		return this.lekcijas;
	}

	public void setLekcijas(List<Lekcija> lekcijas) {
		this.lekcijas = lekcijas;
	}

	public Lekcija addLekcija(Lekcija lekcija) {
		getLekcijas().add(lekcija);
		lekcija.setKur(this);

		return lekcija;
	}

	public Lekcija removeLekcija(Lekcija lekcija) {
		getLekcijas().remove(lekcija);
		lekcija.setKur(null);

		return lekcija;
	}

	public List<Ocena> getOcenas() {
		return this.ocenas;
	}

	public void setOcenas(List<Ocena> ocenas) {
		this.ocenas = ocenas;
	}

	public Ocena addOcena(Ocena ocena) {
		getOcenas().add(ocena);
		ocena.setKur(this);

		return ocena;
	}

	public Ocena removeOcena(Ocena ocena) {
		getOcenas().remove(ocena);
		ocena.setKur(null);

		return ocena;
	}

	public List<Polozio> getPolozios() {
		return this.polozios;
	}

	public void setPolozios(List<Polozio> polozios) {
		this.polozios = polozios;
	}

	public Polozio addPolozio(Polozio polozio) {
		getPolozios().add(polozio);
		polozio.setKur(this);

		return polozio;
	}

	public Polozio removePolozio(Polozio polozio) {
		getPolozios().remove(polozio);
		polozio.setKur(null);

		return polozio;
	}

	public List<Predaje> getPredajes() {
		return this.predajes;
	}

	public void setPredajes(List<Predaje> predajes) {
		this.predajes = predajes;
	}

	public Predaje addPredaje(Predaje predaje) {
		getPredajes().add(predaje);
		predaje.setKur(this);

		return predaje;
	}

	public Predaje removePredaje(Predaje predaje) {
		getPredajes().remove(predaje);
		predaje.setKur(null);

		return predaje;
	}

	public List<Prijava> getPrijavas() {
		return this.prijavas;
	}

	public void setPrijavas(List<Prijava> prijavas) {
		this.prijavas = prijavas;
	}

	public Prijava addPrijava(Prijava prijava) {
		getPrijavas().add(prijava);
		prijava.setKur(this);

		return prijava;
	}

	public Prijava removePrijava(Prijava prijava) {
		getPrijavas().remove(prijava);
		prijava.setKur(null);

		return prijava;
	}

	public List<Test> getTests() {
		return this.tests;
	}

	public void setTests(List<Test> tests) {
		this.tests = tests;
	}

	public Test addTest(Test test) {
		getTests().add(test);
		test.setKur(this);

		return test;
	}

	public Test removeTest(Test test) {
		getTests().remove(test);
		test.setKur(null);

		return test;
	}

}