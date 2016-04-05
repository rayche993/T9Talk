package model;

import java.io.Serializable;
import javax.persistence.*;

/**
 * The primary key class for the polaze database table.
 * 
 */
@Embeddable
public class PolazePK implements Serializable {
	//default serial version id, required for serializable classes.
	private static final long serialVersionUID = 1L;

	@Column(insertable=false, updatable=false)
	private String userid;

	@Column(insertable=false, updatable=false)
	private String testid;

	public PolazePK() {
	}
	public String getUserid() {
		return this.userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getTestid() {
		return this.testid;
	}
	public void setTestid(String testid) {
		this.testid = testid;
	}

	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof PolazePK)) {
			return false;
		}
		PolazePK castOther = (PolazePK)other;
		return 
			this.userid.equals(castOther.userid)
			&& this.testid.equals(castOther.testid);
	}

	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.userid.hashCode();
		hash = hash * prime + this.testid.hashCode();
		
		return hash;
	}
}