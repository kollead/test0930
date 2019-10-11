<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<div class="responsive-header">
		<!-- 三, 로고, 설정 -->
		<div class="mh-head first Sticky">
			<span class="mh-btns-left">
				<a class="" href="#menu">
					<i class="fa fa-align-justify"></i>
				</a>
			</span>
			<span class="mh-text">
				<a href="../newsfeed.html" title="">
					<img src="./images/logo2.png" alt="">
				</a>
			</span>
			<span class="mh-btns-right">
				<a class="fa fa-sliders" href="#shoppingbag"></a>
			</span>
		</div>
		<!-- 三, 로고, 설정 -->

		<!-- 모바일 친구 찾기 -->
		<div class="mh-head second">
			<form class="mh-form">
				<input placeholder="search" />
				<a href="#/" class="fa fa-search"></a>
			</form>
		</div>
		<!-- 모바일 친구 찾기 -->

		<!-- 모바일 왼쪽 메뉴 -->
		<nav id="menu" class="res-menu">
			<ul>
				<li><a href="#" title="">Home</a></li>
				<li><a href="../member/time-line.jsp" title="">Time Line</a></li>
				<li><span>Account Setting</span></li>
				<li><span>forum</span></li>
				<li><span>Our Shop</span></li>
				<li><span>Our Blog</span></li>
				<li><span>Portfolio</span></li>
				<li><span>Support & Help</span></li>
				<li><span>More pages</span></li>
				<li><a href="about.html" title="">about</a></li>
				<li><a href="about-company.html" title="">About Us2</a></li>
				<li><a href="contact.html" title="">contact</a></li>
				<li><a href="contact-branches.html" title="">Contact Us2</a></li>
				<li><a href="widgets.html" title="">Widgts</a></li>
			</ul>
		</nav>
		<!-- 모바일 왼쪽 메뉴 -->

		<!-- 모바일 쇼핑백 메뉴 -->
		<nav id="shoppingbag">
			<div>
				<div class="">
					<form method="post">
						<div class="setting-row">
							<span>use night mode</span>
							<input type="checkbox" id="nightmode" />
						</div>
						<div class="setting-row">
							<span>Notifications</span> <input type="checkbox" id="switch2" />
						</div>
						<div class="setting-row">
							<span>Notification sound</span>
							<input type="checkbox" id="switch3" />
						</div>
						<div class="setting-row">
							<span>My profile</span>
							<input type="checkbox" id="switch4" /> 
						</div>
						<div class="setting-row">
							<span>Show profile</span>
							<input type="checkbox" id="switch5" />
						</div>
					</form>
						
					<h4 class="panel-title">Account Setting</h4>
						
					<form method="post">
						<div class="setting-row">
							<span>Sub users</span>
							<input type="checkbox" id="switch6" /> 
						</div>
						<div class="setting-row">
							<span>personal account</span>
							<input type="checkbox" id="switch7" />
						</div>
						<div class="setting-row">
							<span>Business account</span>
							<input type="checkbox" id="switch8" />
						</div>
						<div class="setting-row">
							<span>Show me online</span>
							<input type="checkbox" id="switch9" />
						</div>
						<div class="setting-row">
							<span>Delete history</span>
							<input type="checkbox" id="switch10" />
						</div>
						<div class="setting-row">
							<span>Expose author name</span>
							<input type="checkbox" id="switch11" />
						</div>
					</form>
				</div>
			</div>
		</nav>
		<!-- 모바일 쇼핑백 메뉴 -->
	</div>