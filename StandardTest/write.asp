<!-- #include virtual = "/_pages/_lib/unicode.asp" -->
<%
'----------------------------------------------------
' 페이지이름 : /_pages/standard/index.asp
' 페이지설명 : 영.유아 표준화 검사
' 페이지경로 :
'----------------------------------------------------
' 작성일 :
' 작성자 :
'----------------------------------------------------
' 수정내역
' (수정일 / 수정자 / 수정내역)
'----------------------------------------------------
'Option Explicit
%>
<!-- #include virtual = "/_lib/global/sqlinjection_check.asp" -->
<!-- #include virtual = "/_pages/inc/layout/first.asp" -->
<!-- #include virtual = "/_pages/inc/layout/auth_check.asp" -->

<%
	'L_MENU = "0"
	L_MENU = "11"
	M_MENU = "1"
	S_MENU = "1"

	Dim sslPort 
	If request.servervariables("LOCAL_ADDR") = "61.32.254.47" Then
		sslPort = ""
	Else
		sslPort = ""
	End If
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- #include virtual = "/_pages/inc/layout/head.asp" -->
<script type="text/javascript">
$(function(){	
	$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('on off');
			$('.tab_cont').removeClass('on');
			$(this).prevAll("li").addClass("off");

			$(this).addClass('on');
			$("#"+tab_id).addClass('on');
		});
});

function goWrite() {
	var f = document.mainForm;

	if (f.inspChkCd.value == "") {
		alert("검사 코드를 입력해주세요");
		f.inspChkCd.focus();
		return;
	}else {
		f.submit();
	}
}
</script>
</head>
<body>
<div id="wrapper">
	<!-- #include virtual = "/_pages/inc/layout/header.asp" -->
	<!-- visualArea -->
	<div class="visualArea visualA">
		<div class="visualCont visualAbg">
			<h2>유아 발달 표준화 검사 </h2>
			<!-- #include virtual = "/_pages/inc/layout/location.asp" -->
		</div><!-- //visualCont -->
	</div><!-- //visualArea -->
	<!-- container -->
	<div id="container">
		<!-- contArea -->
		<div id="contArea">
				<!-- titleArea -->
			<div class="titleArea titleIconN1">
				<h3>유아 발달 표준화 검사</h3>
				<b>유아 표준화 검사로 우리아이의 특성을 파악해 보세요. </b>
			</div><!-- //titleArea -->

				<ul class="tabTypeD std">
					<li ><a href="./index.asp"><span>유아 발달<br />표준화 검사란?</span></a></li>
					<li class="on"><a href="javascript://"><span>검사하기</span></a></li>
					<li><a href="./exam05.asp"><span>검사결과</span></a></li>
				</ul>

			<!-- standardArea -->
			<form name="hpwrite" action="/json/write_proc.asp" method="post">
					<table border="0" width="100%" cellpadding="0" cellspacing="0">
					  <col width="120" />
					  <col />
					  <col />
					  <tr>
						<td height="25"></td>
						<td>이름</td>
						<td>연락처</td>
						<td>E-mail</td>
					  </tr>
					  <%
					  dim tkb_num, i
					  tkb_num = 5
					  if tkb_num > 0 then
						for i = 1 to tkb_num step 1
					  %>
					  <tr>
						<td style='padding-left:20px; height:30px;'>· <% response.write i %></td>
						<td><input type="text" name="tk_buyer_name<% response.write i %>" style="width:110px;" value="" /></td>
						<td style="padding:0 10px 0 10px;"><input type="text" name="tk_buyer_tel<% response.write i %>" style="width:140px;" value="" /></td>
						<td><input type="text" name="tk_buyer_email<% response.write i %>" style="width:300px;" value="" /></td>
					  </tr>
					  <%  
						next
					  end if
					  %>
					</table>
					<input type="hidden" id="tkb_num" name="tkb_num" value="<%=tkb_num%>"/>
					<input type="submit" value="티켓구매" />
			</form>

			<!-- //standardArea -->
		</div><!-- standardArea -->



		<!-- #include virtual = "/_pages/inc/layout/quick.asp" -->
	</div><!-- //container -->
	<!-- #include virtual = "/_pages/inc/layout/footer.asp" -->
</div><!-- //wrapper -->

</body>
</html>