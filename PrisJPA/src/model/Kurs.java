package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the kurs database table.
 * 
 */
@Entity
@NamedQuery(name="Kurs.findAll", query="SELECT k FROM Kurs k")
public class Kurs implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private String kursid;

	private String ishod;

	private String naziv;

	private String opis;

	//bi-directional many-to-many association to User
	@ManyToMany
	@JoinTable(
		name="predaje"
		, joinColumns={
			@JoinColumn(name="KURSID")
			}
		, inverseJoinColumns={
			@JoinColumn(name="USERID")
			}
		)
	private List<User> users1;

	//bi-directional many-to-many association to User
	@ManyToMany
	@JoinTable(
		name="prijavljen"
		, joinColumns={
			@JoinColumn(name="KURSID")
			}
		, inverseJoinColumns={
			@JoinColumn(name="USERID")
			}
		)
	private List<User> users2;

	//bi-directional many-to-one association to Lekcija
	@OneToMany(mappedBy="kur")
	private List<Lekcija> lekcijas;

	//bi-directional many-to-many association to User
	@ManyToMany(mappedBy="kurs3")
	private List<User> users3;

	//bi-directional many-to-many association to User
	@ManyToMany(mappedBy="kurs4")
	private List<User> users4;

	public Kurs() {
	}

	public String getKursid() {
		return this.kursid;
	}

	public void setKursid(String kursid) {
		this.kursid = kursid;
	}

	public String getIshod() {
		return this.ishod;
	}

	public void setIshod(String ishod) {
		this.ishod = ishod;
	}

	public String getNaziv() {
		return this.naziv;
	}

	public void setNaziv(String naziv) {
		this.naziv = naziv;
	}

	public String getOpis() {
		return this.opis;
	}

	public void setOpis(String opis) {
		this.opis = opis;
	}

	public List<User> getUsers1() {
		return this.users1;
	}

	public void setUsers1(List<User> users1) {
		this.users1 = users1;
	}

	public List<User> getUsers2() {
		return this.users2;
	}

	public void setUsers2(List<User> users2) {
		this.users2 = users2;
	}

	public List<Lekcija> getLekcijas() {
		return this.lekcijas;
	}

	public void setLekcijas(List<Lekcija> lekcijas) {
		this.lekcijas = lekcijas;
	}

	public Lekcija addLekcija(Lekcija lekcija) {
		getLekcijas().add(lekcija);
		lekcija.setKur(this);

		return lekcija;
	}

	public Lekcija removeLekcija(Lekcija lekcija) {
		getLekcijas().remove(lekcija);
		lekcija.setKur(null);

		return lekcija;
	}

	public List<User> getUsers3() {
		return this.users3;
	}

	public void setUsers3(List<User> users3) {
		this.users3 = users3;
	}

	public List<User> getUsers4() {
		return this.users4;
	}

	public void setUsers4(List<User> users4) {
		this.users4 = users4;
	}

}