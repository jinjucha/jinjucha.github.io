<%
'SqlInjection 관련 체크 함수@41
Function checkSQLInjection(pStr)
	Dim oRegExp, oMatch
	Dim item
	Dim sPattern
	Dim sqlDataType
	sqlDataType = "(bigint|int|smallint|tinyint|bit|numeric|decimal|float|real|date|datetime|datetimeoffset|smalldatetime|char|varchar|nchar|nvarchar|text|ntext|binary|varbinary|image|money|smallmoney|table|sql_variant|cursor|uniqueidentifier|timestamp|geography|geometry|hierarchyid|xml|information_schema)"

	checkSQLInjection = 0

	Set oRegExp = New RegExp
    oRegExp.Global = True                 '** 문자열 전체를 검색함
    oRegExp.IgnoreCase = True             '** 대.소문자 구분 안함

	item = pStr

	REM--  ;(세미콜론)'(싱글쿼테이션)(스페이스바)(개행문자)(탭)이 1개 이상 있고
	sPattern = "([;'\s/]+|^)"
	'DELETE TABLE명은 현실적으로 막을 수가 없음

	'DELETE FROM / DELETE A FROM table AS A
	oRegExp.Pattern = sPattern & "delete([\s]+|\[+)([a-zA-Z0-9])*\]?([\s])*from([\s])*\[?([a-zA-Z0-9])+\]?"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 1
		Exit Function
	End If

	'DELETE tblXXX 일반적으로 사용하는 tblXXX 에 대해서
	oRegExp.Pattern = sPattern & "delete([\s]+|\[+)tbl([a-zA-Z0-9])*\]?"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 2
		Exit Function
	End If

	'UPDATE table SET x =
	oRegExp.Pattern = sPattern & "update([\s]+|\[+)([a-zA-Z0-9])+([\s]+|\]+)set([\s]+|\[+)([a-zA-Z0-9]+)[\s]*="
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 3
		Exit Function
	End If

	'drop proc, drop procedure, drop table
	oRegExp.Pattern = sPattern & "drop([\s]+)(database|proc|procdure|table)([\s]+|\[+)([a-zA-Z0-9])+"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 4
		Exit Function
	End If

	'select x from x
	If Replace(request.servervariables("HTTP_HOST"),"'","''") <> "manager.netimes.co.kr" Then
		oRegExp.Pattern = sPattern & "([\s]*)select(.*)from(.*)"
		Set oMatch = oRegExp.Execute(item)
		If oMatch.Count > 0 Then
			checkSQLInjection = 5
			Exit Function
		End If
	End If

	'declare @temp varchar(10)
	oRegExp.Pattern = sPattern & "declare([\s]+)(\@|\#)+([\@\#\$a-zA-Z0-9]+)([\s]+)" & sqlDataType & ""
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 6
		Exit Function
	End If

	'EXECUTE, EXEC, sp_executeSql, sp_execute
	oRegExp.Pattern = sPattern & "(EXECUTE|EXEC|sp_executeSql|sp_execute)([\s]*)(\(|'|\[|sp_.+|xp_.+|@.+)"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 7
		Exit Function
	End If

	'convert(VARCHAR(20), 12)
	oRegExp.Pattern = sPattern & "convert([\s]*)\(([\s]*)" & sqlDataType & "([^,])*,.+\)"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 8
		Exit Function
	End If

	'cast(0x444 as VARCHAR
	oRegExp.Pattern = sPattern & "cast([\s]*)\((.*)([\s]+)as([\s]+)" & sqlDataType & ""
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 9
		Exit Function
	End If

	'xp_cmdshell
	oRegExp.Pattern = sPattern & "xp_cmdshell"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 10
		Exit Function
	End If

	'ascii(db_name())
	If InStr(LCase(item), "ascii") > 0 And InStr(LCase(item), "db_name") > 0 Then
		checkSQLInjection = 11
		Exit Function
	End If

	'/script>
	oRegExp.Pattern = "/script([\s]*)>"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 12
		Exit Function
	End If

	'onerror=
	oRegExp.Pattern = "onerror([\s]*)="
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 13
		Exit Function
	End If


	'style @import
	oRegExp.Pattern = "([\s]*)style([\s]*)@import"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 14
		Exit Function
	End If


	oRegExp.Pattern = "alert([\s]*)\("
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 15
		Exit Function
	End If

	oRegExp.Pattern = "alert([\s]*)%28"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 16
		Exit Function
	End If
	
	If	Replace(request.servervariables("HTTP_HOST"),"'","''") <> "manager.netimes.co.kr" And _
		Replace(request.servervariables("HTTP_HOST"),"'","''") <> "nevil.neungyule.com" And _
		Replace(request.servervariables("HTTP_HOST"),"'","''") <> "ncsm.neungyule.com" And _
		Replace(request.servervariables("HTTP_HOST"),"'","''") <> "mng.neteacher.co.kr" And _
		Replace(request.servervariables("HTTP_HOST"),"'","''") <> "iadmin.neungyule.com" And _
		InStr(Replace(request.servervariables("HTTP_HOST"),"'","''") & Replace(request.servervariables("HTTP_URL"),"'","''"), "www.nebooks.co.kr/neadmin") < 0  Then
		
		oRegExp.Pattern = "<([\s]*)iframe"
		Set oMatch = oRegExp.Execute(item)
		If oMatch.Count > 0 Then
			checkSQLInjection = 18
			Exit Function
		End If

	End if

	oRegExp.Pattern = "onmouseover([\s]*)="
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 19
		Exit Function
	End If

	oRegExp.Pattern = "onmouseout([\s]*)="
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 20
		Exit Function
	End If

	oRegExp.Pattern = "alert([\s]*)\(([\s]*)&"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 21
		Exit Function
	End If

	oRegExp.Pattern = "onfocus([\s]*)="
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 22
		Exit Function
	End If

	'임시로 통과 되도록 처리 (2019.10.30)
	if 0 = 1 then
		oRegExp.Pattern = "<a([\s]*)href([\s]*)="
		Set oMatch = oRegExp.Execute(item)
		If oMatch.Count > 0 Then
			checkSQLInjection = 23
			Exit Function
		End If
	end if

	oRegExp.Pattern = "eval([\s]*)\("
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 24
		Exit Function
	End If

	oRegExp.Pattern = "name_const([\s]*)\(([\s]*)CHAR([\s]*)\("
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 25
		Exit Function
	End If

	oRegExp.Pattern = "unhex([\s]*)\(([\s]*)hex([\s]*)\(([\s]*)version([\s]*)\("
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 26
		Exit Function
	End If

	oRegExp.Pattern = "unescape([\s]*)\("
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 27
		Exit Function
	End If

	oRegExp.Pattern = "meta(.*)http\-equiv"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 28
		Exit Function
	End If

	oRegExp.Pattern = "<([\s]*)object"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 29
		Exit Function
	End If

	oRegExp.Pattern = "<([\s]*)applet"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 30
		Exit Function
	End If

	oRegExp.Pattern = "<([\s]*)form"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 31
		Exit Function
	End If

	'Response.write item & "<br />"
	oRegExp.Pattern = "<([\s]*)script"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 32
		Exit Function
	End If

	oRegExp.Pattern = "<([\s]*)a(.*)([\s]*)javascript"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 33
		Exit Function
	End If

	oRegExp.Pattern = "behavior\:"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 34
		Exit Function
	End If

	oRegExp.Pattern = "1([\s]*)=([\s]*)1([\s]*)limit([\s]*)1"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 35
		Exit Function
	End If

	oRegExp.Pattern = "<([\s]*)svg"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 Then
		checkSQLInjection = 36
		Exit Function
	End If

	oRegExp.Pattern = sPattern & "(WAITFOR|DB_NAME)"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 And Len(item) > 20 Then	'기본적으로 공격은 20자는 넘어야 됨. 나머진 일단 통과 시켜 줌
		checkSQLInjection = 37
		Exit Function
	End If
	
	'21.07.06 이행점검 결과 수정
	If InStr(LCase(item), "onpointermove") > 0 Or InStr(LCase(item), "gotpointercapture") > 0 Or InStr(LCase(item), "lostpointercapture") > 0 Or InStr(LCase(item), "pointerover") > 0 Or InStr(LCase(item), "pointerenter") > 0 Or InStr(LCase(item), "pointerdown") > 0 Or InStr(LCase(item), "pointerup") > 0 Or InStr(LCase(item), "pointercancel") > 0 Or InStr(LCase(item), "pointerout") > 0 Or InStr(LCase(item), "pointerleave") > 0 Then
		checkSQLInjection = 38
		Exit Function
	End If

	'AND 1=1 OR 패턴 차단하기 위함.
	oRegExp.Pattern = "([\s]+|\[+)AND([\s]*)(['a-zA-Z0-9])*\]?([\s])*([\s]*)=([\s]*)(['a-zA-Z0-9])*\]?([\s])*([\s]+|\[+)OR([\s]+|\[+)"
	Set oMatch = oRegExp.Execute(item)
	If oMatch.Count > 0 And Len(item) > 20 Then	'기본적으로 공격은 20자는 넘어야 됨. 나머진 일단 통과 시켜 줌
		checkSQLInjection = 39
		Exit Function
	End If

	'checkSQLInjection = 0
	'--(주석처리)
	'sysdatabases
	' @ EXEC

	Set oRegExp = nothing

