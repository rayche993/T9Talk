package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the prijava database table.
 * 
 */
@Entity
@NamedQuery(name="Prijava.findAll", query="SELECT p FROM Prijava p")
public class Prijava implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int prijavaid;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	//bi-directional many-to-one association to Kurs
	@ManyToOne
	@JoinColumn(name="KURSID")
	private Kurs kur;

	public Prijava() {
	}

	public int getPrijavaid() {
		return this.prijavaid;
	}

	public void setPrijavaid(int prijavaid) {
		this.prijavaid = prijavaid;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Kurs getKur() {
		return this.kur;
	}

	public void setKur(Kurs kur) {
		this.kur = kur;
	}

}