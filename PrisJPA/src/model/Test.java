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
	private int testid;

	private String naslov;

	private String opis;

	//bi-directional many-to-one association to Pitanje
	@OneToMany(mappedBy="test")
	private List<Pitanje> pitanjes;

	//bi-directional many-to-one association to Lekcija
	@ManyToOne
	@JoinColumn(name="LEKCIJAID")
	private Lekcija lekcija;

	//bi-directional many-to-one association to Uradio
	@OneToMany(mappedBy="test")
	private List<Uradio> uradios;

	public Test() {
	}

	public int getTestid() {
		return this.testid;
	}

	public void setTestid(int testid) {
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

	public Lekcija getLekcija() {
		return this.lekcija;
	}

	public void setLekcija(Lekcija lekcija) {
		this.lekcija = lekcija;
	}

	public List<Uradio> getUradios() {
		return this.uradios;
	}

	public void setUradios(List<Uradio> uradios) {
		this.uradios = uradios;
	}

	public Uradio addUradio(Uradio uradio) {
		getUradios().add(uradio);
		uradio.setTest(this);

		return uradio;
	}

	public Uradio removeUradio(Uradio uradio) {
		getUradios().remove(uradio);
		uradio.setTest(null);

		return uradio;
	}

}