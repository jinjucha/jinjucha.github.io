
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
                  
    questionSeq				= ckstr(r("questionSeq"),1)
    childAge                = ckstr(r("childAge"),1)
    childMbrSex             = request("childMbrSex")
    ARRAY_POINT_VALUE       = request("ARRAY_POINT_VALUE")
    arrayPoint              = request("arrayPoint")
    pageSize                = request("pageSize")
    standardType            = Unescape(request("standardType"))


    query = "[usp_cjj_tbl_inspc_standard_question_list]	@page		= " & questionSeq & ", " &_
                            "@pageSize		= '" & pageSize & "'," &_
                            "@childAge		= '" & childAge & "'," &_
                            "@childMbrSex   = '" & childMbrSex & "'," &_
							"@standard_type	= '" & standardType & "'"

    Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then
		answerArray = ""
	Else
		answerArray = rs.getrows
	End If
	rs.close
	Set rs = Nothing

%>

[
<%
	If IsArray(answerArray) Then
		For i = 0 To UBound(answerArray, 2)
%>
	{
		
        "QUESTION"              : "<%=answerArray(4, i)%>",
        "IMAGE_FILE"            : "<%=answerArray(5, i)%>",
        "ANSWER"                : "<%=answerArray(6, i)%>",
        "QUESTION_NUMBER"       : "<%=answerArray(7, i)%>",
        "questionSeq"           : "<%=questionSeq%>",
        "ARRAY_POINT_VALUE"     : "<%=ARRAY_POINT_VALUE%>",
        "arrayPoint"            : "<%=arrayPoint%>",
        "STANDARD_TYPE"         : "<%=answerArray(3, i)%>"
        
	}
     
<%
            If i = UBound(answerArray, 2) Then
            else
                Response.write ","
            End if

		Next
	End If


%>
]
