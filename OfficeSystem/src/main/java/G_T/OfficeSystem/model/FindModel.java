package G_T.OfficeSystem.model;


import java.lang.reflect.Method;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Service;
import org.springframework.web.context.WebApplicationContext;


@Service
@Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
public class FindModel {
	private List<UserInfoModel> allUserList;			//検索結果一覧
	private List<UserInfoModel> showUserList;
	private int showNumber;
	private int currentPage;
	private String sortOrder;
	private String sortColumn;

	@Autowired
	private UserInfoModelDAO userInfoModelDAO;

    @Autowired
	private Map<String, Method> mapProperties;


	public FindModel() {
		showNumber = 10;
		currentPage = 1;
		sortOrder = "▲";
		sortColumn = "ユーザーID";
	}

	public List<UserInfoModel> getAllUserList() {
		return allUserList;
	}

	public void setAllUserList(List<UserInfoModel> allUserList) {
		this.allUserList = allUserList;
	}

	public List<UserInfoModel> getShowUserList() {
		return showUserList;
	}

	public void setShowUserList(List<UserInfoModel> showUserList) {
		this.showUserList = showUserList;
	}

	public int getShowNumber() {
		return showNumber;
	}

	public void setShowNumber(int showNumber) {
		this.showNumber = showNumber;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	public String getSortColumn() {
		return sortColumn;
	}

	public void setSortColumn(String sortColumn) {
		this.sortColumn = sortColumn;
	}

	//ユーザー情報を検索し、検索結果一覧に設定する
	public void FindUser(FindConditionModel condition) {
		setAllUserList(userInfoModelDAO.FindUser(condition));
		SortAll(sortColumn, sortOrder);
		GetPage(showNumber, currentPage);
	}

	public void GetPage(int showNumber, int currentPage)
	{
		if (showNumber == 0 || allUserList.size() <= showNumber)  //改ページが必要ない
		{
			showUserList = allUserList;
		}
		else
		{
			showUserList = IntStream.range(0, allUserList.size())
							.filter(index -> index >= (currentPage - 1) * showNumber && index < currentPage * showNumber)
							.mapToObj(allUserList::get)
							.collect(Collectors.toList());
		}
		this.showNumber = showNumber;
		this.currentPage = currentPage;
	}

	public void SortAll1(String sortColumn, String sortOrder)
	{
		Collections.sort(this.allUserList, new Comparator<UserInfoModel>(){
			public int compare(UserInfoModel u1, UserInfoModel u2){
				int invertFlag = -1;
				if (sortOrder == "▲" || sortOrder == "")
				{
					invertFlag = 1;
				}
				if (sortColumn.equals("ユーザーID")) {
					return invertFlag * (u1.getUserId().compareTo(u2.getUserId()) > 0 ? 1 : -1);
				}
				else if (sortColumn.equals("氏名")) {
					return invertFlag * (u1.getUserName().compareTo(u2.getUserName()) > 0 ? 1 : -1);
				}
				else {
					return invertFlag * 1;
				}
			}
	   });
	}

	public void SortAll(String sortColumn, String sortOrder)
	{
		Method method = mapProperties.get(sortColumn);
		Collections.sort(this.allUserList, new Comparator<UserInfoModel>(){
			public int compare(UserInfoModel u1, UserInfoModel u2){
				int invertFlag = -1;
				if (sortOrder.equals("▲") || sortOrder.equals(""))
				{
					invertFlag = 1;
				}
				if (!sortColumn.equals("")) {
					try {
						if (method.getReturnType().equals(java.lang.String.class)){
							return invertFlag * method.invoke(u1).toString().compareTo(method.invoke(u2).toString());
						}
						else {
							Integer sex1 = (method.invoke(u1) == null? 0 : (Integer)method.invoke(u1));
							Integer sex2 = (method.invoke(u2) == null? 0 : (Integer)method.invoke(u2));
							return invertFlag * (sex1 > sex2 ? 1 : -1);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				return invertFlag * 1;
			}
	   });
	}

	public void Sort(String sortColumn, String sortOrder)
	{
		if (sortOrder =="" || sortOrder == null)
		{
			sortOrder = "▲";
		}

		this.currentPage = 1;
		this.sortColumn = sortColumn;
		this.sortOrder = sortOrder;
		SortAll(sortColumn, sortOrder);
		GetPage(showNumber, currentPage);
	}
}
