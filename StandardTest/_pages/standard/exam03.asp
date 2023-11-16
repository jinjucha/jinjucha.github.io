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
	page		= d_int(ckstfr(r("page"),1), 1)
	pageSize	= 10
	L_MENU = "0"
	M_MENU = "1"
	S_MENU = "1"

	'검사코드 유효 정보
	inspChkCd		= ckstr(r("inspChkCd"),1)
	inspStrtYmd		= ckstr(r("inspStrtYmd"),1)
	inspEndYmd		= ckstr(r("inspEndYmd"),1)
	ttl				= ckstr(r("ttl"),1)
	childClassNm	= ckstr(r("childClassNm"),1)
	schParams		= "&inspChkCd=" & inspChkCd & "&inspStrtYmd=" & inspStrtYmd & "&inspEndYmd=" & inspEndYmd & "&ttl=" & ttl & "&childClassNm=" & childClassNm 
	Dim sslPort 
	If request.servervariables("LOCAL_ADDR") = "61.32.254.47" Then
		sslPort = ""
	Else
		sslPort = ""
	End If
%>
<%
Dim param : Set param = New Parameter : param.FillByRequest
Dim userid : userid = C_MBR_ID
Dim radioNm : radioNm = "radio" + ckstr(r(page),1)

'검사 코드 판별
query = "usp_cjj_tblaplClassMng_view @inspChkCd = '" & inspChkCd & "'"
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then 
		response.write "<script language='javascript'>"
		response.write "alert('검사 코드를 입력하세요.');"
		response.write "</script>"
		
		go("./exam01.asp")
	Else
		rsclassnmGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing

'유아 검사 타이틀 리스트 
query = "[usp_cjj_tbl_inspc_c01_question_list]	@pageSize		= '" & pageSize & "'," &_
							"@title		= '" & "Y" & "'"
Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then 
		rstitleGet = ""
	Else
		rstitleGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing

'유아 검사 질문 리스트
query = "[usp_cjj_tbl_inspc_c01_question_list]	@page		= " & page & ", " &_
							"@pageSize		= '" & pageSize & "'," &_
							"@title		= '" & "N" & "'"
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then 
		rscontentsGet = ""
	Else
		rscontentsGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- #include virtual = "/_pages/inc/layout/head.asp" -->
<script type="text/javascript">

function goNext(page) {
	//var nextPage = <%=page%> + 1;
		var f = document.frm;	
		var returnVal = "true";
		//풀지 않은 문제가 있을 때 전송 여부
		for(var i = 1; i <= <%=pageSize%>; i++) {
			var radioNm = "radio" + <%=page%> + i;
			if($('input[name='+ radioNm +' ]:checked').val() == undefined) {
				alert(i+ "문항을 아직 풀지 않았습니다.");
				returnVal = "false";		
				break;
			}
		}
		goSaveAnswer(returnVal, page);
}

function goSaveAnswer(val, page) {

	if(val == "true") {

		var formData = $("#frm").serialize();
		$.ajax({
			type : "POST", 
			url : "/_pages/standard/json/inspc_ajax_answer.asp",
			data : formData,
			dataType : "json",
			success : function(data) {
				console.log(data);
			},
			fail : function() {
				alert("서버오류가 발생했습니다.");
			}
	   });
	 }else {

	 }

	var nextpage = page + 1;
	 location.href = "./exam03.asp?inspChkCd=" + "<%=inspChkCd%>" +"&page="+nextpage;
}

