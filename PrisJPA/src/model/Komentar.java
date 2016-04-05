package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the komentar database table.
 * 
 */
@Entity
@NamedQuery(name="Komentar.findAll", query="SELECT k FROM Komentar k")
public class Komentar implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String komentarid;

	private String opis;

	//bi-directional many-to-one association to Lekcija
	@ManyToOne
	@JoinColumn(name="LEKCIJAID")
	private Lekcija lekcija;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	public Komentar() {
	}

	public String getKomentarid() {
		return this.komentarid;
	}

	public void setKomentarid(String komentarid) {
		this.komentarid = komentarid;
	}

	public String getOpis() {
		return this.opis;
	}

	public void setOpis(String opis) {
		this.opis = opis;
	}

	public Lekcija getLekcija() {
		return this.lekcija;
	}

	public void setLekcija(Lekcija lekcija) {
		this.lekcija = lekcija;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}