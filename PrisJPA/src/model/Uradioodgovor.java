package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the uradioodgovor database table.
 * 
 */
@Entity
@NamedQuery(name="Uradioodgovor.findAll", query="SELECT u FROM Uradioodgovor u")
public class Uradioodgovor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int uradioodgovorid;

	private String text;

	//bi-directional many-to-one association to Pitanje
	@ManyToOne
	@JoinColumn(name="PITANJEID")
	private Pitanje pitanje;

	//bi-directional many-to-one association to Uradio
	@ManyToOne
	@JoinColumn(name="URADIOID")
	private Uradio uradio;

	public Uradioodgovor() {
	}

	public int getUradioodgovorid() {
		return this.uradioodgovorid;
	}

	public void setUradioodgovorid(int uradioodgovorid) {
		this.uradioodgovorid = uradioodgovorid;
	}

	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Pitanje getPitanje() {
		return this.pitanje;
	}

	public void setPitanje(Pitanje pitanje) {
		this.pitanje = pitanje;
	}

	public Uradio getUradio() {
		return this.uradio;
	}

	public void setUradio(Uradio uradio) {
		this.uradio = uradio;
	}

}