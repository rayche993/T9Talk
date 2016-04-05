package model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the polaze database table.
 * 
 */
@Entity
@NamedQuery(name="Polaze.findAll", query="SELECT p FROM Polaze p")
public class Polaze implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private PolazePK id;

	private float brojbodova;

	//bi-directional many-to-one association to Test
	@ManyToOne
	@JoinColumn(name="TESTID")
	private Test test;

	//bi-directional many-to-one association to User
	@ManyToOne
	@JoinColumn(name="USERID")
	private User user;

	public Polaze() {
	}

	public PolazePK getId() {
		return this.id;
	}

	public void setId(PolazePK id) {
		this.id = id;
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

}