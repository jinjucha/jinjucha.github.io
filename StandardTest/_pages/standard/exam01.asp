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
<script type="text/javascript" src="/inc/js/validate.js?_v=10119"></script>

<!-- #include virtual = "/_pages/inc/layout/first.asp" -->
<!-- #include virtual = "/_pages/inc/layout/auth_check.asp" -->
<!-- #include virtual="/_lib/global/func.asp" -->
<!-- #include virtual="/_lib/dsn/dsn.asp" -->
<!-- #include virtual="/_lib/global/ado.asp" -->
<!-- #include virtual="/inc/domain/bbsfunc.asp" -->
<!-- #include virtual="/inc/domain/globalheader.asp" --><%'DOCTYPE, HTML 포함%>

<%
	L_MENU = "0"
	M_MENU = "1"
	S_MENU = "1"

	inspcd = ckstr(r("inspcd"),1)

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

function goStart() {
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
					<li>
					<% If C_MBR_TP = "0" Or C_MBR_TP = "4" Or C_MBR_TP = "5" Then %>
					<a href="./exam05_2_2.asp"><span>검사결과</span></a>
					<% ELSE %>
					<a href="./exam05.asp"><span>검사결과</span></a>
					<% End IF%>
					</li>
				</ul>

			<!-- standardArea -->
			<form id="mainForm" name="mainForm"  method="post" action="./inspcProc1.asp">
				<input type="hidden" name="action" value="sel" />
				<input type="hidden" name="inspcd" value="<%=inspcd%>" />
				<input type="hidden" name="mbr_tp" value="<%=C_MBR_TP%>" /><!--멤버 코드-->
				<div class="standardArea">
					<div class="cont cont02">
						<div class="exam01">
							<h4>검사 코드 입력하세요.</h4>
							<div class="pr">
								<p>
									<label for="examcode"><b>검사코드</b></label> <input type="text" id="inspChkCd" name="inspChkCd" maxlength="" class="txt txtbd" style="width:285px;height:38px;" />
									<a href="javascript:goStart();" class="btn_ok"><img src="https://pic.neungyule.com/nekids/img/standard/btn_ok.png" alt="확인" /></a>
								</p>
							</div>
						</div>
					</div>
				</div>
			</form>
			<!-- //standardArea -->
		</div><!-- standardArea -->
		<!-- #include virtual = "/_pages/inc/layout/quick.asp" -->
	</div><!-- //container -->
	<!-- #include virtual = "/_pages/inc/layout/footer.asp" -->
</div><!-- //wrapper -->
</body>
</html>