End Function


Function checkParametersSQLInjection(pName, pValue)
	Dim lPName : lPName = LCase(pName)
	If (InStr(lPName,"seq") > 0 or InStr(lPName,"page") > 0) And pValue <> "" Then
		If InStr(pValue,"121121121212.1") > 0 then
			checkParametersSQLInjection = 1001
			Exit Function
		end if
	End If
End Function

'개행 체크 추가 (쿠키용)
'2020.02.03 yoonsu
Function checkParameterCrLfValue(pValue)
	checkParameterCrLfValue = (InStr(pValue,chr(13)) > 0 Or InStr(pValue,chr(10)) > 0)
End Function


'Request의 모든 부분을 SqlInjection 체크를 돌림
Function checkRequestInjection()
	Dim LWItem
	Dim ErrParity
	Dim err_param_type
	Dim err_param_name
	Dim err_param_value
	Dim xmlhttp, param
	Dim dsn_Error
	Dim strSQL
	Dim strConnectionString


	On Error Resume Next

	If Err.Number = 0 Then

		'쿠키 검증
		For each LWItem in Request.Cookies

			'인자에 공격 문자가 있나 검사
			ErrParity = checkSQLInjection(LWItem)
			If ErrParity > 0 Then
				err_param_type = "Cookie"
				err_param_name = LWItem
				err_param_value = Request.Cookies(LWItem)
				Exit For
			End If

			'데이터에 공격 문자가 있나 검사
			ErrParity = checkSQLInjection(Request.Cookies(LWItem))
			If ErrParity > 0 Then
				err_param_type = "Cookie"
				err_param_name = LWItem
				err_param_value = Request.Cookies(LWItem)
				Exit For
			End if

			'쿠키 개행 체크 추가 (2020.02.03 yoonsu)
			'Error Parity = 1002
			if checkParameterCrLfValue(Request.Cookies(LWItem)) then
				ErrParity = 1002
				err_param_type = "Cookie"
				err_param_name = LWItem
				err_param_value = Request.Cookies(LWItem)
				Exit For
			end if
		Next

	End if

	On Error GoTo 0

	'get 검증
	If ErrParity = 0 Then

		On Error Resume Next

		If Err.Number = 0 Then

			For each LWItem in Request.QueryString

				'인자에 공격 문자가 있나 검사
				ErrParity = checkSQLInjection(LWItem)
				If ErrParity > 0 Then
					err_param_type = "QueryString"
					err_param_name = LWItem
					err_param_value = Request.QueryString(LWItem)
					Exit For
				End If

				'데이터에 공격 문자가 있나 검사
				ErrParity = checkSQLInjection(Request.QueryString(LWItem))
				If ErrParity > 0 Then
					err_param_type = "QueryString"
					err_param_name = LWItem
					err_param_value = Request.QueryString(LWItem)
					Exit For
				End if

				'파라미터가 특별하게 이상하게 날라오는 경우
				ErrParity = checkParametersSQLInjection(LWItem, Request.QueryString(LWItem))
				If ErrParity > 0 Then
					err_param_type = "QueryString"
					err_param_name = LWItem
					err_param_value = Request.QueryString(LWItem)
					Exit For
				End if
			Next

		End if

		On Error GoTo 0

	End If

	'post 검증
	If ErrParity = 0 Then
		On Error Resume Next

		If Err.Number = 0 Then

			For each LWItem in Request.Form

				'인자에 공격 문자가 있나 검사
				ErrParity = checkSQLInjection(LWItem)
				If ErrParity > 0 Then
					err_param_type = "Form"
					err_param_name = LWItem
					err_param_value = Request.Form(LWItem)
					Exit For
				End If

				'데이터에 공격 문자가 있나 검사
				ErrParity = checkSQLInjection(Request.Form(LWItem))
				If ErrParity > 0 Then
					err_param_type = "Form"
					err_param_name = LWItem
					err_param_value = Request.Form(LWItem)
					Exit For
				End if

				'파라미터가 특별하게 이상하게 날라오는 경우
				ErrParity = checkParametersSQLInjection(LWItem, Request.Form(LWItem))
				If ErrParity > 0 Then
					err_param_type = "Form"
					err_param_name = LWItem
					err_param_value = Request.Form(LWItem)
					Exit For
				End if
			Next

		End if

		On Error GoTo 0

	End If


	if ErrParity >= 1 Then

		strSQL = "exec KY_ErrorLog..usp_ahm_tblSecurityLog_SqlInjection_insert  "
		strSQL = strSQL & "@ERR_CODE='"&ErrParity&"'"
		strSQL = strSQL & ",@ERR_PARAM_TYPE='"&err_param_type&"'"
		strSQL = strSQL & ",@ERR_PARAM_NAME='"&Replace(err_param_name,"'","''")&"'"
		strSQL = strSQL & ",@ERR_PARAM_VALUE='" & Replace(err_param_value,"'","''") & "'"
		strSQL = strSQL & ",@URL='"&Replace(request.servervariables("HTTP_HOST"),"'","''") & Replace(request.servervariables("HTTP_URL"),"'","''")&"'"
		strSQL = strSQL & ",@IP='"&Replace(Request.ServerVariables("REMOTE_ADDR"),"'","''")&"'"
		strSQL = strSQL & ",@USER_AGENT='"&Replace(Request.ServerVariables("HTTP_USER_AGENT"),"'","''")&"'"
		strConnectionString = gv_injection_dsn

		Dim conGeneric : SET conGeneric = Server.CreateObject("ADODB.Connection")
		conGeneric.open strConnectionString
		conGeneric.Execute strSQL, , adExecuteNoRecords
		conGeneric.Close
		Set conGeneric = Nothing
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />

	<style type="text/css">
		BODY  { FONT-FAMILY: Arial; FONT-SIZE: 10pt;
		   BACKGROUND: #ffffff; COLOR: #000000;
		   MARGIN: 15px; }
		H1  { FONT-SIZE: 15pt;}
		.container {
		width: 960px;
		background: #FFF;
		margin: 0 auto;
		padding-top:40px;
		width:733px; height:494px; }
	</style>
