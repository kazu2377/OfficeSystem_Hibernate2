package G_T.OfficeSystem.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import G_T.OfficeSystem.model.LoginModel;
import G_T.OfficeSystem.model.UserInfoModelDAO;

@Controller
public class LoginController {

	@Autowired
	private UserInfoModelDAO userInfoModelDAO;

	private static final Pattern USER_ID_PATTERN = Pattern.compile("^[A-Za-z0-9_-]{4,20}$");
	private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
	private static final int PASSWORD_MIN_LENGTH = 8;
	private static final int PASSWORD_MAX_LENGTH = 32;

	@RequestMapping(value="/Login", method = RequestMethod.GET)
	public String Login() {
		return "Login";
	}

	@RequestMapping(value="/Login", params = {"userId", "password","email"}, method = RequestMethod.POST, produces="text/plain;charset=utf-8")//email

	public @ResponseBody String Login(
		@RequestParam(value = "userId") String userId,
		@RequestParam(value = "password") String password,
		@RequestParam(value = "email") String email
		) {

		String trimmedUserId = StringUtils.trimWhitespace(userId);
		String trimmedEmail = StringUtils.trimWhitespace(email);

		/*
		if (userId == "" || password == "") {
			model.addAttribute("error", "ユーザーIDまたはパスワードが未入力です。");
			return "Login";
		}
		*/

		//ユーザーIDとパスワードがデータベースに存在するかどうかチェック
		Integer count = userInfoModelDAO.CheckUser(new LoginModel(trimmedUserId, password, trimmedEmail));//email

		//存在しない場合、ログイン画面に「ユーザーIDまたはパスワードが存在しません」のエラーメッセージを表示する
		if (count == 0) {
			return "ユーザーID,パスワード,メールアドレスが存在しません";
		}

		return "";
	}

	@RequestMapping(value="/Login/Register", method = RequestMethod.POST, produces="text/plain;charset=utf-8")
	public @ResponseBody String register(
			@RequestParam(value = "userId") String userId,
			@RequestParam(value = "password") String password,
			@RequestParam(value = "email") String email) {

		String trimmedUserId = StringUtils.trimWhitespace(userId);
		String trimmedEmail = StringUtils.trimWhitespace(email);

		List<String> errors = validateRegistrationInputs(trimmedUserId, password, trimmedEmail);
		if (!errors.isEmpty()) {
			return String.join("\n", errors);
		}

		try {
			userInfoModelDAO.createUser(new LoginModel(trimmedUserId, password, trimmedEmail));
		} catch (DuplicateKeyException e) {
			return "ユーザーIDまたはメールアドレスは既に使用されています";
		} catch (DataAccessException e) {
			return "新規登録に失敗しました。時間をおいて再度お試しください";
		}

		return "";
	}

	private List<String> validateRegistrationInputs(String userId, String password, String email) {
		List<String> errors = new ArrayList<>();

		if (!StringUtils.hasText(userId)) {
			errors.add("ユーザーIDを入力してください");
		} else if (!USER_ID_PATTERN.matcher(userId).matches()) {
			errors.add("ユーザーIDは4～20文字の英数字（-_含む）で入力してください");
		} else if (userInfoModelDAO.existsUserId(userId)) {
			errors.add("そのユーザーIDは既に使用されています");
		}

		if (!StringUtils.hasText(password)) {
			errors.add("パスワードを入力してください");
		} else if (password.length() < PASSWORD_MIN_LENGTH || password.length() > PASSWORD_MAX_LENGTH) {
			errors.add("パスワードは" + PASSWORD_MIN_LENGTH + "～" + PASSWORD_MAX_LENGTH + "文字で入力してください");
		}

		if (!StringUtils.hasText(email)) {
			errors.add("メールアドレスを入力してください");
		} else if (!EMAIL_PATTERN.matcher(email).matches()) {
			errors.add("メールアドレスの形式が正しくありません");
		} else if (userInfoModelDAO.existsEmail(email)) {
			errors.add("そのメールアドレスは既に登録されています");
		}

		return errors;
	}

}

