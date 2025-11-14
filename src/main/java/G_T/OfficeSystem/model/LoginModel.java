
package G_T.OfficeSystem.model;

public class LoginModel {
    private String userId;
    private String password;
    private String email;//追加した

	public LoginModel() { }

	public LoginModel(String userId, String password,String email) {//追加した
		this.userId = userId;
		this.password = password;
		this.email=email;//追加
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {//追加した
		return email;
	}

	public void setEmail(String email) {//追加した
		this.email = email;
	}
}
