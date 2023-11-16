<!--METADATA TYPE="TypeLib" uuid="{00000205-0000-0010-8000-00AA006D2EA4}" -->
<%
'*********************************************************
'*
'*	파일 이름   : ado.asp
'*	파일 설명   : function들을 정의한다.
'*
'*	작성자      : 정진우
'*	초안 생성일 : 2009-01-01
'*********************************************************

'*********************************************************
'*	작업 일지 (여기다가 수정 내용 쓰세욤)
'*
'*	xxxx.xx.xx	홍길동	:	내용
'*********************************************************

'*********************************************************
'*		선언 부분				 *
'*********************************************************

'------------------------------------------------------------
'	Tip. 커맨드 객체 예제
'------------------------------------------------------------
'	sql = "usp_xxx_TABLE_list @PAGE = 1"
'
'	Set cmdDB = Server.CreateObject("ADODB.Command")
'	With cmdDB
'		.ActiveConnection = DSN
'		.CommandType = adCmdStoredProc
'		.CommandText = sql
'		.Parameters.Append .CreateParameter("@RETURN_VALUE", adInteger, adParamReturnValue, 0)
'		.Parameters.Append .CreateParameter("@seq", adInteger, adParamInput, , seq)	
'		.Parameters.Append .CreateParameter("@repNo", adSmallInt, adParamInput, , repNo)
'		.Parameters.Append .CreateParameter("@ownPnum", adInteger, adParamInput, , ownpnum)	
'		.Parameters.Append .CreateParameter("@ownFolderNo", adSmallInt, adParamInput, , ownfolderno)
'		.Parameters.Append .CreateParameter("@pnum", adInteger, adParamInput, , pnum)	
'		.Parameters.Append .CreateParameter("@pname", adVarChar, adParamInput, 10, pname)
'		.Parameters.Append .CreateParameter("@pid", adVarChar, adParamInput, 10, pid)
'		.Parameters.Append .CreateParameter("@dupchk", adTinyInt, adParamOutput, , 0)
'		Set rs = .Execute		   
'		
'	Set rs = Nothing
'
'	return_value	= cmdDB.Parameters("@RETURN_VALUE")
'	dupchk	= cmdDB.Parameters("@dupchk")
'	set cmdDB = nothing
'
'	End With

'*********************************************************
'*		구현 부분				 *
'*********************************************************

Sub execSQL(strSQL, strConnectionString)

'	[쿼리 실행] 단순 실행
'
'	Dim sql : sql = "usp_xxx_TABLE_insert @AA = 0"
'	execSQL(sql, DSN)

	If InStr(LCase(strSQL),"sysobjects") > 0 Then response.end
	If InStr(LCase(strSQL),"syscolumns") > 0 Then response.end

	Dim conGeneric
	
	SET conGeneric = Server.CreateObject("ADODB.Connection")

	conGeneric.open strConnectionString
	conGeneric.Execute strSQL, , adExecuteNoRecords
	conGeneric.Close
	
	Set conGeneric = Nothing
End Sub


Function getRecordSet(strSQL, strConnectionString)

'	[쿼리 실행] 레코드 생성
'
'	Dim sql : sql = "usp_xxx_TABLE_list @PAGE = 1"
'
'	Set rs = getrecordset(sql, DSN)
'	If rs.eof Or rs.bof Then
'		rsGet = NULL
'	Else
'		rsGet = rs.getrows()
'	End If
'	rs.close
'	Set rs = Nothing

	If InStr(LCase(strSQL),"sysobjects") > 0 Then response.end
	If InStr(LCase(strSQL),"syscolumns") > 0 Then response.end


	Set getRecordSet = Server.CreateObject("ADODB.Recordset")
	With getRecordSet

	.CursorLocation = adUseClient
	.LockType = adLockReadOnly
	.CursorType = adOpenForwardOnly
	.Source = strSQL
	.ActiveConnection = strConnectionString
	.Open
	
	End With
End Function


Function getDBCacheData(cacheName , procedureName , dsnName , CacheExpire)
	
'	[쿼리 실행] 60분 캐시 생성 exec 필수 !!
'
'	Dim sql : sql = "exec usp_xxx_TABLE_list @PAGE = 1"
'
'	rsGet = getDbCacheData("CACHENAME",sql ,DSN ,60)	

	Dim cacheData
	Dim cacheTime
	cacheData = Application(cacheName)
	cacheTime = Application(cacheName&"CacheTime")
	
	IF Not IsArray(cacheData) Or CacheExpire < DateDiff("n" , cacheTime , Now()) Then
			
		Dim dbData
		Dim dbRs
		Set dbRs = SQLFactory(dsnName , procedureName)

		If dbRs.EOF Or dbRs.BOF Then
			dbData = ""
		Else					
			dbData = dbRs.GetRows()
		End If

		dbRs.Close

		Set dbRs = Nothing
		
		Application.Lock
		Application(cacheName) = dbData
		Application(cacheName&"CacheTime") = Now()
		Application.UnLock
		
		cacheData = dbData
			
	Else

	End IF
	
	getDbCacheData = cacheData
End Function


'*********************************************************
'*		초기화 부분				 *
'*********************************************************
%>

<!--#include file="DB_Helper.asp"-->