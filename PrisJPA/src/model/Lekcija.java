package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the lekcija database table.
 * 
 */
@Entity
@NamedQuery(name="Lekcija.findAll", query="SELECT l FROM Lekcija l")
public class Lekcija implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int lekcijaid;

	private String naziv;

	@Lob
	private String text;

	private int tiplekcije;

	//bi-directional many-to-one association to Kurs
	@ManyToOne
	@JoinColumn(name="KURSID")
	private Kurs kur;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	public Lekcija() {
	}

	public int getLekcijaid() {
		return this.lekcijaid;
	}

	public void setLekcijaid(int lekcijaid) {
		this.lekcijaid = lekcijaid;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getTiplekcije() {
		return this.tiplekcije;
	}

	public void setTiplekcije(int tiplekcije) {
		this.tiplekcije = tiplekcije;
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