<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>


<!DOCTYPE html>
<html>
	<head>
<!--     <meta name="viewport" content="width=device-width" />  -->
		<title>ユーザー検索画面</title>
	    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.css">
	    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js"></script>

		<style type="text/css">
			.{ }

			.LABEL
			{
				color:red;
				margin:0 auto;
				display:block;
				text-align:center;
			}
			.CONTAINER
			{
				width:250px;
				margin:0 auto;
				margin-bottom:5px;
			}
			.TEXTBOX
			{
				width:250px;
				height:30px;
				margin-bottom:5px;
			}
			.LEFT
			{
				float:left;
			}
			.RIGHT
			{
				float:right;
			}
			.BUTTON
			{
				width:250px;
			}
			.TEXTAREA
			{
				width:500px;
				height:200px;
				margin:0 auto;
				display:block;
				resize:none;
				clear:both;
			}
		</style>
	</head>
<body style="text-align:center">
	<table style="width:700px">
	    <tbody>
	    	<tr>
		        <td style="text-align:left;font-size:25px;font-weight:bold;">
		            検索条件
		        </td>
		    </tr>
		    <tr style="height:5px">
		        <td style="width:100%">
		            <div class="TitleLine"> </div>
		        </td>
		    </tr>
		    <tr>
		        <td style="width:100%">
					<form id="Form1" method="post" action="Find">
		            <div id="div検索条件">
						<table>
		                    <tr>
		                        <td style="width:50px"></td>
		                        <td style="width:150px">
		                            ユーザーID
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="userid" name="userId" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            メールアドレス
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="txtメールアドレス" name="email" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            ニックネーム
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="nickName" name="nickName" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            氏名
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="userName" name="userName" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            性別
		                        </td>
		                        <td style="width:auto">
		                            <table>
		                                <tr>
		                                    <td style="width:100%">
		                                        <label class="Label" style="width:100%">
		                                            <label class="Radio">
		                                                <input name="sex" type="radio" value="1" />
		                                                <span>男</span>
		                                            </label>

		                                            <label class="Radio" style="margin-left:30px">
		                                                <input name="sex" type="radio" value="2" />
		                                                <span>女</span>
		                                            </label>
		                                        </label>
		                                    </td>
		                                </tr>
		                            </table>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            生年月日
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="birthday" name="birthday" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            年齢
		                        </td>
		                        <td style="width:auto;text-align:left">
		                            <input class="TextBox" id="yearOld" name="yearOld" style="width:80px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            電話番号
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="tel" name="tel" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            郵便番号
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="postCode" name="postCode" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            住所
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="address" name="address" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            入社日
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="hireDate" name="hireDate" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            所属
		                        </td>
		                        <td style="width:auto">
		                            <select class="Select" name="affiliation" id="affiliation" style="width:100px">
		                                <option></option>
		                                <option>技術部</option>
		                                <option>営業部</option>
		                            </select>
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            役職
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="position" name="position" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            趣味
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="hobby" name="hobby" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td>
		                            特技
		                        </td>
		                        <td style="width:auto">
		                            <input class="TextBox" id="specialSkill" name="specialSkill" style="width:300px" type="text" value="" />
		                        </td>
		                    </tr>
		                    <tr>
		                        <td></td>
		                        <td style="vertical-align:top;padding-top:3px">
		                            座右銘
		                        </td>
		                        <td style="width:auto">
		                            <textarea class="TextBox" cols="20" id="comment" name="comment" rows="2" style="width:300px;height:80px;resize:none" value=""></textarea>
		                        </td>
		                    </tr>
		                    <tr style="height:10px">
		                        <td colspan="3"></td>
		                    </tr>
		                </table>
		            </div>
		            <div>
		                <table style="width:100%">
		                    <tbody><tr>
		                        <td colspan="3" style="width:100%">
		                            <table style="width:100%">
		                                <tbody><tr>
		                                    <td style="width:auto; text-align:left">
		                                        <input class="Button" type="button" id="btn検索" value="検索" onclick="find(event)" style="width:130px">
		                                    </td>
		                                    <td style="width:150px; text-align:right">
		                                        <input type="button" class="Button" id="btnメール送信" value="メール送信" style="width:130px">
		                                    </td>
		                                    <td style="width:150px; text-align:right">
		                                        <input type="button" class="Button" id="btn申請確認" value="申請確認" style="width:130px;">
		                                    </td>
		                                    <td style="width:50px; text-align:right">
		                                        <input type="button" class="Button" id="btn検索条件表示" value="△" style="width:35px;outline:none">
		                                    </td>
		                                </tr>
		                            </tbody></table>
		                        </td>
		                    </tr>
		                </tbody></table>
		            </div>
		            </form>
		        </td>
		    </tr>
		    <tr>
		        <td style="width:100%">
					<div id="container">
						<tiles:insertAttribute name="_FindResult" />
					</div>
		        </td>
		    </tr>
		</tbody>
	</table>
