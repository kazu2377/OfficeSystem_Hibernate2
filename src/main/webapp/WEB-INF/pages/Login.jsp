<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<head>
		<title>ログイン画面</title>
		<script src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js" type="text/javascript"></script>
		<style type="text/css">
			body {
				margin: 0;
				padding: 0;
				font-family: "Helvetica Neue", "Segoe UI", sans-serif;
				background: linear-gradient(135deg, #d7f8df 0%, #f4fff6 100%);
				min-height: 100vh;
				display: flex;
				align-items: center;
				justify-content: center;
				color: #202124;
			}

			.login-wrapper {
				width: 100%;
				max-width: 420px;
				padding: 24px;
			}

			.login-card {
				background: #fff;
				border-radius: 24px;
				padding: 40px 36px 32px;
				box-shadow: 0 30px 80px rgba(0, 0, 0, 0.08);
				position: relative;
				overflow: hidden;
			}

			.login-card::before {
				content: "";
				position: absolute;
				width: 220px;
				height: 220px;
				background: #06c755;
				opacity: 0.08;
				border-radius: 50%;
				top: -60px;
				right: -40px;
				filter: blur(4px);
			}

			.line-logo {
				display: flex;
				align-items: center;
				gap: 12px;
				margin-bottom: 24px;
			}

			.line-logo-circle {
				width: 46px;
				height: 46px;
				background: #06c755;
				border-radius: 12px;
				display: flex;
				align-items: center;
				justify-content: center;
				color: #fff;
				font-weight: bold;
				letter-spacing: 1px;
			}

			.line-logo-text {
				font-size: 22px;
				font-weight: 700;
				letter-spacing: 0.05em;
				color: #111;
			}

			.subtitle {
				color: #5f6368;
				font-size: 14px;
				margin-bottom: 30px;
			}

			.error-label {
				color: #d93025;
				font-size: 13px;
				text-align: center;
				margin-bottom: 12px;
			}

			.input-group {
				display: flex;
				flex-direction: column;
				gap: 16px;
				margin-bottom: 24px;
			}

			.input-field {
				border: 1px solid #e0e0e0;
				border-radius: 12px;
				padding: 14px 16px;
				font-size: 15px;
				transition: border-color 0.2s, box-shadow 0.2s;
			}

			.input-field:focus {
				outline: none;
				border-color: #06c755;
				box-shadow: 0 0 0 4px rgba(6, 199, 85, 0.15);
			}

			.login-button {
				width: 100%;
				border: none;
				border-radius: 999px;
				padding: 14px;
				background: #06c755;
				color: #fff;
				font-size: 16px;
				font-weight: bold;
				letter-spacing: 0.05em;
				cursor: pointer;
				transition: transform 0.15s ease, box-shadow 0.15s ease;
			}

			.login-button:hover {
				transform: translateY(-1px);
				box-shadow: 0 12px 24px rgba(6, 199, 85, 0.25);
			}

			.links {
				display: flex;
				justify-content: space-between;
				margin-top: 16px;
				font-size: 13px;
			}

			.links a {
				color: #06c755;
				text-decoration: none;
				font-weight: 600;
			}

			.announcement {
				margin-top: 36px;
				border-radius: 18px;
				background: #f4fbf7;
				padding: 18px 20px;
				font-size: 13px;
				line-height: 1.6;
				color: #4f5b62;
			}

			textarea {
				width: 100%;
				border: none;
				background: transparent;
				resize: none;
				min-height: 90px;
				color: inherit;
				font: inherit;
			}

			textarea:focus {
				outline: none;
			}
		</style>

	</head>
	<body>
		<div class="login-wrapper">
			<div class="login-card">
				<div class="line-logo">
					<div class="line-logo-circle">LINE</div>
					<div class="line-logo-text">ログイン</div>
				</div>
				<p class="subtitle">LINEアカウントでOfficeSystemにサインイン</p>
				<label class="error-label">${error}</label>
				<form method="post" action="${pageContext.request.contextPath}/Login">
					<div class="input-group">
						<input type="text" class="input-field" id="userId" name="userId" placeholder="ユーザーID">
						<input type="password" class="input-field" id="password" name="password" placeholder="パスワード">
						<input type="email" class="input-field" id="email" name="email" placeholder="メールアドレス">
					</div>
					<input type="button" class="login-button BUTTON" value="LINEでログイン">
					<div class="links">
						<a href="#">パスワードをお忘れの方</a>
						<a href="${pageContext.request.contextPath}/Register">新規登録</a>
					</div>
				</form>
				<div class="announcement">
					<textarea class="TEXTAREA">お知らせ</textarea>
				</div>
			</div>
		</div>
	</body>
	<script type="text/ecmascript">
		$(".BUTTON").click(function () {
			if ($("#userId").val() == "") {
				alert("ユーザーIDを入力してください");
				return false;
			}
			if ($("#password").val() == "") {
				alert("パスワードを入力してください");
				return false;
			}
			if ($("#email").val() == "") {
				alert("メールアドレスを入力してください");//追加した
				return false;
			}
			$.ajax({
				url:"${pageContext.request.contextPath}/Login",
				type: "post",
				data:{userId:$("#userId").val(), password: $("#password").val(), email: $("#email").val()},//追加した
				success: function (data) {

					if (data == "") {
						window.location.href = "次の画面";
					}
					else {
						alert(data);
					}
				},
				error: function () {
					alert("システムエラーが発生しました");
				}
			 });
	     });
		</script>

</html>