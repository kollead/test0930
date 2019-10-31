<%@page import="sns.member.db.MemberDAO"%>
<%@page import="sns.member.db.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="ko">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="" />
<meta name="keywords" content="" />

<title>Winku Social Network Toolkit</title>

<link rel="icon" href="./images/fav.png" type="image/png" sizes="16x16">
<link rel="stylesheet" href="./css/main.min.css">
<link rel="stylesheet" href="./css/style2.css">
<link rel="stylesheet" href="./css/color.css">
<link rel="stylesheet" href="./css/responsive.css">

<script type="text/javascript">

</script>
</head>
<body>


	<!--<div class="se-pre-con"></div>-->
	<div class="theme-layout">
		<div class="postoverlay"></div>
		<div class="menuoverlay"></div>
		<%
		if(session.getAttribute("email") == null){
			response.sendRedirect("./Login.me");	
		}else{
			%>
			<jsp:include page="../inc/webTop.jsp" ></jsp:include>
			<%
		}
		%>
		<!-- 모바일 상단 -->
		<%-- <jsp:include page="../inc/responsiveTop.jsp" ></jsp:include> --%>
		<!-- /모바일 상단 -->
		<!-- 웹페이지 상단 -->
		<%-- <%
		if(session.getAttribute("email") == null){
			%>
			<jsp:include page="../inc/webTop_noLogin.jsp" />
			<%
		}else{
			%>
			<jsp:include page="../inc/webTop.jsp" />
			<%
		}
		%> --%>
		<!-- /웹페이지 상단 -->

		<!-- 웹페이지 오른쪽 채팅 바 -->
		<%-- <jsp:include page="../inc/rightFriendList.jsp"></jsp:include> --%>
		<div style="width: 70%; margin-left: 10%;">
		<section>
		<div class="gap2 gray-bg">
			<div class="container">
				<div class="row">
					<div class="col-lg-12">
						<div class="row merged20" id="page-contents">
							<!-- 왼쪽 사이드 -->
							<div class="col-lg-3">
								<aside class="sidebar static left">
								
									<!-- Shortcuts -->
									<jsp:include page="../inc/shortcuts.jsp"/>
									<!-- /Shortcuts -->
									
									<!-- Who's follownig -->
									<div class="widget stick-widget">
										<h4 class="widget-title">Who's follownig</h4>
										<ul class="followers">
											<li>
												<figure>
													<img src="./images/resources/friend-avatar2.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Kelly Bill</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
											<li>
												<figure>
													<img src="./images/resources/friend-avatar4.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Issabel</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
											<li>
												<figure>
													<img src="./images/resources/friend-avatar6.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Andrew</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
											<li>
												<figure>
													<img src="./images/resources/friend-avatar8.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Sophia</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
											<li>
												<figure>
													<img src="./images/resources/friend-avatar3.jpg" alt="">
												</figure>
												<div class="friend-meta">
													<h4>
														<a href="time-line.html" title="">Allen</a>
													</h4>
													<a href="#" title="" class="underline">Add Friend</a>
												</div>
											</li>
										</ul>
									</div>
									<!-- /who's following -->
								</aside>
							</div>
							<!-- /왼쪽 사이드 -->
							
							<!-- 중간 -->
							<div class="col-lg-6">
								<!-- 글 작성 -->
								<jsp:include page="../board/write.jsp" />
								<!-- /글 작성 -->

								<!-- 뉴스피드 -->
								<div class="loadMore">
									<!-- 게시글1 -->
									<jsp:include page="../board/boardList.jsp" />
									<!-- /게시글1 -->
								</div>
								<!-- 뉴스피드 -->
							</div>
							<!-- /중간 -->

							<!-- 오른쪽  -->
							<div class="col-lg-3">
								<aside class="sidebar static right">
									<div class="widget">
										<h4 class="widget-title">Your page</h4>
										<div class="your-page">
											<figure>
												<!-- <a href="" title=""> -->
													<img src="./images/resources/friend-avatar9.jpg" alt="">
												<!-- </a> -->
											</figure>
											<div class="page-meta">
												<%
												String email = (String)session.getAttribute("email");
												if(email != null){
													MemberDTO mdto = new MemberDTO();
													mdto = new MemberDAO().selectMember(email);
													%>
													<a href="./TimeLine.my?id=<%=mdto.getM_num() %>" title="" class="underline">내 페이지</a>
													<%
												}else{
													%>
													<a href="./TimeLine.my" title="" class="underline">내 페이지</a>
													<%
												}
												%>
												
												<span>
													<i class="ti-comment"></i>
													<a href="insight.html" title="">Messages<em>9</em></a>
												</span>
												<span>
													<i class="ti-bell"></i>
													<a href="insight.html" title="">Notifications <em>2</em></a>
												</span>
											</div>
											<div class="page-likes">
												<ul class="nav nav-tabs likes-btn">
													<li class="nav-item">
														<a class="active" href="#link1"data-toggle="tab">likes</a>
													</li>
													<li class="nav-item">
														<a class="" href="#link2" data-toggle="tab">views</a>
													</li>
												</ul>
												<!-- Tab panes -->
												<div class="tab-content">
													<div class="tab-pane active fade show " id="link1">
														<span>
															<i class="ti-heart"></i>884
														</span>
														<a href="#" title="weekly-likes">35 new likes this week</a>
														<div class="users-thumb-list">
															<a href="#" title="Anderw" data-toggle="tooltip">
																<img src="./images/resources/userlist-1.jpg" alt="">
															</a>
															<a href="#" title="frank" data-toggle="tooltip">
																<img src="./images/resources/userlist-2.jpg" alt="">
															</a>
															<a href="#" title="Sara" data-toggle="tooltip">
																<img src="./images/resources/userlist-3.jpg" alt="">
															</a>
															<a href="#" title="Amy" data-toggle="tooltip">
																<img src="./images/resources/userlist-4.jpg" alt="">
															</a>
															<a href="#" title="Ema" data-toggle="tooltip">
																<img src="./images/resources/userlist-5.jpg" alt="">
															</a>
															<a href="#" title="Sophie" data-toggle="tooltip">
																<img src="./images/resources/userlist-6.jpg" alt="">
															</a>
															<a href="#" title="Maria" data-toggle="tooltip">
																<img src="./images/resources/userlist-7.jpg" alt="">
															</a>
														</div>
													</div>
													<div class="tab-pane fade" id="link2">
														<span>
															<i class="ti-eye"></i>440
														</span>
														<a href="#" title="weekly-likes">440 new views this week</a>
														<div class="users-thumb-list">
															<a href="#" title="Anderw" data-toggle="tooltip">
																<img src="./images/resources/userlist-1.jpg" alt="">
															</a> <a href="#" title="frank" data-toggle="tooltip">
																<img src="./images/resources/userlist-2.jpg" alt="">
															</a>
															<a href="#" title="Sara" data-toggle="tooltip">
																<img src="./images/resources/userlist-3.jpg" alt="">
															</a>
															<a href="#" title="Amy" data-toggle="tooltip">
																<img src="./images/resources/userlist-4.jpg" alt="">
															</a> <a href="#" title="Ema" data-toggle="tooltip">
																<img src="./images/resources/userlist-5.jpg" alt="">
															</a> <a href="#" title="Sophie" data-toggle="tooltip">
																<img src="./images/resources/userlist-6.jpg" alt="">
															</a> <a href="#" title="Maria" data-toggle="tooltip">
																<img src="./images/resources/userlist-7.jpg" alt="">
															</a>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- page like widget -->
									<!-- <div class="widget">
										<div class="banner medium-opacity bluesh">
											<div class="bg-image"
												style="background-image: url(./images/resources/baner-widgetbg.jpg)"></div>
											<div class="baner-top">
												<span><img alt="" src="./images/book-icon.png"></span>
												<i class="fa fa-ellipsis-h"></i>
											</div>
											<div class="banermeta">
												<p>create your own favourit page.</p>
												<span>like them all</span>
												<a data-ripple="" title="" href="#">start now!</a>
											</div>
										</div>
									</div> -->
									<!-- <div class="widget stick-widget">
										<h4 class="widget-title">Profile intro</h4>
										<ul class="short-profile">
											<li>
												<span>about</span>
												<p>Hi, i am jhon kates, i am 32 years old and worked as a web developer in microsoft</p>
											</li>
											<li>
												<span>fav tv show</span>
												<p>Sacred Games, Spartcus Blood, Games of Theron</p>
											</li>
											<li>
												<span>favourit music</span>
												<p>Justin Biber, Shakira, Nati Natasah</p>
											</li>
										</ul>
									</div> -->
								</aside>
							</div>
							<!-- /오른쪽 -->
						</div>
					</div>
				</div>
			</div>
		</div>
		</section>
		</div>
		<!-- bottom -->
		<jsp:include page="../inc/bottom.jsp" />
		<!-- /bottom -->
	</div>
	
	<!-- 웹페이지 쇼핑백 메뉴 -->
	<div class="side-panel">
		<jsp:include page="../inc/webTopRightSidePanel.jsp" />
	</div>
	<!-- 웹페이지 쇼핑백 메뉴 -->

	<script src="./js/main.min.js"></script>
	<script src="./js/script.js"></script>
	<script src="./js/map-init.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA8c55_YHLvDHGACkQscgbGLtLRdxBDCfI"></script>

</body>
</html>