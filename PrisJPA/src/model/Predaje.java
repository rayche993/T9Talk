package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the predaje database table.
 * 
 */
@Entity
@NamedQuery(name="Predaje.findAll", query="SELECT p FROM Predaje p")
public class Predaje implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int predajeid;

	//bi-directional many-to-one association to Kurs
	@ManyToOne
	@JoinColumn(name="KURSID")
	private Kurs kur;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	public Predaje() {
	}

	public int getPredajeid() {
		return this.predajeid;
	}

	public void setPredajeid(int predajeid) {
		this.predajeid = predajeid;
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