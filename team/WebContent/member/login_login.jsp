<%@page import="sns.member.db.MemberDAO"%>
<%@page import="sns.member.action.ActionForward"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Winku Social Network Toolkit</title>
    <link rel="icon" href="images/fav.png" type="image/png" sizes="16x16"> 
    
    <link rel="stylesheet" href="css/main.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/color.css">
    <link rel="stylesheet" href="css/responsive.css">
    <script src="js/jquery.js"></script>
    <script type="text/javascript">
    
    /* $(document).ready(function(){    	  
    	  $("#email").blur(function(){
    	    var email = $("#email").val();
    	    alert(email);
    	    $.ajax({
    	    	url: "./IdCheck",
    	    	type: "POST",
    	    	data: {email:email},
    	    	dataType:"text",
    	    	success: function(data){
    	    		if(data==1){
    	    			$("#idcheck").append("사용할 수 없는 email입니다");
    	    		}
    	    		if(data==0){
    	    			$("#idcheck").append("사용할 수 있는 email입니다");
    	    		}
    	    	},
    	    	error: function(data){
    	    		alert("error");
    	    	}    	    	
    	    });
    	  });
    	}); */
   
    
    </script>
</head>
<body>
<%	
	
	System.out.println("Login Java Cookies!---------------");
	
	Cookie[] cookies=request.getCookies();
	String cookieE="";
	String cookieI="";
	
	
	if(cookies !=null){
		for(Cookie c : cookies){
			if(c.getName().equals("AutoLog")){//email이 저장된 쿠키
				cookieE=c.getValue();
				System.out.println("AutoLog: "+cookieE);
			}
			if(c.getName().equals("AutoLogI")){//ip가 저장된 쿠키
				cookieI=c.getValue();
				System.out.println("AutoLogI: "+cookieI);
			}			
		}
		
		if(cookieI!=null&&cookieE!=null){
			if(cookieI.equals(request.getRemoteAddr())){//쿠키에 저장된 ip가 현재의 ip와 같고
				MemberDAO mdao=new MemberDAO();
				int check=mdao.emailCheck(cookieE);//email이 db에 저장되어 있다면
				if(check==1){
					HttpSession sessionAutoLog=request.getSession();//세션을 만들어
					request.setAttribute("email", cookieE);
					System.out.println("AUTOLOGIN-----");
					ActionForward forward=new ActionForward();
					forward.setPath("./Main.me");//메인으로 보내준다 
					forward.setRedirect(true);
					response.sendRedirect(forward.getPath());
				}else{//쿠키의 ip와 ip는 같지만 db에 존재하지 않는 email라면
					System.out.println("존재하지 않는 email이므로 쿠키 삭제");
					Cookie cookie=new Cookie("AutoLog",null);
					cookie.setMaxAge(0);
					response.addCookie(cookie);
					Cookie cookieP=new Cookie("AutoLogI",null);
					cookieP.setMaxAge(0);
					response.addCookie(cookie);					
				}
			}
		}
		
	}
%>

<!--<div class="se-pre-con"></div>-->
<div class="theme-layout">
	<div class="container-fluid pdng0">
		<div class="row merged">
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
				<div class="land-featurearea">
					<div class="land-meta">
						<h1>Winku</h1>
						<p>
							Winku is free to use for as long as you want with two active projects.
						</p>
						<div class="friend-logo">
							<span><img src="images/wink.png" alt=""></span>
						</div>
						<a href="#" title="" class="folow-me">Follow Us on</a>
					</div>	
				</div>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
				<div class="login-reg-bg">
					<div class="log-reg-area sign">
						<h2 class="log-title">Login</h2>
							<p>
								회원이 아니신가요? <br>
								<a href="#" title=""> 사이트 먼저 살펴보기</a>
							</p>
						<form action="./LoginAction.me" method="post">
							<div class="form-group">	
							  <input type="text" id="email"  name="email" required="required" />
							  <label class="control-label" for="input" id="email" name="email">이메일</label><i class="mtrl-select"></i>
							</div>
							<div id="idcheck"></div>
							<div class="form-group">	
							  <input type="password"  name="pass" required="required"/>
							  <label class="control-label" for="input" name="pass">비밀번호</label><i class="mtrl-select"></i>
							</div>
							<div class="checkbox">
							  <label>
								<input type="checkbox" checked="checked" name="loginCheck" value="1"/><i class="check-box"></i>로그인 상태 유지
							  </label>
							</div>
							<a href="#" title="" class="forgot-pwd">비밀번호를 잊으셨나요?</a>
							<div class="submit-btns">
							
								<button class="mtr-btn signin" type="submit"><span>로그인</span></button>
								<button class="mtr-btn signup" type="button"><span>회원가입</span></button>
							</div>
						</form>
					</div>

					<!--Register 폼-->
					<div class="log-reg-area reg">
						<h2 class="log-title">회원가입</h2>
							<p>
								회원이 아니신가요? <br>
								<a href="#" title=""> 사이트 먼저 살펴보기</a>
							</p>
						<form action="./EmailAuth.me" method="post">
							<div class="form-group">	
							  <input type="text" required="required"/>
							  <label class="control-label" for="input" name="f_name">성(First Name)</label><i class="mtrl-select"></i>
							</div>
							<div class="form-group">	
							  <input type="text" required="required"/>
							  <label class="control-label" for="input" name="l_name">이름(Last Name)</label><i class="mtrl-select"></i>
							</div>
							<div class="form-group">	
							  <input type="password" required="required"/>
							  <label class="control-label" for="input" name="pass">비밀번호</label><i class="mtrl-select"></i>
							</div>
							<div class="form-radio">
							  <div class="radio">
								<label>
								  <input type="radio" name="gender" checked="checked"/><i class="check-box"></i>남자
								</label>
							  </div>
							  <div class="radio">
								<label>
								  <input type="radio" name="gender"/><i class="check-box"></i>여자
								</label>
							  </div>
							</div>
							<div class="form-group">	
							  <input type="text" required="required"/>
							  <label class="control-label" for="input" name="email">이메일</label><i class="mtrl-select"></i>
							</div>
							<div class="checkbox">
							  <label>
								<input type="checkbox" checked="checked"/><i class="check-box"></i>약관에 동의하십니까?
							  </label>
							</div>
							<a href="#" title="" class="already-have">로그인 화면으로</a>
							<div class="submit-btns">
								<button class="mtr-btn signup" type="button"><span>가입하기</span></button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
	<script src="../js/main.min.js"></script>
	<script src="../js/script.js"></script>

</body>
</html>