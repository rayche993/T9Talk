package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the polozio database table.
 * 
 */
@Entity
@NamedQuery(name="Polozio.findAll", query="SELECT p FROM Polozio p")
public class Polozio implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int polozioid;

	private int ocena;

	private float prosek;

	//bi-directional many-to-one association to Kurs
	@ManyToOne
	@JoinColumn(name="KURSID")
	private Kurs kur;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	public Polozio() {
	}

	public int getPolozioid() {
		return this.polozioid;
	}

	public void setPolozioid(int polozioid) {
		this.polozioid = polozioid;
	}

	public int getOcena() {
		return this.ocena;
	}

	public void setOcena(int ocena) {
		this.ocena = ocena;
	}

	public float getProsek() {
		return this.prosek;
	}

	public void setProsek(float prosek) {
		this.prosek = prosek;
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