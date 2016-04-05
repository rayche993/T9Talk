package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


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
	private String lekcijaid;

	@Lob
	private String text;

	private int tiplekcije;

	//bi-directional many-to-one association to Komentar
	@OneToMany(mappedBy="lekcija")
	private List<Komentar> komentars;

	//bi-directional many-to-one association to Kurs
	@ManyToOne
	@JoinColumn(name="KURSID")
	private Kurs kur;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	//bi-directional many-to-one association to Test
	@OneToMany(mappedBy="lekcija")
	private List<Test> tests;

	public Lekcija() {
	}

	public String getLekcijaid() {
		return this.lekcijaid;
	}

	public void setLekcijaid(String lekcijaid) {
		this.lekcijaid = lekcijaid;
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

	public List<Komentar> getKomentars() {
		return this.komentars;
	}

	public void setKomentars(List<Komentar> komentars) {
		this.komentars = komentars;
	}

	public Komentar addKomentar(Komentar komentar) {
		getKomentars().add(komentar);
		komentar.setLekcija(this);

		return komentar;
	}

	public Komentar removeKomentar(Komentar komentar) {
		getKomentars().remove(komentar);
		komentar.setLekcija(null);

		return komentar;
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

	public List<Test> getTests() {
		return this.tests;
	}

	public void setTests(List<Test> tests) {
		this.tests = tests;
	}

	public Test addTest(Test test) {
		getTests().add(test);
		test.setLekcija(this);

		return test;
	}

	public Test removeTest(Test test) {
		getTests().remove(test);
		test.setLekcija(null);

		return test;
	}

}