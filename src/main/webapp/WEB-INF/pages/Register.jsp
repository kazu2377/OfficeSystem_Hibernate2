<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
	<head>
		<title>新規登録</title>
		<script src="${pageContext.request.contextPath}/js/jquery-1.10.2.min.js" type="text/javascript"></script>
		<style type="text/css">
			body {
				margin: 0;
				padding: 0;
				font-family: "Helvetica Neue", "Segoe UI", sans-serif;
				background: linear-gradient(160deg, #e7fff0 0%, #ffffff 45%, #f2fffb 100%);
				min-height: 100vh;
				display: flex;
				align-items: center;
				justify-content: center;
				color: #202124;
			}

			.signup-wrapper {
				width: 100%;
				max-width: 520px;
				padding: 24px;
			}

			.signup-card {
				background: #fff;
				border-radius: 28px;
				padding: 40px 44px 36px;
				box-shadow: 0 28px 80px rgba(0, 0, 0, 0.08);
				position: relative;
				overflow: hidden;
			}

			.signup-card::before {
				content: "";
				position: absolute;
				width: 280px;
				height: 280px;
				background: #06c755;
				opacity: 0.09;
				border-radius: 50%;
				top: -80px;
				left: -60px;
				filter: blur(6px);
			}

			.signup-card::after {
				content: "";
				position: absolute;
				width: 180px;
				height: 180px;
				background: #05b349;
				opacity: 0.05;
				border-radius: 50%;
				bottom: -70px;
				right: -40px;
				filter: blur(4px);
			}

			.title-area {
				position: relative;
				z-index: 1;
				display: flex;
				align-items: center;
				gap: 14px;
				margin-bottom: 28px;
			}

			.title-icon {
				width: 52px;
				height: 52px;
				border-radius: 16px;
				background: #06c755;
				display: flex;
				align-items: center;
				justify-content: center;
				color: #fff;
				font-weight: 700;
				font-size: 18px;
				letter-spacing: 0.05em;
			}

			.title-text h1 {
				margin: 0;
				font-size: 24px;
				color: #111;
			}

			.title-text p {
				margin: 4px 0 0;
				font-size: 14px;
				color: #5f6368;
			}

			.error-label {
				color: #d93025;
				font-size: 13px;
				text-align: center;
				margin-bottom: 16px;
			}

			.form-grid {
				display: grid;
				grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
				gap: 18px 20px;
				margin-bottom: 24px;
			}

			.field {
				display: flex;
				flex-direction: column;
				gap: 6px;
			}

			.field label {
				font-size: 13px;
				color: #5f6368;
			}

			.input {
				border: 1px solid #e0e0e0;
				border-radius: 14px;
				padding: 14px 16px;
				font-size: 15px;
				transition: border-color 0.2s, box-shadow 0.2s;
				width: 100%;
			}

			.input:focus {
				outline: none;
				border-color: #06c755;
				box-shadow: 0 0 0 4px rgba(6, 199, 85, 0.15);
			}

			.notice {
				background: #f4fbf7;
				padding: 14px 16px;
				border-radius: 16px;
				font-size: 13px;
				color: #4f5b62;
				margin-bottom: 24px;
				line-height: 1.6;
			}

			.submit-button {
				width: 100%;
				border: none;
				border-radius: 999px;
				padding: 15px;
				background: #06c755;
				color: #fff;
				font-size: 16px;
				font-weight: bold;
				letter-spacing: 0.05em;
				cursor: pointer;
				transition: transform 0.15s ease, box-shadow 0.15s ease;
			}

			.submit-button:hover {
				transform: translateY(-1px);
				box-shadow: 0 18px 34px rgba(6, 199, 85, 0.25);
			}

			.footer-links {
				margin-top: 22px;
				text-align: center;
				font-size: 13px;
			}

			.footer-links a {
				color: #06c755;
				text-decoration: none;
				font-weight: 600;
			}
		</style>
	</head>
	<body>
		<div class="signup-wrapper">
			<div class="signup-card">
				<div class="title-area">
					<div class="title-icon">LINE</div>
					<div class="title-text">
						<h1>アカウント作成</h1>
						<p>基本情報を入力してOfficeSystemをはじめましょう</p>
					</div>
				</div>
				<label class="error-label">${error}</label>
				<form id="registerForm" method="post" action="${pageContext.request.contextPath}/Register">
					<div class="form-grid">
						<div class="field">
							<label for="userId">ユーザーID</label>
							<input type="text" class="input" id="userId" name="userId" placeholder="半角英数字4〜20文字">
						</div>
						<div class="field">
							<label for="displayName">表示名</label>
							<input type="text" class="input" id="displayName" name="displayName" placeholder="例）山田 太郎">
						</div>
						<div class="field">
							<label for="email">メールアドレス</label>
							<input type="email" class="input" id="email" name="email" placeholder="example@mail.com">
						</div>
						<div class="field">
							<label for="phone">電話番号</label>
							<input type="tel" class="input" id="phone" name="phone" placeholder="090-0000-0000">
						</div>
						<div class="field">
							<label for="password">パスワード</label>
							<input type="password" class="input" id="password" name="password" placeholder="8文字以上">
						</div>
						<div class="field">
							<label for="confirm">パスワード（確認）</label>
							<input type="password" class="input" id="confirm" name="confirm" placeholder="同じパスワードを入力">
						</div>
					</div>
					<div class="notice">
						登録を行うことで、利用規約およびプライバシーポリシーに同意したものとみなされます。
					</div>
					<input type="button" class="submit-button" id="registerButton" value="LINEアカウントを作成">
				</form>
				<div class="footer-links">
					すでにアカウントをお持ちですか？ <a href="${pageContext.request.contextPath}/Login">ログインする</a>
				</div>
			</div>
		</div>
		<script type="text/ecmascript">
			$("#registerButton").click(function () {
				if ($("#userId").val() === "") {
					alert("ユーザーIDを入力してください");
					return false;
				}
				if ($("#displayName").val() === "") {
					alert("表示名を入力してください");
					return false;
				}
				if ($("#email").val() === "") {
					alert("メールアドレスを入力してください");
					return false;
				}
				if ($("#phone").val() === "") {
					alert("電話番号を入力してください");
					return false;
				}
				if ($("#password").val() === "") {
					alert("パスワードを入力してください");
					return false;
				}
				if ($("#password").val().length < 8) {
					alert("パスワードは8文字以上で入力してください");
					return false;
				}
				if ($("#confirm").val() !== $("#password").val()) {
					alert("確認用パスワードが一致しません");
					return false;
				}

				$.ajax({
					url: "${pageContext.request.contextPath}/Register",
					type: "post",
					data: {
						userId: $("#userId").val(),
						displayName: $("#displayName").val(),
						email: $("#email").val(),
						phone: $("#phone").val(),
						password: $("#password").val()
					},
					success: function (data) {
						if (data === "") {
							window.location.href = "${pageContext.request.contextPath}/Login";
						} else {
							alert(data);
						}
					},
					error: function () {
						alert("システムエラーが発生しました");
					}
				});
			});
		</script>
	</body>
</html>

