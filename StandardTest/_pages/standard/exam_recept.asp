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

<!-- #include virtual = "/_pages/inc/layout/first.asp" -->
<!-- #include virtual = "/_pages/inc/layout/auth_check.asp" -->
<!-- #include virtual="/_lib/global/func.asp" -->
<!-- #include virtual="/_lib/dsn/dsn.asp" -->
<!-- #include virtual="/_lib/global/ado.asp" -->
<!-- #include virtual="/inc/domain/bbsfunc.asp" -->
<!-- #include virtual="/inc/domain/globalheader.asp" --><%'DOCTYPE, HTML 포함%>
<script type="text/javascript" src="/inc/js/validate.js?_v=10119"></script>
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
	L_MENU = "0"
	M_MENU = "1"
	S_MENU = "1"

	'검사코드 유효 정보
	cc_nm			= ckstr(r("cc_nm"),1)
	inspChkCd		= ckstr(r("inspChkCd"),1)
	inspStrtYmd		= ckstr(r("inspStrtYmd"),1)
	inspEndYmd		= ckstr(r("inspEndYmd"),1)
	childMbrNm		= ckstr(r("childMbrNm"),1)
	classNm			= ckstr(r("classNm"),1)
    
    If Left(inspChkCd,3) = "C06" then
        childAge    = mid(inspChkCd, 4, 1)

    Else 
        childAge    = 0
    End If

	schParams		= "&cc_nm=" & cc_nm & "&inspChkCd=" & inspChkCd & "&inspStrtYmd=" & inspStrtYmd & "&inspEndYmd=" & inspEndYmd & "&childMbrNm=" & childMbrNm & "&classNm=" & classNm
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
Dim yy, mm, dd
Dim info : Set info	= New Parameter	

'신청항목 유치원 교실이름 리스트
query = "usp_tblaplClassMng_view @inspChkCd = '" & inspChkCd & "'"
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then 
		response.write "<script language='javascript'>"
		response.write "alert('코드가 존재하지 않습니다. 관리자에게 문의하세요.');"
		response.write "</script>"
		
		go("./exam01.asp")
	Else
		rsclassnmGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing
	
'로그인 유저(학부모) 정보 가져오기
query = "[usp_set_tblmbr_view]	@mbrId	= '" & userid & "'"  & ""
'w query
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then
		rsGet = ""
	Else
		rsGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing

	If IsArray(rsGet) Then
			rs_mbr_id		= rsGet(0,0)
			rs_mbr_nm		= rsGet(3,0)
			rs_mi_email		= rsGet(11,0)
			rs_mi_tel		= rsGet(12,0)		
			rs_mi_cph		= rsGet(13,0)
			rs_bc_nm		= rsGet(20,0) 
			rs_bc_cd		= rsGet(19,0) 
			rs_pl_cd		= rsGet(21,0) '기관코드
			rs_pl_nm		= rsGet(22,0) '기관명			
	End If
	If rs_mi_tel <> "" Then
				Dim tel1 : tel1 = Split(fnc_passDecrypt(rs_mi_tel), "-")(0)
				Dim tel2 : tel2 = Split(fnc_passDecrypt(rs_mi_tel), "-")(1)
				Dim tel3 : tel3 = Split(fnc_passDecrypt(rs_mi_tel), "-")(2)
			End If
	If rs_mi_cph <> "" Then
				Dim cph1 : cph1 = Split(rs_mi_cph, "-")(0)
				Dim cph2 : cph2 = Split(rs_mi_cph, "-")(1)
				Dim cph3 : cph3 = Split(rs_mi_cph, "-")(2)
	End If

'원생자녀 정보
query = "usp_set_tbchldr_list @pmId = '" & rs_mbr_id & "', "&_
										  " @trGBn	= 'S'" 
