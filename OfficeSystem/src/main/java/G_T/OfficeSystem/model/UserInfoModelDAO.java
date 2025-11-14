package G_T.OfficeSystem.model;


import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class UserInfoModelDAO extends JdbcDaoSupport{

	@Autowired
	public UserInfoModelDAO(DataSource dataSource) {
		this.setDataSource(dataSource);
	}

	public Integer CheckUser(LoginModel model) {
		String sql = "select count(*) from user_master where 1 = 1";

		if (model.getUserId() != "") {
			sql += " and u.USER_ID = '" + model.getUserId() + "'";
		}

		if (model.getPassword() != "") {
			sql += " and PASSWORD = '" + model.getPassword() + "'";
		}

		try {
			return getJdbcTemplate().queryForObject(sql, new Object[] { }, Integer.class);
		} catch (EmptyResultDataAccessException e) {
			return null;
		}
	}

    public List<UserInfoModel> FindUser(FindConditionModel condition) {
        String sql = UserInfoModelMapper.BASE_SQL + " and u.TYPE = 2 ";

        if (condition != null) {
	        if (condition.getUserId() != "") {
	        	sql += " and u.USER_ID like '%" + condition.getUserId() + "%'";
	        }

	        if (condition.getEmail() != "") {
	        	sql += " and EMAIL like '%" + condition.getEmail() + "%'";
	        }

	        if (condition.getNickName() != "") {
	        	sql += " and NICK_NAME like '%" + condition.getNickName() + "%'";
	        }

	        if (condition.getUserName() != "") {
	        	sql += " and USER_NAME like '%" + condition.getUserName() + "%'";
	        }

	        if (condition.getSex() != null) {
	        	sql += " and SEX = " + condition.getSex();
	        }

	        if (condition.getBirthday() != "") {
	        	sql += " and BIRTHDAY = '" + condition.getBirthday() + "'";
	        }

	        if (condition.getTel() != "") {
	        	sql += " and TEL like '%" + condition.getTel() + "%'";
	        }

	        if (condition.getPostCode() != "") {
	        	sql += " and POSTCODE like '%" + condition.getPostCode() + "%'";
	        }

	        if (condition.getAddress() != "") {
	        	sql += " and ADDRESS like '%" + condition.getAddress() + "%'";
	        }

	        if (condition.getHireDate() != "") {
	        	sql += " and HIRE_DATE like '%" + condition.getHireDate() + "%'";
	        }

	        if (condition.getAffiliation() != "") {
	        	sql += " and AFFILIATION like '%" + condition.getAffiliation() + "%'";
	        }

	        if (condition.getPosition() != "") {
	        	sql += " and POSITION like '%" + condition.getPosition() + "%'";
	        }

	        if (condition.getSpecialSkill() != "") {
	        	sql += " and SPECIAL_SKILL like '%" + condition.getSpecialSkill() + "%'";
	        }

	        if (condition.getComment() != "") {
	        	sql += " and COMMENT like '%" + condition.getComment() + "%'";
	        }
        }

        UserInfoModelMapper mapper = new UserInfoModelMapper();

        try {
	        List<UserInfoModel> list = this.getJdbcTemplate().query(sql, mapper);
	        return list;
	    } catch (EmptyResultDataAccessException e) {
	    	return null;
	    }
    }

}