</head>
<body>
		<div class="container" ><img src="https://pic.neungyule.com/neungyule/img/popup/update.gif" usemap="#Map" border="0">
		  <map name="Map">
			<area shape="rect" coords="325,383,452,417" href="/" alt="홈으로 이동" >
		  </map>
		</div>
</body>
</html>
<%
		Response.End
	End IF
End Function

Sub SQLInjectionCheck___Start(clientIP)
	Dim injection_query, injection_rs, injection_rsGet, injection_result
	If LCase(""&Request.Cookies("injection_check_queryrun")) <> "done" Then

		injection_query = "NE_COMMON..usp_cpd_tblSqlInjectionWhiteList_check '" & Request.ServerVariables("REMOTE_ADDR") & "'"
		Set injection_rs = Server.CreateObject("ADODB.Recordset")
			With injection_rs
			.CursorLocation = 3
			.LockType = 1
			.CursorType = 0
			.Source = injection_query
			.ActiveConnection = gv_injection_dsn
			.Open
		End With

		If injection_rs.eof Or injection_rs.bof Then
			injection_rsGet = ""
		Else
			injection_rsGet = injection_rs.getrows()
		End If
		injection_rs.close
		Set injection_rs = Nothing

		If IsArray(injection_rsGet) Then
			injection_result = injection_rsGet(0,0)

			If injection_result = "1" Then
				Response.Cookies("injection_check") = "good"
			Else
				Response.Cookies("injection_check") = "fail"
			End If

			Response.Cookies("injection_check_queryrun") = "done"

		End If

	End If

	'아래 특정 URL 은 강사들이 수업 피드백을 하는 페이지임. 그래서 인젝션에서 제외시킴
	If request.cookies("injection_check") <> "good" And request.servervariables("HTTP_HOST") & request.servervariables("HTTP_URL") <> "manager.netimes.co.kr/pages/teacher/teacher_Schedule_PopLec_ins.asp" Then

		Call checkRequestInjection()

	End if
End Sub


Dim gv_injection_dsn

gv_injection_dsn = "Provider=SQLOLEDB;Network Library=DBMSSOCN;Network Address=211.43.209.5,1433;Data Source=211.43.209.5; Initial Catalog=NE_COMMON; User ID=devroot; Password=rootdev!@;"

'Call 방식으로 변경. (아이챌린지 통합 및 지역 변수화)
SQLInjectionCheck___Start Trim(Request.ServerVariables("REMOTE_ADDR"))

'pattern 속성
'https://sg2158.tistory.com/39
%>
