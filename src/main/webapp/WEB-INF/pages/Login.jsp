<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<head>
		<title>ログイン画面</title>
		<script src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js" type="text/javascript"></script>
		<!--  <script src="https://code.jquery.com/jquery-3.2.1.min.js" type="text/javascript"></script>-->
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
			.BUTTON.SECONDARY
			{
				margin-top:5px;
				background-color:#6bb37f;
				border:1px solid #4e8f62;
			}
			.BUTTON.SECONDARY:hover
			{
				background-color:#5ea972;
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
	<body>
		<form method="post" action="${pageContext.request.contextPath}/Login">
			<label class="LABEL">  ${error}  </label>
			<div class="CONTAINER">
				<input type="text" class="TEXTBOX" id="userId" name="userId" placeholder="ユーザーID"/>
				<input type="password" class="TEXTBOX" id="password" name="password" placeholder="パスワード"/>
				<input type="email" class="TEXTBOX" id="email" name="email" placeholder="メールアドレス"/>
				<input type="button" class="BUTTON" id="loginButton" value="ログイン" />
				<input type="button" class="BUTTON SECONDARY" id="registerButton" value="新規作成" />
				<a href="" class="LEFT" >パスワード忘れ</a>
				<a href="" class="RIGHT" >新規登録</a>
			</div>
		</form>
		<textarea class="TEXTAREA">お知らせ</textarea>
	</body>
	<script type="text/ecmascript">
		(function() {
			var contextPath = "${pageContext.request.contextPath}";
			var userIdPattern = /^[A-Za-z0-9_-]{4,20}$/;
			var emailPattern = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;

			function getFormValues() {
				return {
					userId: $.trim($("#userId").val()),
					email: $.trim($("#email").val()),
					password: $("#password").val()
				};
			}

			function validateCommon(values) {
				if (!values.userId) {
					alert("ユーザーIDを入力してください");
					return false;
				}
				if (!values.password) {
					alert("パスワードを入力してください");
					return false;
				}
				if (!values.email) {
					alert("メールアドレスを入力してください");
					return false;
				}
				return true;
			}

			function validateRegister(values) {
				if (!validateCommon(values)) {
					return false;
				}
				if (!userIdPattern.test(values.userId)) {
					alert("ユーザーIDは4～20文字の英数字（-_含む）で入力してください");
					return false;
				}
				if (values.password.length < 8 || values.password.length > 32) {
					alert("パスワードは8～32文字で入力してください");
					return false;
				}
				if (!emailPattern.test(values.email)) {
					alert("メールアドレスの形式が正しくありません");
					return false;
				}
				return true;
			}

			function postAuth(url, values, successHandler) {
				$.ajax({
					url: url,
					type: "post",
					data: {userId: values.userId, password: values.password, email: values.email},
					success: successHandler,
					error: function () {
						alert("システムエラーが発生しました");
					}
				});
			}

			$("#loginButton").click(function () {
				var values = getFormValues();
				if (!validateCommon(values)) {
					return false;
				}
				postAuth(contextPath + "/Login", values, function (data) {
					if (data === "") {
						window.location.href = "次の画面";
					} else {
						alert(data);
					}
				});
				return false;
			});

			$("#registerButton").click(function () {
				var values = getFormValues();
				if (!validateRegister(values)) {
					return false;
				}
				postAuth(contextPath + "/Login/Register", values, function (data) {
					if (data === "") {
						alert("新規登録が完了しました。登録した情報でログインしてください。");
					} else {
						alert(data);
					}
				});
				return false;
			});
		})();
		</script>

</html>
