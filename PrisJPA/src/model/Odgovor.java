package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the odgovor database table.
 * 
 */
@Entity
@NamedQuery(name="Odgovor.findAll", query="SELECT o FROM Odgovor o")
public class Odgovor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String odgovorid;

	private byte tacan;

	@Lob
	private String text;

	//bi-directional many-to-one association to Pitanje
	@ManyToOne
	@JoinColumn(name="PITANJEID")
	private Pitanje pitanje;

	public Odgovor() {
	}

	public String getOdgovorid() {
		return this.odgovorid;
	}

	public void setOdgovorid(String odgovorid) {
		this.odgovorid = odgovorid;
	}

	public byte getTacan() {
		return this.tacan;
	}

	public void setTacan(byte tacan) {
		this.tacan = tacan;
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

}