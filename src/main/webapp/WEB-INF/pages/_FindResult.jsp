<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<table id="searchList" style="width:100%;font-size:11px;word-break:break-all;table-layout: fixed;" border="1">
	<tr>
		<td colspan="5" style="width:300px;border-right:none">
			<c:choose>
				<c:when test="${findModel.getAllUserList() != null}">
					総件数：<span id="totalCount">${findModel.getAllUserList().size()}</span>件
				</c:when>
				<c:otherwise>
					総件数：<span id="totalCount">0</span>件
				</c:otherwise>
			</c:choose>
		</td>
		<td  style="width:40px;border:none;text-align:right">
			表示件数：
		</td>
		<td style="width:80px;border:none">
			<c:set var="disabled" value=""/>
			<c:if test="${findModel.getAllUserList() == null}">
				<c:set var="disabled" value="disabled"/>
			</c:if>
			<select class="Select" name="showNumber" id="showNumber" style="width:100%;float:right" ${disabled}>
				<c:set var="array" scope="request">0,5,10,20,50,100</c:set>
				<c:forEach var="item" items="${array}">
					<c:choose>
						<c:when test="${findModel.getShowNumber() == item}">
		   					<c:set var="selected" value="selected" scope="request"/>
						</c:when>
						<c:otherwise>
							<c:set var="selected" value="" scope="request"/>
						</c:otherwise>
					</c:choose>
		   			<c:choose>
						<c:when test="${item == 0}">
		   					<c:set var="text" value="すべて" scope="request"/>
						</c:when>
						<c:otherwise>
							<c:set var="text" value="${item}件" scope="request"/>
						</c:otherwise>
					</c:choose>
					<option value="${item}" ${selected}>${text}</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr>
		<td>選択</td>
		<c:set var="array" scope="request">ユーザーID,氏名,性別,電話番号,郵便番号,住所</c:set>
		<c:forEach var="item" items="${array}">
			<td onclick="sort(this)">
				${item}
				<span>
					<c:if test="${findModel.getSortColumn() == item}">
						<br />${findModel.getSortOrder()}
					</c:if>
				</span>
			</td>
		</c:forEach>
	</tr>
	<div name="検索結果一覧" id="div検索結果一覧">
		<c:set var="MALE" value="1"/>
		<c:set var="FEMALE" value="2"/>
		<c:if test="${findModel.getAllUserList() != null }">
			<c:set var="i" value="0" scope="request"/>
			<c:forEach var="item" items="${findModel.getShowUserList() }">
			<c:set var="i" value="${i+1}" scope="request"/><!-- 追加 -->
				<tr>
					<td class="TextCenter"><input type="checkbox" id="selectUser_${item.getUserId() }"/></td>
					<td>${item.getUserId() }</td>
					<td>${item.getHibProfileInfoModel().getUserName()}</td>
					<td class="TextCenter">
						<c:choose>
							<c:when test="${item.getHibProfileInfoModel().getSex() == MALE}">
								<c:out value="男"/>
							</c:when>
							<c:when test="${item.getHibProfileInfoModel().getSex() == FEMALE}">
								<c:out value="女"/>
					+		</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</td>
					<td>${item.getHibProfileInfoModel().getTel()}</td>
					<td>${item.getHibProfileInfoModel().getPostcode()}</td>
					<td>${item.getHibProfileInfoModel().getAddress()}</td>

				</tr>
			</c:forEach>
		</c:if>
	</div>
	<!--<tr style="border-top: 2px solid #69A4D8;">
		<td colspan="6" style="border: none;">
		</td>
		<td style="border: none; display: block; float: right;">
			<img src="${pageContext.request.contextPath}/img/left_triangle.png" name="前ページ" id="btn前ページ" style="float: left;  width: 30px; margin: 2px;" />
			<select class="SELECT" name="現ページ" id="txt現ページ" style="width: 50px; margin: 2px;">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
			</select>
			<img src="${pageContext.request.contextPath}/img/right_triangle.png" name="次ページ" id="btn次ページ" style="float: right; width: 30px; margin: 2px;" />
		</td>
	</tr>-->
	<c:if test="${findModel.getShowUserList() != null
				&& findModel.getShowUserList().size() < findModel.getAllUserList().size()}">
	<tr>
		<td colspan="7" style="border:none;">
			<div style="float:right">
			   	<c:choose>
			   		<c:when test="${findModel.getCurrentPage() == 1}">
						<input type="image" src="${pageContext.request.contextPath}/img/left_triangle_disable.png"
								id="previousPage" style="width:30px;float:left" />
			   		</c:when>
			   		<c:otherwise>
			   			<input type="image" src="${pageContext.request.contextPath}/img/left_triangle.png" id="previousPage"
								style="width:30px;float:left" />
			   		</c:otherwise>
			   	</c:choose>
   				<select class="Select" name="currentPage" id="currentPage"
						style="width:60px;height:30px;float:left;margin:0px 5px 0px 5px;">
					<c:set var="modulo" value="${findModel.getAllUserList().size() % findModel.getShowNumber()}"
							scope="request"/>
					<c:set var="plus" value="${(modulo == 0? 0:1)}" scope="request"/>
					<c:set var="loopCount" value="${findModel.getAllUserList().size() / findModel.getShowNumber() + plus}"
							scope="request"/>
					<c:if test="${findModel.getShowNumber() != 0
									&& (findModel.getAllUserList().size() / findModel.getShowNumber() + 1) >= 1}">
						<c:forEach var="loop" begin="1" end="${loopCount}">
							<c:choose>
								<c:when test="${findModel.getCurrentPage() == loop}">
									<option selected value="${loop}">${loop}</option>
								</c:when>
								<c:otherwise>
									<option value="${loop}">${loop}</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
				</select>
				<!--<fmt:parseNumber var="numberData" value="${findModel.getAllUserList().size() / findModel.getShowNumber() + 1}"
							 integerOnly="true" />-->
			   	<c:choose>
			   		<c:when test="${findModel.getCurrentPage() == numberData }"><!-- numberDataからloopCount -->
						<input type="image" src="${pageContext.request.contextPath}/img/right_triangle_disable.png"
								id="nextPage" style="width:30px;float:left" />
			   		</c:when>
			   		<c:otherwise>
			   			<input type="image" src="${pageContext.request.contextPath}/img/right_triangle.png" id="nextPage"
								style="width:30px;float:left" />
			   		</c:otherwise>
			   	</c:choose>
			</div>
		</td>
	</tr>
	</c:if>
</table>