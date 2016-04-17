package model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


/**
 * The persistent class for the ocena database table.
 * 
 */
@Entity
@NamedQuery(name="Ocena.findAll", query="SELECT o FROM Ocena o")
public class Ocena implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int ocenaid;

	private Date datum;

	private String opis;

	//bi-directional many-to-one association to Kurs
	@ManyToOne
	@JoinColumn(name="KURSID")
	private Kurs kur;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	public Ocena() {
	}

	public int getOcenaid() {
		return this.ocenaid;
	}

	public void setOcenaid(int ocenaid) {
		this.ocenaid = ocenaid;
	}

	public Date getDatum() {
		return this.datum;
	}

	public void setDatum(Date datum) {
		this.datum = datum;
	}

	public String getOpis() {
		return this.opis;
	}

	public void setOpis(String opis) {
		this.opis = opis;
	}

	public Kurs getKur() {
		return this.kur;
	}

	public void setKur(Kurs kur) {
		this.kur = kur;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}