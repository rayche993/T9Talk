package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the test database table.
 * 
 */
@Entity
@NamedQuery(name="Test.findAll", query="SELECT t FROM Test t")
public class Test implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String testid;

	private String naslov;

	private String opis;

	//bi-directional many-to-one association to Pitanje
	@OneToMany(mappedBy="test")
	private List<Pitanje> pitanjes;

	//bi-directional many-to-one association to Polaze
	@OneToMany(mappedBy="test")
	private List<Polaze> polazes;

	//bi-directional many-to-one association to Lekcija
	@ManyToOne
	@JoinColumn(name="LEKCIJAID")
	private Lekcija lekcija;

	public Test() {
	}

	public String getTestid() {
		return this.testid;
	}

	public void setTestid(String testid) {
		this.testid = testid;
	}

	public String getNaslov() {
		return this.naslov;
	}

	public void setNaslov(String naslov) {
		this.naslov = naslov;
	}

	public String getOpis() {
		return this.opis;
	}

	public void setOpis(String opis) {
		this.opis = opis;
	}

	public List<Pitanje> getPitanjes() {
		return this.pitanjes;
	}

	public void setPitanjes(List<Pitanje> pitanjes) {
		this.pitanjes = pitanjes;
	}

	public Pitanje addPitanje(Pitanje pitanje) {
		getPitanjes().add(pitanje);
		pitanje.setTest(this);

		return pitanje;
	}

	public Pitanje removePitanje(Pitanje pitanje) {
		getPitanjes().remove(pitanje);
		pitanje.setTest(null);

		return pitanje;
	}

	public List<Polaze> getPolazes() {
		return this.polazes;
	}

	public void setPolazes(List<Polaze> polazes) {
		this.polazes = polazes;
	}

	public Polaze addPolaze(Polaze polaze) {
		getPolazes().add(polaze);
		polaze.setTest(this);

		return polaze;
	}

	public Polaze removePolaze(Polaze polaze) {
		getPolazes().remove(polaze);
		polaze.setTest(null);

		return polaze;
	}

	public Lekcija getLekcija() {
		return this.lekcija;
	}

	public void setLekcija(Lekcija lekcija) {
		this.lekcija = lekcija;
	}

}