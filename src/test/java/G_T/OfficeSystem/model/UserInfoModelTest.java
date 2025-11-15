package G_T.OfficeSystem.model;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.junit.Test;

/**
 * UserInfoModelクラスの単体テストを行うクラスです。
 * 主に「getYearOld」メソッドの動作検証（生年月日から年齢を正しく計算できるか等）をJUnitでテストします。
 * ・birthdayがnullや不正な形式の時にnullを返すこと
 * ・正しい形式（yyyyMMdd）の時に現在年齢が適切に計算されること
 * などをテストしています。
 */
public class UserInfoModelTest {

	private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyyMMdd");

	@Test
	public void getYearOldReturnsNullWhenBirthdayIsNull() {
		UserInfoModel model = new UserInfoModel();
		model.setBirthday(null);

		assertNull(model.getYearOld());
	}

	@Test
	public void getYearOldReturnsNullWhenBirthdayHasInvalidFormat() {
		UserInfoModel model = new UserInfoModel();
		model.setBirthday("20-01-01");

		assertNull(model.getYearOld());
	}

	@Test
	public void getYearOldCalculatesAgeWhenBirthdayAtBeginningOfYear() {
		LocalDate birthDate = LocalDate.of(2000, 1, 1);
		UserInfoModel model = new UserInfoModel();
		model.setBirthday(birthDate.format(FORMATTER));

		Integer expectedAge = expectedAge(birthDate);
		assertEquals(expectedAge, model.getYearOld());
	}

	@Test
	public void getYearOldCalculatesAgeWhenBirthdayAtEndOfYear() {
		LocalDate birthDate = LocalDate.of(2000, 12, 31);
		UserInfoModel model = new UserInfoModel();
		model.setBirthday(birthDate.format(FORMATTER));

		Integer expectedAge = expectedAge(birthDate);
		assertEquals(expectedAge, model.getYearOld());
	}

	private Integer expectedAge(LocalDate birthDate) {
		LocalDate today = LocalDate.now();
		int age = today.getYear() - birthDate.getYear();
		LocalDate birthdayThisYear = birthDate.withYear(today.getYear());
		if (today.isBefore(birthdayThisYear)) {
			age--;
		}
		return age;
	}
}