'w query
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then 
		rsStdntGet = ""
	Else
		rsStdntGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing
	If IsArray(rsStdntGet) Then

		For i = 0 To UBound(rsStdntGet, 2)
			rs_pmId				= rsStdntGet(1,i)
			rs_childMbrNm		= rsStdntGet(2,i)
			rs_childMbrBrtdy	= fnc_passDecrypt(rsStdntGet(3,i))
			rs_childMbrSex		= rsStdntGet(4,i)			
		Next
	End If

'자녀형제 정보
query = "usp_set_tbchldr_list @pmId = '" & rs_mbr_id & "', "&_
											  " @trGBn	= 'B'" 
Set rs = getrecordset(query, dsn_nekids)
If rs.eof Or rs.bof Then 
	rsStdntBroGet = ""
Else
	rsStdntBroGet = rs.getrows()
End If
rs.close
Set rs = Nothing

'기관 정보
If Left(inspChkCd,3) = "C06" THEN
    plCd = MID(inspChkCd, 5, 5)
Else 
    plCd = MID(inspChkCd, 4, 5)
End IF

query = "usp_set_tblprschlcd_get @plseq = 'k"&  plCd &"'" 
Set rs = getrecordset(query, dsn_nekids)
If rs.eof Or rs.bof Then 
	rsplcdGet = ""
Else
	rsplcdGet = rs.getrows()
End If
rs.close
Set rs = Nothing

If IsArray(rsplcdGet) Then

		For i = 0 To UBound(rsplcdGet, 2)
			rs_plcd				= rsplcdGet(0,i)
	Next
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

	$("#cph1").val("<%=cph1%>");
	$("#cph2").val("<%=cph2%>");
	$("#cph3").val("<%=cph3%>");
	$("#tel1").val("<%=tel1%>");
	$("#tel2").val("<%=tel2%>");
	$("#tel3").val("<%=tel3%>");
	$("#childClass").val("<%=rs_plcd%>");
	});

function goPopup() {
	var f = document.frm;
	if (validate(f)) {
		var childClassNm	= $("select[name='childClassNm']").val();
		var childMbrNm		= $("input[name='childMbrNm']").val();
		var childMbrSex		= $("input[name='childBrotherMbrSex1']:checked").val();
		var childBrtdyYear	= $("select[name='childBrotherMbrBrtdyYear']").val();
		var childBrtdyMonth = $("select[name='childBrotherMbrBrtdyMonth']").val();
		var childBrtdyDate	= $("select[name='childBrotherMbrBrtdyDate']").val();
		var neswwin = window.open('../popup/popStd02.asp?cc_nm=<%=cc_nm%>&childClass='+"<%=rs_plcd%>"+'&childClassNm='+childClassNm+'&childMbrNm='+childMbrNm+'&childMbrSex='+childMbrSex+'&childBrtdy='+childBrtdyYear+'-'+childBrtdyMonth+'-'+childBrtdyDate, 'popPlay', 'width=660,height=600,top=0,left=0');
	}
	
}

function goInfoPopup() {
	//아이이름, 아이성별, 아이생년월일, 기관
	if("<%=rs_childMbrNm%>" == "" || "<%=rs_childMbrNm%>" == null) {
		alert("등록된 아이 이름이 없습니다. 등록해주세요");
	}else {
		window.open('../popup/popStd01.asp', 'popPlay', 'width=660,height=700,top=0,left=0,scrollbars=1');
   
	}

}

function goWrite() {
	var f = document.frm;
	f.submit();
}

