<!-- #include virtual="/_lib/global/unicode.asp" -->

<!-- #include virtual="/_lib/global/func.asp" -->
<!-- #include virtual="/_lib/dsn/dsn.asp" -->
<!-- #include virtual="/_lib/global/ado.asp" -->
<!-- #include virtual = "/_pages/inc/layout/head.asp" -->
<!-- #include virtual="/inc/domain/bbsfunc.asp" -->
<!-- #include virtual="/inc/domain/globalheader.asp" --><%'DOCTYPE, HTML 포함%>

<!-- #include virtual = "/_pages/inc/layout/first.asp" -->


<%
action			= ckstr(rf("action"),1)
inspcd			= ckstr(rf("inspcd"),1)
inspChkCd		= ckstr(rf("inspChkCd"),1)
page			= d_int(ckstr(rf("page"),1), 1)
pageSize		= 10
pagetemp		= CStr(1)
pgSeq			= d_int(ckstr(rf("pgSeq"),1), 1)
rs_bc_cd		= ckstr(rf("rs_bc_cd"),1)
childClass		= ckstr(rf("childClass"),1)
rs_pl_cd		= ckstr(rf("rs_pl_cd"),1)
inspTp			= ckstr(rf("inspTp"),1)
classNm			= ckstr(rf("classNm"),1)
childClassNm	= ckstr(rf("childClassNm"),1)
inspStrtYmd		= ckstr(rf("inspStrtYmd"),1)
inspEndYmd		= ckstr(rf("inspEndYmd"),1)
childMbrNm		= ckstr(rf("childMbrNm"),1)
childMbrSex		= ckstr(rf("childBrotherMbrSex1"),1)
getAccountName  = Request.Cookies.Item("C_MBR_ID")
rgstYmd			= Now()
inspEndYmd		= ckstr(rf("inspEndYmd"),1)
complYmd		= Now()
childAge        = ckstr(rf("childAge"),1)

Dim param : Set param = New Parameter : param.FillByRequest
Dim userid : userid = C_MBR_ID
Dim miTel,childMbrBrtdy
Dim nextpage

If param.getv("cph1") <> "" And param.getv("cph2") <> "" And param.getv("cph3") <> "" Then
	miTel = param.getv("cph1") & "-" & param.getv("cph2") & "-" & param.getv("cph3")
End If

childMbrBrtdy  =  param.getv("childBrotherMbrBrtdyYear") & "-" & param.getv("childBrotherMbrBrtdyMonth") & "-" & param.getv("childBrotherMbrBrtdyDate")
mll_ip          = Request.ServerVariables("REMOTE_ADDR")
mll_useragent   = ua
mll_mobile      = fnc_isMobile

If action = "sel" Then
	'검사 완료한 사용자 목록
	query = "[usp_tblfr_aplComplMng_list]	@inspChkCd		= '" & inspChkCd & "'," &_
										   "@inspUserId		= '" & userid & "'"
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then
		rscmplYnGet = ""
	Else
		rscmplYnGet = rs.getrows()
		'제출 완료된 사용자 
		If rscmplYnGet(18, 0) = "Y" then
			response.write "<script language='javascript'>"
			response.write "alert('이미 제출 완료된 검사입니다.');"
			response.write "</script>"
			go("./index.asp")
		'제출 하지 않은 사용자
		Else 
		End if

	End If
	rs.close
	Set rs = Nothing

	'검사 신청 관리 목록
	query = "[usp_tblaplMng_list]	@inspChkCd	= '" & inspChkCd & "'"
    
	Set rs = getrecordset(query, dsn_nekids)

	If rs.eof Or rs.bof Then
		rsGet = ""
		
        w query

        response.write "<script language='javascript'>"
		response.write "alert('코드가 존재하지 않습니다. 관리자에게 문의하세요');"
		response.write "</script>"
		
		go("./exam01.asp")
	Else
		rsGet = rs.getrows()
		cc_nm				= rsGet(5,0)
		nmbApl				= rsGet(6,0)
		inspStrtYmd			= rsGet(8,0)
		inspEndYmd			= rsGet(9,0)
		inspChkCdYn			= rsGet(13,0)
		cmplCnt				= rsGet(15,0)
        inspTp				= rsGet(16,0)
        childAge            = rsGet(17,0)
		
		If inspStrtYmd <= FormatDateTime(Now(), 2) And inspEndYmd >= FormatDateTime(Now(), 2) And inspChkCdYn = "Y" And nmbApl > cmplCnt Then 
            response.write "<script language='javascript'>"
			response.write "alert('신청페이지로 이동합니다');"
			response.write "</script>"
            go("./exam02.asp?cc_nm="&cc_nm &"&inspChkCd="& inspChkCd&"&inspStrtYmd="&inspStrtYmd&"&inspEndYmd="&inspEndYmd&"&childAge="&childAge)
		ElseIf inspChkCdYn = "N" Then 
			response.write "<script language='javascript'>"
			response.write "alert('검사 시작 전 입니다. 관리자에게 문의하세요.');"
			response.write "</script>"
			go("./exam01.asp")
		Else
			response.write "<script language='javascript'>"
			response.write "alert('검사코드가 만료되어 검사를 진행할 수 없습니다. 관리자에게 문의하세요.');"
			response.write "</script>"
			go("./exam01.asp")
		End if

	End If
	rs.close
	Set rs = Nothing

