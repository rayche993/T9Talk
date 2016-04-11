package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the user database table.
 * 
 */
@Entity
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int userid;

	private String ime;

	private String password;

	private String prezime;

	private String username;

	//bi-directional many-to-one association to Komentar
	@OneToMany(mappedBy="user")
	private List<Komentar> komentars;

	//bi-directional many-to-many association to Kurs
	@ManyToMany(mappedBy="users1")
	private List<Kurs> kurs1;

	//bi-directional many-to-many association to Kurs
	@ManyToMany(mappedBy="users2")
	private List<Kurs> kurs2;

	//bi-directional many-to-one association to Lekcija
	@OneToMany(mappedBy="user")
	private List<Lekcija> lekcijas;

	//bi-directional many-to-one association to Polaze
	@OneToMany(mappedBy="user")
	private List<Polaze> polazes;

	//bi-directional many-to-many association to Kurs
	@ManyToMany
	@JoinTable(
		name="predaje"
		, joinColumns={
			@JoinColumn(name="USERID")
			}
		, inverseJoinColumns={
			@JoinColumn(name="KURSID")
			}
		)
	private List<Kurs> kurs3;

	//bi-directional many-to-many association to Kurs
	@ManyToMany
	@JoinTable(
		name="prijavljen"
		, joinColumns={
			@JoinColumn(name="USERID")
			}
		, inverseJoinColumns={
			@JoinColumn(name="KURSID")
			}
		)
	private List<Kurs> kurs4;

	//bi-directional many-to-one association to UserRole
	@ManyToOne
	@JoinColumn(name="ROLEID")
	private UserRole userrole;

	public User() {
	}

	public int getUserid() {
		return this.userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public String getIme() {
		return this.ime;
	}

	public void setIme(String ime) {
		this.ime = ime;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPrezime() {
		return this.prezime;
	}

	public void setPrezime(String prezime) {
		this.prezime = prezime;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<Komentar> getKomentars() {
		return this.komentars;
	}

	public void setKomentars(List<Komentar> komentars) {
		this.komentars = komentars;
	}

	public Komentar addKomentar(Komentar komentar) {
		getKomentars().add(komentar);
		komentar.setUser(this);

		return komentar;
	}

	public Komentar removeKomentar(Komentar komentar) {
		getKomentars().remove(komentar);
		komentar.setUser(null);

		return komentar;
	}

	public List<Kurs> getKurs1() {
		return this.kurs1;
	}

	public void setKurs1(List<Kurs> kurs1) {
		this.kurs1 = kurs1;
	}

	public List<Kurs> getKurs2() {
		return this.kurs2;
	}

	public void setKurs2(List<Kurs> kurs2) {
		this.kurs2 = kurs2;
	}

	public List<Lekcija> getLekcijas() {
		return this.lekcijas;
	}

	public void setLekcijas(List<Lekcija> lekcijas) {
		this.lekcijas = lekcijas;
	}

	public Lekcija addLekcija(Lekcija lekcija) {
		getLekcijas().add(lekcija);
		lekcija.setUser(this);

		return lekcija;
	}

	public Lekcija removeLekcija(Lekcija lekcija) {
		getLekcijas().remove(lekcija);
		lekcija.setUser(null);

		return lekcija;
	}

	public List<Polaze> getPolazes() {
		return this.polazes;
	}

	public void setPolazes(List<Polaze> polazes) {
		this.polazes = polazes;
	}

	public Polaze addPolaze(Polaze polaze) {
		getPolazes().add(polaze);
		polaze.setUser(this);

		return polaze;
	}

	public Polaze removePolaze(Polaze polaze) {
		getPolazes().remove(polaze);
		polaze.setUser(null);

		return polaze;
	}

	public List<Kurs> getKurs3() {
		return this.kurs3;
	}

	public void setKurs3(List<Kurs> kurs3) {
		this.kurs3 = kurs3;
	}

	public List<Kurs> getKurs4() {
		return this.kurs4;
	}

	public void setKurs4(List<Kurs> kurs4) {
		this.kurs4 = kurs4;
	}

	public UserRole getUserrole() {
		return this.userrole;
	}

	public void setUserrole(UserRole userrole) {
		this.userrole = userrole;
	}

}