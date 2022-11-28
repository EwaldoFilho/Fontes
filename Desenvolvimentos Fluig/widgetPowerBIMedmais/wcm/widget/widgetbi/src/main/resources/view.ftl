
<head>

</head>
<style type="text/css">
    .bg_video {
        position: fixed;
        right: 0;
        bottom: 0;
        min-width: 100%;
        min-height: 100%;
        width: auto;
        height: auto;
        z-index: -1000;
        background: url(images/torre.jpg) no-repeat;
        background-size: cover;
    }
     
</style>
<body>
	<video autoplay loop
		poster="http://portal.medmais.com:8007/portal/api/servlet/image/0101001/custom/abstrato-branco-3d.jpg"
		class="bg_video">
		<source
			src="https://www.medmais.com/wp-content/themes/medmais/video/Medmais_Institucional_Site_2.mp4"
			type="video/webm">
	</video>
	<header>
	<nav class="main-menu">
		<ul>
			<li class="has-subnav">
				<a href="#" class="dash" onclick="myFunction()">
					<i class="fa fa-laptop fa-2x"></i>
					<span class="nav-text">
						DashBoard TeleMedicina
					</span>
				</a>

			</li>
			<li class="has-subnav">
				<a href="#" class="rel" onclick="myFunction1()">
					<i class="fa fa-list fa-2x"></i>
					<span class="nav-text">
						Relatórios
					</span>
				</a>
			</li>			
		</ul>
		
	</nav>
	</header>
	<div id="dashframe" >
		<iframe title="bi-acomp-telemedicina_4" width="100%" height="700" style="padding-left: 100px;"
			src="https://app.powerbi.com/reportEmbed?reportId=92623389-dd04-4e60-b408-5df1f386f071&autoAuth=true&ctid=de13c93e-7eb2-4032-a471-2dc1644e2e65"
			frameborder="0" allowFullScreen="true"></iframe>
	</div>
	<div id="relframe" >
		
			<iframe title="bi-acomp-telemedicina_5_Relatorio" width="100%"
	height="700" style="padding-left: 100px;"
	src="https://app.powerbi.com/reportEmbed?reportId=b9b080c8-469e-4949-ba9d-f52fb6e02d5d&autoAuth=true&ctid=de13c93e-7eb2-4032-a471-2dc1644e2e65"
	frameborder="0" allowFullScreen="true"></iframe>

</body>
<script type="text/javascript">
	$("#dashframe").hide();
	$("#relframe").hide();


	function myFunction() {
	var x = document.getElementById("dashframe");
	var y = document.getElementById("relframe");
	if (x.style.display === "none") {
	x.style.display = "block";
	y.style.display = "none";
	} else {
	x.style.display = "none";
	}
	}

	function myFunction1() {
	var x = document.getElementById("relframe");
	var y = document.getElementById("dashframe");
	if (x.style.display === "none") {
	x.style.display = "block";
	y.style.display = "none";
	} else {
	x.style.display = "none";
	}
	}
	function myFunction3(elemento,evento){
        WCMAPI.logoff(); //Aqui é pra chamar a API que fica no JS
        }
        
        
</script>
</html>