' exam02.asp 검사 시작 전 정보 전달 단계
ElseIf action = "info" Then
		'childClass 임시유치원
		query = "usp_tblaplComplMng_write	@bcCd	= '" & rs_bc_cd & "', " &_
									"	@plCd			= '" & rs_pl_cd & "'," &_
									"	@inspChkCd		= '" & inspChkCd & "'," &_
									"	@inspTp			= '" & inspTp & "'," &_
									"	@classNm		= '" & childClass & "'," &_
									"	@childClassNm	= '" & childClassNm & "'," &_
									"	@inspStrtYmd	= '" & inspStrtYmd & "'," &_
									"	@inspEndYmd		= '" & inspEndYmd & "'," &_
									"	@childMbrNm		= '" & childMbrNm & "'," &_
									"	@childMbrSex	= '" & childMbrSex & "'," &_
									"	@childMbrBrtdy	= '" & childMbrBrtdy & "'," &_
									"	@rgstYmd		= '" & rgstYmd & "'," &_
									"	@rgstUser		= '" & getAccountName & "'," &_
									"	@complYmd		= '" & complYmd & "'," &_
									"	@userTelNum		= '" & fnc_passEncrypt(miTel) & "'," &_
                                    "	@mll_ip		    = '" & mll_ip & "'," &_
                                    "	@mll_mobile		= '" & mll_mobile & "'," &_
									"	@mll_useragent	= '" & mll_useragent & "'"
 
	Set rs = getrecordset(query, dsn_nekids)

	query = "[usp_tblaplMng_list] @inspChkCd	= '" & inspChkCd & "'"
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then 
		rspageGet = ""
	Else
		rspageGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing

	If IsArray(rspageGet) Then

		rsInspTp = RIGHT(rspageGet(16,0), 2)
	Else
		response.write "<script language='javascript'>"
		response.write "alert('검사 코드가 유효하지 않습니다. 자세한 사항은 기관에 문의 부탁드립니다');"
		response.write "</script>"
	End If	
		response.write "<script language='javascript'>"
		response.write "alert('검사페이지로 넘어갑니다~!');"
		response.write "</script>"

        If rsInspTp <> "06" THEN
            go("./exam03_" &  rsInspTp & ".asp?inspChkCd="& inspChkCd & "&childClassNm=" & childClassNm & "&childMbrBrtdy=" & childMbrBrtdy & "&childMbrNm=" & childMbrNm & "&childAge=" & childAge & "&childMbrSex=" & childMbrSex & "&childClass=" & childClass)
        Else 
            nextpage = "popup"
        End IF
ElseIf action = "ins" Then

	'제출버튼 클릭 시 검사관리 완료 카운트 증가	
	query = "usp_tblaplMng_cnt @inspChkCd = '"& inspChkCd  & "', " &_
								"	@rgstUser		= '" & userid & "'"	
	
    Set rs = getrecordset(query, dsn_nekids)

    response.write "<script language='javascript'>"
	response.write "window.open('about:blank','_self').close();"
	response.write "</script>"

End if
%>

<script>
   
    //document.location.href = "./index.asp";
    if("<%=nextpage%>" == "popup") {
        //var new_popup = window.open("https://www.nekids.co.kr/_pages/standard/exam03_06.asp?inspChkCd=<%=inspChkCd%>&childClassNm=<%=childClassNm%>&childMbrBrtdy=<%=childMbrBrtdy%>&childMbrNm=<%=childMbrNm%>&childAge=<%=childAge%>&childMbrSex=<%=childMbrSex%>&childClass=<%=childClass%>", "goPop", "width=1000, height=1000, toolbar=no, menubar=no, scrollbars=yes, resizable=yes" );
        //document.location.href = "./index.asp";


        var new_popup = window.open('','goPop');
        new_popup.location.href='https://www.nekids.co.kr/_pages/standard/exam03_06.asp?inspChkCd=<%=inspChkCd%>&childClassNm=<%=childClassNm%>&childMbrBrtdy=<%=childMbrBrtdy%>&childMbrNm=<%=childMbrNm%>&childAge=<%=childAge%>&childMbrSex=<%=childMbrSex%>&childClass=<%=childClass%>';
        document.location.href = "./index.asp";
    }
    
    
</script>
