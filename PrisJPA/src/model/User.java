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

	//bi-directional many-to-one association to Lekcija
	@OneToMany(mappedBy="user")
	private List<Lekcija> lekcijas;

	//bi-directional many-to-one association to Ocena
	@OneToMany(mappedBy="user")
	private List<Ocena> ocenas;

	//bi-directional many-to-one association to Predaje
	@OneToMany(mappedBy="user")
	private List<Predaje> predajes;

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
	private List<Kurs> kurs2;

	//bi-directional many-to-one association to UserRole
	@ManyToOne
	@JoinColumn(name="ROLEID")
	private UserRole userrole;

	//bi-directional many-to-one association to Polozio
	@OneToMany(mappedBy="user")
	private List<Polozio> polozios;

	//bi-directional many-to-one association to Prijava
	@OneToMany(mappedBy="user")
	private List<Prijava> prijavas;

	//bi-directional many-to-one association to Uradio
	@OneToMany(mappedBy="user")
	private List<Uradio> uradios;

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

	public List<Ocena> getOcenas() {
		return this.ocenas;
	}

	public void setOcenas(List<Ocena> ocenas) {
		this.ocenas = ocenas;
	}

	public Ocena addOcena(Ocena ocena) {
		getOcenas().add(ocena);
		ocena.setUser(this);

		return ocena;
	}

	public Ocena removeOcena(Ocena ocena) {
		getOcenas().remove(ocena);
		ocena.setUser(null);

		return ocena;
	}

	public List<Predaje> getPredajes() {
		return this.predajes;
	}

	public void setPredajes(List<Predaje> predajes) {
		this.predajes = predajes;
	}

	public Predaje addPredaje(Predaje predaje) {
		getPredajes().add(predaje);
		predaje.setUser(this);

		return predaje;
	}

	public Predaje removePredaje(Predaje predaje) {
		getPredajes().remove(predaje);
		predaje.setUser(null);

		return predaje;
	}

	public List<Kurs> getKurs2() {
		return this.kurs2;
	}

	public void setKurs2(List<Kurs> kurs2) {
		this.kurs2 = kurs2;
	}

	public UserRole getUserrole() {
		return this.userrole;
	}

	public void setUserrole(UserRole userrole) {
		this.userrole = userrole;
	}

	public List<Polozio> getPolozios() {
		return this.polozios;
	}

	public void setPolozios(List<Polozio> polozios) {
		this.polozios = polozios;
	}

	public Polozio addPolozio(Polozio polozio) {
		getPolozios().add(polozio);
		polozio.setUser(this);

		return polozio;
	}

	public Polozio removePolozio(Polozio polozio) {
		getPolozios().remove(polozio);
		polozio.setUser(null);

		return polozio;
	}

	public List<Prijava> getPrijavas() {
		return this.prijavas;
	}

	public void setPrijavas(List<Prijava> prijavas) {
		this.prijavas = prijavas;
	}

	public Prijava addPrijava(Prijava prijava) {
		getPrijavas().add(prijava);
		prijava.setUser(this);

		return prijava;
	}

	public Prijava removePrijava(Prijava prijava) {
		getPrijavas().remove(prijava);
		prijava.setUser(null);

		return prijava;
	}

	public List<Uradio> getUradios() {
		return this.uradios;
	}

	public void setUradios(List<Uradio> uradios) {
		this.uradios = uradios;
	}

	public Uradio addUradio(Uradio uradio) {
		getUradios().add(uradio);
		uradio.setUser(this);

		return uradio;
	}

	public Uradio removeUradio(Uradio uradio) {
		getUradios().remove(uradio);
		uradio.setUser(null);

		return uradio;
	}

}