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
    '======================================================
    ' 레퍼러 체크
    '======================================================
    Function getRefererPage
    
        Dim refererValue, chkPos
        ' 호출한 페이지값을 받습니다.
        refererValue = Request.ServerVariables("HTTP_REFERER")
        ' 호출한 페이지 값이 없을 경우
        IF Len(refererValue) = 0 Then
            getRefererPage = ""
			response.write "<script language='javascript'>"
			response.write "alert('잘못된 경로입니다. 검사코드를 입력해주세요.');"
			response.write "</script>"
		
			go("./exam01.asp")
        End IF
    End Function
    '======================================================

	getRefererPage()

%>
<%
	page		= d_int(ckstr(r("page"),1), 1)
	pageSize	= 10
	lastPage	= 9
	L_MENU		= "0"
	M_MENU		= "1"
	S_MENU		= "1"

	'검사코드 유효 정보
	inspChkCd		= ckstr(r("inspChkCd"),1)
	inspStrtYmd		= ckstr(r("inspStrtYmd"),1)
	inspEndYmd		= ckstr(r("inspEndYmd"),1)
	ttl				= ckstr(r("ttl"),1)
	childClassNm	= ckstr(r("childClassNm"),1)
	childMbrNm		= ckstr(r("childMbrNm"),1) '아이 이름 추가
	childMbrBrtdy	= ckstr(r("childMbrBrtdy"),1)
	childMbrSex		= ckstr(r("childMbrSex"),1) '아이 성별 추가
	childClass		= ckstr(r("childClass"),1) '아이 지사정보 추가
	schParams		= "&inspChkCd=" & inspChkCd & "&inspStrtYmd=" & inspStrtYmd & "&inspEndYmd=" & inspEndYmd & "&ttl=" & ttl & "&childClassNm=" & childClassNm & "&childMbrNm=" & childMbrNm & "&childMbrBrtdy=" & childMbrBrtdy & "&childMbrSex=" & childMbrSex & "&childClass=" & childClass

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
query = "[usp_cjj_tbl_inspc_c01_question_list]	@page		= '" & page & "'," &_
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
	'Response.write query
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then
		rscontentsGet = ""
	Else
		rscontentsGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing

	'Response.write query
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- #include virtual = "/_pages/inc/layout/head.asp" -->
<script type="text/javascript">
var returnVal = "true";
$(function() {

	$("#submitBtn").css("display","none");

	if(<%=page%> == <%=lastPage%>) {
		$("#nextBtn").css("display", "none");
		$("#submitBtn").css("display", "");
	 }
});

function goNext(page) {
	var f = document.frm;
	var page = <%=page%>;
	var pageSize = <%=pageSize%>;
	var viewPageNumber = page * pageSize;

	if(page == <%=lastPage%>) {

		viewPageNumber = viewPageNumber-1;
	}

	//체크하지 않은 문항 판별
	for(var i = (page-1)*pageSize+1; i <= viewPageNumber; i++) {
		var radioNm = "radio" + i;
		if($('input[name='+ radioNm +' ]:checked').val() == undefined) {
			alert(i+ "문항을 아직 풀지 않았습니다.");
			returnVal = "false";
			break;
		}else {
			returnVal = "true";
		}
	}

	if(returnVal == "true") {
		goSaveAnswer(returnVal, page);
	}

}

function goSaveAnswer(val, page) {

	if(val == "true") {
		var formData = $("#frm").serialize();
		$.ajax({
			type : "POST",
			url : "/_pages/standard/json/inspc_C01_ajax_answer.asp",
			data : formData,
			dataType : "json",
			success : function(data) {
                //성공 시에만 조건 추가
                var nextpage = page + 1;
                if(<%=page%> != <%=lastPage%>) {
                    if(data.count == 10) {
                        location.href = "./exam03_01.asp?inspChkCd=" + "<%=inspChkCd%>" + "&childClassNm=" + "<%=childClassNm%>" + "&childMbrBrtdy=" + "<%=childMbrBrtdy%>"+ "&childMbrNm=" + "<%=childMbrNm%>"+ "&childMbrSex=" + "<%=childMbrSex%>" + "&childClass=" + "<%=childClass%>" + "&page="+nextpage;
                    }else {
                        alert("검사 중 서버오류가 발생했습니다. 관리자에게 문의해주세요.");
                        location.href = "index.asp";
                    }
                }
			},
			fail : function(e) {
                console.log(e);
				alert("서버오류가 발생했습니다. 관리자에게 문의해주세요.");
                location.href = "index.asp";
			}
	   });
	 }else {
		alert("아직 풀지 않은 문향이 있습니다.");
	 }
}

