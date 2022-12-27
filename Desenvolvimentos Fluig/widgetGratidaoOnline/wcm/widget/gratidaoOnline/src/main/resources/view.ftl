
<html lang="en">
	<head>
		<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<script type="text/javascript">
		
		</script>
<!--Termina aqui código efeitos especiais TGJ-->
		<meta charset="UTF-8">

			<link rel="apple-touch-icon" type="image/png"
				href="https://cpwebassets.codepen.io/assets/favicon/apple-touch-icon-5ae1a0698dcc2402e9712f7d01ed509a57814f994c660df9f7a952f3060705ee.png">
				<meta name="apple-mobile-web-app-title" content="CodePen">

					<link rel="shortcut icon" type="image/x-icon"
						href="https://cpwebassets.codepen.io/assets/favicon/favicon-aec34940fbc1a6e787974dcd360f2c6b63348d4b1f4e06c77743096d55480f33.ico">

						<link rel="mask-icon" type="image/x-icon"
							href="https://cpwebassets.codepen.io/assets/favicon/logo-pin-8f3771b1072e3c38bd662872f6b673a722f4b3ca2421637d5596661b4e2132cc.svg"
							color="#111">


							<title>CodePen - Rotating border</title>

							<link rel="stylesheet"
								href="https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css">



								<style>
									body {
									font-family: "Open Sans", -apple-system, BlinkMacSystemFont, "Segoe UI",
									Roboto, Oxygen-Sans, Ubuntu, Cantarell, "Helvetica Neue",
									Helvetica, Arial, sans-serif;
									}
									body {
									display: flex;
									justify-content: center;
									align-items:
									center;
									height: 100vh;
									}

									*, *::before, *::after {
									box-sizing:
									border-box;
									}

									@-webkit-keyframes rotate {
									100% {
									transform:
									rotate(1turn);
									}
									}

									@keyframes rotate {
									100% {
									transform:
									rotate(1turn);
									}
									}
									.rainbow {
									position: relative;
									z-index: 0;
									width:
									400px;
									height: 300px;
									border-radius: 10px;
									overflow: hidden;
									padding: 2rem;
									flex: 100%;
									}
									.rainbow::before {
									content: "";
									position:
									absolute;
									z-index: -2;
									left: -50%;
									top: -50%;
									width: 200%;
									height:
									200%;
									background-color:
									#FFFFFF;
									background-repeat: no-repeat;
									background-size: 50% 50%,
									50% 50%;
									background-position: 0 0,
									100% 0, 100% 100%, 0 100%;
									background-image: linear-gradient(#FFFFFF, #FFFFFF),
									linear-gradient(#36AF72, #36AF72), linear-gradient(#D70B2D,
									#D70B2D), linear-gradient(#CDCBCC, #CDCBCC);
									-webkit-animation:
									rotate 4s
									linear infinite;
									animation: rotate 4s linear infinite;
									}
									.rainbow::after {
									content: "";
									position: absolute;
									z-index: -1;
									left: 6px;
									top: 6px;
									width: calc(100% - 12px);
									height: calc(100% -
									12px);
									background: white;
									border-radius: 5px;
									}
								</style>

								<script>
									window.console = window.console || function(t) {};
								</script>



								<script>
									if (document.location.search.match(/type=embed/gi)) {
									window.parent.postMessage("resize", "*");
									}
								</script>


	</head>

	<body>

		<div id="gratidaoWidget_${instanceId}" class="super-widget wcm-widget-class fluig-style-guide"
			data-params="gratidaoWidget.instance()" style="display: flex">
			<div class="rainbow" style="overflow: hidden;">
				<div class="outer" style="overflow: scroll; width: 112%; padding-right: 80px;">
					<h2 class="text-center">
						<a
							href="http://portal.medmais.com:8007/portal/p/0101001/pageworkflowview?processID=gratidaoMkt"
							onclick="window.open(this.href, '', 'resizable=no,status=no,location=no,toolbar=no,menubar=no,fullscreen=no,scrollbars=no,dependent=no'); return false;"> Gratidão Online</a>
					</h2>
					<h3 class="text-center">
						<i class="fluigicon fluigicon-timeline-social icon-md"></i>
						<a
							href="http://portal.medmais.com:8007/portal/p/0101001/pageworkflowview?processID=gratidaoMkt"
							onclick="window.open(this.href, '', 'resizable=no,status=no,location=no,toolbar=no,menubar=no,fullscreen=no,scrollbars=no,dependent=no'); return false;"> Clique Aqui e Expresse Sua Gratidão</a>
					</h3>
					<table name="tb_gratidaoOnline" id="tb_gratidaoOnline" class="table"
						style="display: flex;align:center">

						<thead style="flex: 100%;">
							<tr style="background: crimson;">
								<th
									style="width: 30%;font-weight: bold;font-size: large;color: white;text-align: center;">MedMember</th>
								<th
									style="font-weight: bold;font-size: large;color: white; text-align: center;">Gratidão</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</body>
</html>