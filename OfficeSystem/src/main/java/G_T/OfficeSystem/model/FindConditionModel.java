package G_T.OfficeSystem.model;

public class FindConditionModel{

	private String userId;
	private String email;
	private String nickName;
	private String userName;
	private Integer sex;
	private String birthday;
	private String yearOld;
	private String tel;
	private String postCode;
	private String address;
	private String hireDate;
	private String affiliation;
	private String position;
	private String hobby;
	private String specialSkill;
	private String comment;

	public FindConditionModel() {
	}

	public FindConditionModel(String userId, String email, String nickName, String userName,
	Integer sex, String birthday, String tel, String postCode,
	String address, String hireDate, String affiliation, String position, String hobby, String specialSkill, String comment) {
		this.userId = userId;
		this.email = email;
		this.nickName = nickName;
		this.userName = userName;
		this.sex = sex;
		this.birthday = birthday;
		this.tel = tel;
		this.postCode = postCode;
		this.address = address;
		this.hireDate = hireDate;
		this.affiliation = affiliation;
		this.position = position;
		this.hobby = hobby;
		this.specialSkill = specialSkill;
		this.comment = comment;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userid){
		this.userId = userid;
	}

	public String getEmail() {
		return email;
	}
	public void setEmail(String email){
		this.email = email;
	}

	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickname) {
		this.nickName = nickname;
	}

	public String getUserName() {
		return userName;
	}
	public void setUserName(String username) {
		this.userName = username;
	}

	public Integer getSex() {
		return sex;
	}
	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getYearOld() {
		return yearOld;
	}

	public void setYearOld(String yearOld) {
		this.yearOld = yearOld;
	}

	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postcode) {
		this.postCode = postcode;
	}

	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}

	public String getHireDate() {
		return hireDate;
	}
	public void setHireDate(String hiredate) {
		this.hireDate = hiredate;
	}

	public String getAffiliation() {
		return affiliation;
	}
	public void setAffiliation(String affiliation) {
		this.affiliation = affiliation;
	}

	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}

	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}

	public String getSpecialSkill() {
		return specialSkill;
	}
	public void setSpecialSkill(String specialskill) {
		this.specialSkill = specialskill;
	}

	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}

}