function goSubmit() {
	goNext(<%=page%>);
	var f = document.frm;
	if(returnVal == "true"){
		if(confirm("제출하시겠습니까?")) {
			f.submit();
			alert("검사가 완료되었습니다. 검사결과는 2주 이내 홈페이지에서 확인하실 수 있습니다.");
		}else{
			alert("취소되었습니다.");
		}
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
				<input type="hidden" name="pagesize" value="<%=pagesize%>"/>
                <input type="hidden" name="lastPage" value="<%=lastPage%>"/>
				<input type="hidden" name="userid" value="<%=userid%>"/>
				<input type="hidden" name="childClassNm" value="<%=childClassNm%>"/>
				<input type="hidden" name="childMbrNm" value="<%=childMbrNm%>"/>
				<input type="hidden" name="childMbrBrtdy" value="<%=childMbrBrtdy%>"/>
				<input type="hidden" name="childMbrSex" value="<%=childMbrSex%>"/>
				<input type="hidden" name="childClass" value="<%=childClass%>"/>
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

					'rowNum = rs_totCnt - ((page - 1 ) * pageSize)
					For i = 0 To UBound(rscontentsGet, 2)
						rs_num		 = rscontentsGet(1,i)
						rs_imageFile = rscontentsGet(6,i)
						rs_imageUrl  = rscontentsGet(10,i)
				%>
								<ul>
									<li>
										<span><%=rs_num%>. <%=rscontentsGet(4,i)%>
										<% If rs_imageUrl <> "" Then %>
										<br /><img src="<%=rs_imageUrl%>" alt="" />
										<% End if%>
										</span>
										<%If rs_imageFile = "N" then%>
											<ol>
												<li><input type="radio" id="rd<%=rs_num%>_1" data-item="1" name="radio<%=rs_num%>" value="1" /><label for="rd<%=rs_num%>_1"><span>1</span>예</label></li>
												<li><input type="radio" id="rd<%=rs_num%>_2" data-item="1" name="radio<%=rs_num%>" value="2" /><label for="rd<%=rs_num%>_2"><span>2</span>가끔</label></li>
												<li><input type="radio" id="rd<%=rs_num%>_3" data-item="1" name="radio<%=rs_num%>" value="3" /><label for="rd<%=rs_num%>_3"><span>3</span>아니오</label></li>
												<li><input type="radio" id="rd<%=rs_num%>_4" data-item="1" name="radio<%=rs_num%>" value="4" /><label for="rd<%=rs_num%>_4"><span>4</span>잘모르겠다</label></li>
											</ol>
										<%Else%>
											<ol>
												<li><input type="radio" id="rd<%=rs_num%>_1" data-item="1" name="radio<%=rs_num%>" value="1" /><label for="rd<%=rs_num%>_1"><span>1</span>정답</label></li>
												<li><input type="radio" id="rd<%=rs_num%>_2" data-item="1" name="radio<%=rs_num%>" value="2" /><label for="rd<%=rs_num%>_2"><span>2</span>오답</label></li>
												<li><input type="radio" id="rd<%=rs_num%>_3" data-item="1" name="radio<%=rs_num%>" value="3" /><label for="rd<%=rs_num%>_3"><span>3</span>확실치 않음</label></li>
											</ol>
										<%End IF%>
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
					<div class="paging_num"><strong><%=page%>/</strong><%=lastPage%></div>
					<div class="btnArea" id="nextBtn" name="nextBtn">
						<!--<a href="avascript:goPrev();" class="btnCm btnGrayA btnPdB"><b>이전</b></a>-->
						<a href="javascript:goNext(<%=page%>);" class="btnCm btnOrgF btnPdB"><b>다음</b></a>
						<!--<a href="javascript://" class="btnCm btnOrgF btnPdB"><b>제출</b></a>-->
					</div>
					<div class="btnArea" id="submitBtn" name="submitBtn">
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