function goSubmit() {

		var f = document.frm;	
		if(confirm("제출하시겠습니까?")) {
			
			//f.submit();
			alert("검사가 완료되었습니다. 검사결과는 2주 이내 홈페이지에서 확인하실 수 있습니다.");
		}else{
			alert("취소되었습니다.");
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
			<h2>유아 발달 표준화 검사</h2>
			<!-- #include virtual = "/_pages/inc/layout/location.asp" -->
		</div><!-- //visualCont -->
	</div><!-- //visualArea -->
	<!-- container -->
	<div id="container">
		<!-- contArea -->
		<div id="contArea">
				<!-- titleArea -->
			<div class="titleArea titleIconN1">
				<h3>유아 발달 표준화 검사 </h3>
				<b>유아 표준화 검사로 우리아이의 특성을 파악해 보세요. </b>
			</div><!-- //titleArea -->
				<ul class="tabTypeD std">
					<li ><a href="javascript://"><span>유아 발달<br />표준화 검사란?</span></a></li>
					<li class="on"><a href="javascript://"><span>검사하기</span></a></li>
					<li><a href="javascript://"><span>검사결과</span></a></li>
				</ul>

			<!-- standardArea -->
			<form id="frm" name="frm"  method="post" action="./inspcProc1.asp">
			<input type="hidden" name="action" value="ins" />
			<input type="hidden" name="inspChkCd" value="<%=inspChkCd%>"/>
			<input type="hidden" name="page" value="<%=page%>"/>
			<input type="hidden" name="childClassNm" value="<%=childClassNm%>"/>
			<div class="standardArea">
				<div class="qusbx">
						<div class="cont01">
							<h3><em>영•유아</em> 발달검사</h3>
							<p>영•유아 발달검사는 25개월~48개월의 영•유아를 대상으로 검사합니다.<br />본 검사는 자연탐구, 의사소통, 신체운동, 사회단계, 자조행동과 관련된 5가지 요인으로 구성되어 있습니다.</p>
						</div>
						<div class="cont02">
							<div class="top">
								<% If IsArray(rstitleGet) Then %>
								<h5><%=rstitleGet(4,0)%></h5>
								<p><%=rstitleGet(4,1)%></p>

								<%
								End If %>
							</div>
							<div class="mid type01">
				<%
				
				If IsArray(rscontentsGet) Then
					rs_totCnt = rscontentsGet(0,0)
					'rowNum = rs_totCnt - ((page - 1 ) * pageSize)
					For i = 0 To UBound(rscontentsGet, 2)
						'rs_mbrId		= rsGet(1,i)
						
				%>					
								<ul>
									<li>
										<span><%=rscontentsGet(1,i)%>. <%=rscontentsGet(4,i)%></span>
										<ol><!--hname="선택" required="required"-->
											<!-- 데이터 리스트는 관리자에서 보이게 -->
											<li><input type="radio" id="rd<%=page%><%=i+1%>_1" data-item="1" name="radio<%=page%><%=i+1%>" value="1" /><label for="rd<%=page%><%=i+1%>_1"><span>1</span>예</label></li>
											<li><input type="radio" id="rd<%=page%><%=i+1%>_2" data-item="1" name="radio<%=page%><%=i+1%>" value="2" /><label for="rd<%=page%><%=i+1%>_2"><span>2</span>아니오</label></li>
											<li><input type="radio" id="rd<%=page%><%=i+1%>_3" data-item="1" name="radio<%=page%><%=i+1%>" value="3" /><label for="rd<%=page%><%=i+1%>_3"><span>3</span>가끔</label></li>
											<li><input type="radio" id="rd<%=page%><%=i+1%>_4" data-item="1" name="radio<%=page%><%=i+1%>" value="4" /><label for="rd<%=page%><%=i+1%>_4"><span>4</span>잘모르겠다</label></li>
										</ol>
									</li>

								</ul>
				<%
						rowNum = rowNum - 1
					Next
				Else
				%>
				<tr>
					<td colspan="7">등록된 데이터가 없습니다.</td>
				</tr>
				<%
				End If
				%>

				<div class="btm">
								<!--
								<div class="paging pageOrg">
								<%
									If rs_totCnt > 0 Then
										Dim pg : Set pg = new FrontPaging
										Dim pUrl : pUrl = RURL("exam03.asp")	
								'				link url, 페이지, 총게시물소, 페이지사이즈, 페이징사이즈
										pg.InitFront pUrl, page, rs_totCnt, pageSize, pageSize, ""
										'pg.InitFront "", page, rs_totCnt, pageSize, pageSize, ""
										pg.Write
									End If
								%>
								</div>
								-->
							<div class="btnArea">	
									<a href="avascript:goPrev();" class="btnCm btnGrayA btnPdB"><b>이전</b></a>
									<a href="javascript:goNext(<%=page%>);" class="btnCm btnOrgF btnPdB"><b>다음</b></a>
									<a href="javascript://" class="btnCm btnOrgF btnPdB"><b>제출</b></a>
							</div>
							<div class="btnArea">
								<a href="javascript:goSubmit();" class="btnCm btnOrgF btnPdB"><b>제출</b></a>


							</div>
							

				</div>

							</div>
		
						</div>
				</div>
				<input type="hidden" name="schParams" value="<%=schParams%>">
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