</body>
<script type="text/javascript">
	$("#btn検索").click(function (event) {
		 $.ajax({
			url: "${pageContext.request.contextPath}/Find",
			type: "post",
			data: $("#Form1").serialize(),
			success: function (data) {
				$("#container").html(data);
			},
			error: function () {
				alert("システムエラーが発生しました1");
			}
		});
	});

	$(document).on('change', "[id^='showNumber']", function () {
		if ($('#totalCount').text() == "0") {
			return;
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/GetPage",
			type: "post",
			data: { showNumber:$("#showNumber").val(), currentPage: 1 } ,
			success: function (data) {
				$("#container").html(data);
			},
			error: function () {
				alert("システムエラーが発生しました2");
			}
		});
	});

	$(document).on('change', "[id='currentPage']", function () {
		if ($('#totalCount').text() == "0") {
			return;
		}
		$.ajax({
			url: "${pageContext.request.contextPath}/GetPage",
			type: "post",
			data: { showNumber:$("#showNumber").val(), currentPage: $('#currentPage').val() },
			success: function (data) {
				$("#container").html(data);
			},
			error: function () {
				alert("システムエラーが発生しました3");
			}
		});
	});

	$(document).on('click', "[id='previousPage']",  function (event) {
		event.preventDefault();

		var selecting = $('#currentPage').val();
		if (selecting == 1) {
			return;
		}

		$('#currentPage').val(Number(selecting) - 1);
		$('#nextPage').attr("src", "${pageContext.request.contextPath}/img/right_triangle.png");

		$.ajax({
			url: "${pageContext.request.contextPath}/GetPage",
			type: "post",
			data: { showNumber:$("#showNumber").val(), currentPage: (Number(selecting) - 1) },
			success: function (data) {
				$("#container").html(data);
			},
			error: function () {
				alert("システムエラーが発生しました4");
			}
		});
	});

	$(document).on('click', "[id='nextPage']", function (event) {
		event.preventDefault();

		var selecting = $('#currentPage').val();
		var maxvalue = $('#currentPage option:last-child').val();
		if (selecting == maxvalue) {
			return;
		}

		$('#currentPage').val(Number(selecting) + 1);
		$('#previousPage').attr("src", "${pageContext.request.contextPath}/img/left_triangle.png");

		$.ajax({
			url: "${pageContext.request.contextPath}/GetPage",
			type: "post",
			data: { showNumber:$("#showNumber").val(), currentPage: (Number(selecting) + 1) },
			success: function (data) {
				$("#container").html(data);
			},
			error: function () {
				alert("システムエラーが発生しました5");
			}
		});
	});

	function sort(obj) {
		if ($('#totalCount').text() == "0") {
			return;
		}

		var span = $(obj).find("span");
		var sortOrder = span.text().trim();
		var sortColumn = $(obj).text().replace("▲", "").replace("▼", "").trim();

		//タイトルからソート順のマークを削除する
		$("#searchList").find("tr:nth-child(1) td").each(function () {
			$(this).find("span").text("");
		});

		if (sortOrder == "" || sortOrder == "▼") {
			sortOrder = "▲";
		}
		else {
			sortOrder = "▼";
		}

		$('#previousPage').attr("src", "${pageContext.request.contextPath}/img/left_triangle_disable.png");
		$('#currentPage').val(1);
		$('#nextPage').attr("src", "${pageContext.request.contextPath}/img/right_triangle.png");

		$.ajax({
			url: "${pageContext.request.contextPath}/Sort",
			type: "post",
			data: { sortColumn: sortColumn,  sortOrder: sortOrder  },
			success: function (data) {
				$("#container").html(data);
			},
			error: function (err) {
				alert(err.responseText);
				alert("システムエラーが発生しました6");
			}
		});
	};

</script>
</html>