
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

    Dim param : Set param = New Parameter : param.FillByRequest
    Dim userid : userid = C_MBR_ID

    query = "usp_set_tbchldr_class_list @pmId = '" & userid & "', "&_
                            "@trGBn		= 'S'," &_
	                        "@rowNum	= '" & request("row_number") & "'" 

    Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then
		rsGet = ""
	Else
		rsGet = rs.getrows
	End If
	rs.close
	Set rs = Nothing
%>


<%
	If IsArray(rsGet) Then
	
%>

        {"id" :"<%=rsGet(1, 0)%>",  "name" : "<%=rsGet(2, 0)%>", "birth" : "<%=fnc_passDecrypt(rsGet(3, 0))%>", "sex" : "<%=rsGet(4, 0)%>"}

<%
	End If

%>



