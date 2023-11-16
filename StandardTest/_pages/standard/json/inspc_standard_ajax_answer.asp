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

	Dim param : Set param = New Parameter : param.FillByRequest
	Dim inspChkCd : inspChkCd = NEVL(param.getv("inspChkCd"), "")
	Dim page : page = NEVL(param.getv("page"), "")
	Dim pagesize : pagesize = NEVL(param.getv("pagesize"), "")
	Dim cmd : Set cmd = New ProcedureCommand
	'Dim rgstUser : rgstUser = Request.Cookies.Item("C_MGR_ID")
	Dim rgstUser : rgstUser = NEVL(param.getv("userid"), "")
	Dim childMbrNm : childMbrNm = NEVL(param.getv("childMbrNm"), "")
	Dim childMbrSex : childMbrSex = NEVL(param.getv("childMbrSex"), "")
	Dim childClass : childClass = NEVL(param.getv("childClass"), "")
	Dim childClassNm : childClassNm = NEVL(param.getv("childClassNm"), "")
	Dim childMbrBrtdy : childMbrBrtdy = NEVL(param.getv("childMbrBrtdy"), "")
    Dim childAge      : childAge = NEVL(param.getv("childAge"), "")        

	DB.Open


	For i = (page-1)*pageSize+1 To pageSize*page
		Dim answerVal : answerVal = NEVL(param.getv("radio"&i), "")
		Dim seq : seq = i

	    '결과나오고 나서 프로시저 만들기
		cmd.PrepareCall "usp_tbl_inspc_child_standard_answer_write", "inspChkCd, rgstUser, childMbrNm, childClass ,childClassNm, childMbrSex ,seq ,answerVal ,childMbrBrtdy ,childAge ", null
				cmd.setV "inspChkCd", inspChkCd
				cmd.setV "rgstUser", rgstUser
				cmd.setV "childMbrNm", childMbrNm
				cmd.setV "childClass", childClass
				cmd.setV "childClassNm", childClassNm
				cmd.setV "childMbrSex", childMbrSex
				cmd.setV "seq", seq
				cmd.setV "answerVal", answerVal
				cmd.setV "childMbrBrtdy", childMbrBrtdy
                cmd.setV "childAge", childAge
				cmd.execute
				msg = "등록 되었습니다."
	Next
	
	DB.Close



	'SendMessage msg, "/_pages/standard/exam03.asp?page="&page&"&inspChkCd="&inspChkCd&"&childClassNm="&childClassNm
	'SendMessage msg, "/_pages/index/b2b_index.asp"
	'pur_code = "10000000000004"
	'https://www.nekids.co.kr/_pages/standard/exam03.asp?page=2&inspChkCd=C02400030&childClassNm=목화



	
%>
