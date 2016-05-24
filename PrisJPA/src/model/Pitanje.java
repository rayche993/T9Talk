package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the pitanje database table.
 * 
 */
@Entity
@NamedQuery(name="Pitanje.findAll", query="SELECT p FROM Pitanje p")
public class Pitanje implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int pitanjeid;

	@Lob
	private String text;

	private int tipodgovora;

	//bi-directional many-to-one association to Odgovor
	@OneToMany(mappedBy="pitanje",fetch = FetchType.EAGER ,cascade = CascadeType.ALL)
	private List<Odgovor> odgovors;

	//bi-directional many-to-one association to Test
	@ManyToOne
	@JoinColumn(name="TESTID")
	private Test test;

	//bi-directional many-to-one association to Uradioodgovor
	@OneToMany(mappedBy="pitanje")
	private List<Uradioodgovor> uradioodgovors;

	public Pitanje() {
	}

	public int getPitanjeid() {
		return this.pitanjeid;
	}

	public void setPitanjeid(int pitanjeid) {
		this.pitanjeid = pitanjeid;
	}

	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getTipodgovora() {
		return this.tipodgovora;
	}

	public void setTipodgovora(int tipodgovora) {
		this.tipodgovora = tipodgovora;
	}

	public List<Odgovor> getOdgovors() {
		return this.odgovors;
	}

	public void setOdgovors(List<Odgovor> odgovors) {
		this.odgovors = odgovors;
	}

	public Odgovor addOdgovor(Odgovor odgovor) {
		getOdgovors().add(odgovor);
		odgovor.setPitanje(this);

		return odgovor;
	}

	public Odgovor removeOdgovor(Odgovor odgovor) {
		getOdgovors().remove(odgovor);
		odgovor.setPitanje(null);

		return odgovor;
	}

	public Test getTest() {
		return this.test;
	}

	public void setTest(Test test) {
		this.test = test;
	}

	public List<Uradioodgovor> getUradioodgovors() {
		return this.uradioodgovors;
	}

	public void setUradioodgovors(List<Uradioodgovor> uradioodgovors) {
		this.uradioodgovors = uradioodgovors;
	}

	public Uradioodgovor addUradioodgovor(Uradioodgovor uradioodgovor) {
		getUradioodgovors().add(uradioodgovor);
		uradioodgovor.setPitanje(this);

		return uradioodgovor;
	}

	public Uradioodgovor removeUradioodgovor(Uradioodgovor uradioodgovor) {
		getUradioodgovors().remove(uradioodgovor);
		uradioodgovor.setPitanje(null);

		return uradioodgovor;
	}

}