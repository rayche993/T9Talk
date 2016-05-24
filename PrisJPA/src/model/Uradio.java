package model;

import java.io.Serializable;
import javax.persistence.*;
import java.util.List;


/**
 * The persistent class for the uradio database table.
 * 
 */
@Entity
@NamedQuery(name="Uradio.findAll", query="SELECT u FROM Uradio u")
public class Uradio implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int uradioid;

	private float brojbodova;

	//bi-directional many-to-one association to Test
	@ManyToOne
	@JoinColumn(name="TESTID")
	private Test test;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	//bi-directional many-to-one association to Uradioodgovor
	@OneToMany(mappedBy="uradio")
	private List<Uradioodgovor> uradioodgovors;

	public Uradio() {
	}

	public int getUradioid() {
		return this.uradioid;
	}

	public void setUradioid(int uradioid) {
		this.uradioid = uradioid;
	}

	public float getBrojbodova() {
		return this.brojbodova;
	}

	public void setBrojbodova(float brojbodova) {
		this.brojbodova = brojbodova;
	}

	public Test getTest() {
		return this.test;
	}

	public void setTest(Test test) {
		this.test = test;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Uradioodgovor> getUradioodgovors() {
		return this.uradioodgovors;
	}

	public void setUradioodgovors(List<Uradioodgovor> uradioodgovors) {
		this.uradioodgovors = uradioodgovors;
	}

	public Uradioodgovor addUradioodgovor(Uradioodgovor uradioodgovor) {
		getUradioodgovors().add(uradioodgovor);
		uradioodgovor.setUradio(this);

		return uradioodgovor;
	}

	public Uradioodgovor removeUradioodgovor(Uradioodgovor uradioodgovor) {
		getUradioodgovors().remove(uradioodgovor);
		uradioodgovor.setUradio(null);

		return uradioodgovor;
	}

}