//자녀 정보 불러오기
function addChild(val) {
    
	$.ajax({
		type : "POST", 
		url : "/_pages/standard/json/childClass_list_select_proc.asp",
		data : { "row_number": val},
		dataType : "json",
		success : function(data) {
            $("input[name='childMbrNm']").val(data.name);
            if(data.sex == "M") {
		        $("input:radio[name='childBrotherMbrSex1']:radio[value='M']").prop('checked', true); // 선택하기

		        $("input:radio[name='childBrotherMbrSex1']:radio[value='F']").prop('checked', false); // 해제하기
	        }else {
		        $("input:radio[name='childBrotherMbrSex1']:radio[value='F']").prop('checked', true); // 선택하기

		        $("input:radio[name='childBrotherMbrSex1']:radio[value='M']").prop('checked', false); // 해제하기
	        }
            
            var rs_BrtdyArray = data.birth.split("-");

	        $("select[name='childBrotherMbrBrtdyYear']").val(rs_BrtdyArray[0]);
	        $("select[name='childBrotherMbrBrtdyMonth']").val(rs_BrtdyArray[1]);
	        $("select[name='childBrotherMbrBrtdyDate']").val(rs_BrtdyArray[2]);
	    
	    },
		fail : function() {
		    alert("서버오류가 발생했습니다. 관리자에게 문의해주세요.");
            
		}
    });

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
			<form id="frm" name="frm"  method="post" action="./inspcProc1.asp">
				<input type="hidden" name="action" value="info" />
				<input type="hidden" name="inspTp" value="<%=Left(inspChkCd,3)%>"/>
				<input type="hidden" name="inspChkCd" value="<%=inspChkCd%>"/>
				<input type="hidden" name="inspStrtYmd" value="<%=inspStrtYmd%>"/>
				<input type="hidden" name="inspEndYmd" value="<%=inspEndYmd%>"/>
				<input type="hidden" name="rs_bc_cd" value="<%=rs_bc_cd%>"/>
				<input type="hidden" name="rs_pl_cd" value="<%=rs_pl_cd%>"/>
				<input type="hidden" name="childMbrBrtdy" value="<%=rs_childMbrBrtdy%>"/>
                <input type="hidden" name="childClass" id="childClass" hname="기관명"/>
                <input type="hidden" name="childAge" value="<%=childAge%>"/>
                
				<div class="standardArea">
					<div class="cont cont03">
						<div class="exam02">
								<h4>학부모 정보</h4>
								<div class="formFirst">
									<table class="form formOrg">
										<caption>학부모 이름, 학부모 연락처</caption>
										<colgroup><col width="15%"><col width=""><col width="15%"><col width=""></colgroup>
										<tbody>
											<tr>
												<th scope="row">학부모 이름</th>
												<td colspan="3"><input type="text" class="txt" name="parents_nm" id="parents_nm" value ="<%=rs_mbr_nm%>" hname="학부모 이름" required="required"/></td>
											</tr>
											<tr>
												<th scope="row">학부모 연락처 <b class="fontTypeB">*</b></th>
												<td colspan="3">
													<p class="numType">
														<label for="phone">전화번호</label>
														<span class="slt">
															<select name="tel1" id="tel1" class="" style="width:85px;">
																<option value="">선택</option>
																<option value="02">02</option>
																<option value="031">031</option>
																<option value="032">032</option>
																<option value="033">033</option>
																<option value="041">041</option>
																<option value="042">042</option>
																<option value="043">043</option>
																<option value="051">051</option>
																<option value="052">052</option>
																<option value="053">053</option>
																<option value="054">054</option>
																<option value="055">055</option>
																<option value="061">061</option>
																<option value="062">062</option>
																<option value="063">063</option>
																<option value="064">064</option>
																<option value="070">070</option>
															</select>
														</span> &nbsp;-
														<input type="text" class="txt" name="tel2" id="tel2" maxlength="4" style="width:77px;"> -
														<input type="text" class="txt" name="tel3" id="tel3" maxlength="4" style="width:77px;">
													</p>
													<p class="numType">
														<label for="cph1">휴대전화 번호</label>
														<span class="slt">
															<select name="cph1" id="cph1" class="" style="width:85px;">
																<option value="">선택</option>
																<option value="010">010</option>
																<option value="011">011</option>
																<option value="016">016</option>
																<option value="017">017</option>
																<option value="018">018</option>
																<option value="019">019</option>
															</select>
														</span> &nbsp;-
														<input type="text" class="txt" name="cph2" id="cph2" maxlength="4" value="" style="width:77px;"  hname="학부모 연락처" required="required"> -
														<input type="text" class="txt" name="cph3" id="cph3" maxlength="4" value="" style="width:77px;"  hname="학부모 연락처" required="required"> &nbsp;
														<span>* 연락처 중 1개는 필수 입력해 주세요.</span>
													</p>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								<!--goInfoPopup-->
								<h4>자녀 정보<p class="txtInfo">(회원가입 시 입력한 자녀 정보를 불러 오려면, “자녀 정보 불러오기”버튼을 클릭 해주세요.) <a href="javascript:goInfoPopup();" class="btnCm btnYlw"><b>자녀 정보 불러오기</b></a></p></h4>
								<div class="formBox">
									<table class="form formOrg">
										<caption>아이 이름, 아이 성별, 아이 생년월일, 반 이름</caption>
										<colgroup><col width="15%"><col width=""></colgroup>
										<tbody>
											<tr>
												<th scope="row">아이 이름 <b class="fontTypeB">*</b></th>
												<td><input type="text" name="childMbrNm" id="childMbrNm" hname="아이 이름" required="required" class="txt"/></td>	
											</tr>
											<tr>
												<th scope="row" >아이 성별 <b class="fontTypeB">*</b></th>
												<td>
													<span class="pdR"><label><input type="radio" name="childBrotherMbrSex1" value="M"> 남자</label></span>
													<span><label><input type="radio" name="childBrotherMbrSex1" value="F"> 여자</label></span>
												</td>
											</tr>
											<tr>
												<th scope="row">아이 생년월일 <b class="fontTypeB">*</b></th>
												<td>
													<span class="slt">
														<select name="childBrotherMbrBrtdyYear" style="width:85px;">
															<option value="">년</option>
															<%	For yy = DatePart("yyyy", Now) To DatePart("yyyy", Now) - 10 Step -1%>
															<option value="<%=yy%>"><%=yy%></option>
															<%	Next	%>										
														</select>
													</span> &nbsp;&nbsp;
													<span class="slt">
														<select name="childBrotherMbrBrtdyMonth" style="width:85px;">
															<option value="">월</option>
															<%	
															For mm = 1 To 12
															if 10 > mm then mm = "0"&mm 
															%>
															<option value="<%=mm%>"><%=mm%>월</option>
															<%	Next	%>
														</select>
													</span> &nbsp;&nbsp;
													<span class="slt">
														<select name="childBrotherMbrBrtdyDate" style="width:85px;">
															<option value="">일</option>
															<%	
															For dd = 1 To 31
															if 10 > dd then dd = "0"&dd 
															%>
															<option value="<%=dd%>"><%=dd%>일</option>
															<%	Next	%>
														</select>	
													</span>
												</td>
											</tr>
												
											<tr>
												<th scope="row" class="last">반이름 <b class="fontTypeB">*</b></th>
												<td class="last">
													<span class="slt">
													<select class="childClassNm" name="childClassNm" value="<%=classNm%>" hname="반이름" required="required" style="width:120px;"">
													<option value="">선택하세요.</option>
													<%
													classCnt = 21
													If IsArray(rsclassnmGet) Then
														For i = 2 To classCnt
															
															If rsclassnmGet(i,0) <> "" Then
																
																classNm = rsclassnmGet(i,0)
													%>
													<option value="<%=classNm%>"><%=classNm%></option>
													<%
															End If
														Next
													End If
													%>
													</select>
													</span>
												</td>
											</tr>
										</tbody>
									</table>
								</div>

							<div class="btnArea">
								<a href="/_pages/index/b2b_index.asp" class="btnCm btnGrayA btnPdA"><b>취소</b></a>
								<a href="javascript:goPopup();" class="btnCm btnOrgB btnPdB"><b>확인</b></a>
							</div>

							<input type="hidden" name="schParams" value="<%=schParams%>">
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