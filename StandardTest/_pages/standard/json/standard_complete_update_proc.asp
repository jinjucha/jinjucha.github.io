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
<!-- #include virtual = "/_lib/global/func.asp" -->
<!-- #include virtual = "/_lib/dsn/dsn.asp" -->
<!-- #include virtual = "/_lib/global/ado.asp" -->
<!-- #include virtual = "/inc/domain/bbsfunc.asp" -->
<!-- #include virtual = "/inc/domain/globalheader.asp" --><%'DOCTYPE, HTML 포함%>
<%  

    inspChkCd       = request("inspChkCd")
    childClassNm    = request("childClassNm")
    childMbrNm      = request("childMbrNm")
    childMbrSex     = request("childMbrSex")
    childClass      = request("childClass")
    childAge        = request("childAge")
    standard_type   = request("standard_type")

    mll_useragent   = ua

    '데이터 로그 추가
    query = "[usp_cjj_tblkidsstandardlog]	@inspChkCd		= '" & inspChkCd & "', " &_
							"@inspUserId    = '" & "test" & "'," &_
                            "@classNm		= '" & childClass & "'," &_
                            "@childClassNm	= '" & childClassNm & "'," &_
                            "@formlog		= '" & request.Form & "'," &_
                            "@cookieslog	= '" & request.Cookies & "'," &_
							"@useragentlog	= '" & ua & "'"
    
    Set rs = getrecordset(query, dsn_nekids)

    Dim param : Set param = New Parameter : param.FillByRequest
    Dim userid : userid = C_MBR_ID


    For i = 1 To request("TEST_QUESTION_SEQ")
		RIGHT_ANSWER_MEMBER_1	= request("RIGHT_ANSWER_MEMBER_1")(i)

	    query = "exec usp_cjj_tbl_inspc_child_standard_answer_write '" & inspChkCd & "','" & userid & "','" & childMbrNm & "','" & childClass & "','" & childClassNm & "','" & childMbrSex & "','" & standard_type & "','" & i & "','" & RIGHT_ANSWER_MEMBER_1 & "', '" & FormatDateTime(Now(), 2)  & "', '" &  childAge & "'"
        
        Set rs = getrecordset(query, dsn_nekids)
   
	Next

%>
