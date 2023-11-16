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

<%
    mll_useragent   = ua

    query = "[usp_tblkidsstandardlog]	@inspChkCd		= '" & ckstr(rf("inspChkCd"),1) & "', " &_
							"@inspUserId		= '" & ckstr(rf("userid"),1) & "'," &_
                            "@classNm		= '" & ckstr(rf("childClass"),1) & "'," &_
                            "@childClassNm		= '" & ckstr(rf("childClassNm"),1) & "'," &_
                            "@formlog		= '" & request.Form & "'," &_
                            "@cookieslog		= '" & request.Cookies & "'," &_
							"@useragentlog		= '" & ua & "'"
    
    Set rs = getrecordset(query, dsn_nekids)

	Dim param : Set param = New Parameter : param.FillByRequest
	Dim inspChkCd : inspChkCd = NEVL(param.getv("inspChkCd"), "")
	Dim page : page = NEVL(CInt(param.getv("page")), "")
	Dim pagesize : pagesize = NEVL(CInt(param.getv("pagesize")), "")
	Dim cmd : Set cmd = New ProcedureCommand
	Dim rgstUser : rgstUser = NEVL(param.getv("userid"), "")
	Dim childMbrNm : childMbrNm = NEVL(param.getv("childMbrNm"), "")
	Dim childMbrSex : childMbrSex = NEVL(param.getv("childMbrSex"), "")
	Dim childClass : childClass = NEVL(param.getv("childClass"), "")
	Dim childClassNm : childClassNm = NEVL(param.getv("childClassNm"), "")
	Dim childMbrBrtdy : childMbrBrtdy = NEVL(param.getv("childMbrBrtdy"), "")
    Dim count : count = "0"
    Dim startPage : startPage = (page-1)*pageSize+1
	Dim endPage : endPage =  pageSize*page
    Dim lastPage : lastPage = NEVL(CInt(param.getv("lastPage")), "")
    Dim question_num : question_num = "89"
    

    '마지막 페이지 경우 9문항만 저장 
    If page = lastPage Then
        endPage = question_num
    End if

	DB.Open

        For i = startPage To endPage
            Dim answerVal : answerVal = NEVL(param.getv("radio"&i), "")
            Dim seq : seq = i

            count = count + 1

            cmd.PrepareCall "usp_tbl_inspc_child_C01_answer_write", "inspChkCd, rgstUser, childMbrNm, childClass ,childClassNm, childMbrSex ,seq ,answerVal ,childMbrBrtdy", null

                    cmd.setV "inspChkCd", inspChkCd
                    cmd.setV "rgstUser", rgstUser
                    cmd.setV "childMbrNm", childMbrNm
                    cmd.setV "childClass", childClass
                    cmd.setV "childClassNm", childClassNm
                    cmd.setV "childMbrSex", childMbrSex
                    cmd.setV "seq", seq
                    cmd.setV "answerVal", answerVal
                    cmd.setV "childMbrBrtdy", childMbrBrtdy
                    cmd.execute
                    msg = "등록 되었습니다."
	    Next

	DB.Close


%>
{"count":"<%=count%>"}
