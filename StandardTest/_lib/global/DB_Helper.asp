<%
Class DB_Helper
	'저장프로시저 이용을 위한 클래스
	'다중 레코드셋 대응
	'2013-03-11 안현모 : 리뉴얼

'Sample Code
'		set list = new DB_Helper
'		list.setConnection(et_lms)
'		list.setProcName("dbo.usp_ahm_procXXXX")
'
'		list.setParam "@PARAM1",param1 'Name, Value
'		list.setParamOutput "@OUTPUT1"

'		list.getRecordSet()

'		Response.Write list.getRecordCount(0) '레코드셋 순서에따라 0부터 시작

'		Response.Write list.getRecord(0, i, "fieldName") '레코드셋인덱스, 로우 인덱스, 필드명

'		Response.Write list.getOutput("@OUTPUT1")

'		set list = Nothing

	Private g_objCmd 'ADO.Command 객체를 담기위한 전역변수
	
	Private g_rs '반환된 데이터 저장을 위한 변수
	Private g_field '컬럼명 저장을 위한 Dictionary 변수

	'이부분은 단순 Array 처리할 수도 있을 것 같음.
	Private g_rsMaster(10) '레코드셋을 저장하기 위한 Array
	Private g_fieldMaster(10) '컬럼명을 저장한 Dictionary 변수를 저장하기 위한 Array

	Private g_Output '아웃풋 컬럼명 저장을 위한 Dictionary 변수

	Private g_rsMasterCount '반환된 레코드셋 갯수

	'클래스 생성자
	Private Sub Class_Initialize()
		Set g_objCmd = Server.CreateObject("ADODB.Command")
		
		Set g_Output = Server.CreateObject("Scripting.Dictionary")
		g_objCmd.CommandType = adCmdStoredProc

		g_rsMasterCount = 0
    END Sub

	'클래스 파괴자
	Private Sub Class_Terminate()
		set g_rs = Nothing
		Set g_field = nothing

		Set g_Output = nothing

		set g_objCmd = Nothing
    END Sub

	'커넥션 정보 입력
	Public Sub setConnection(pConn)
		g_objCmd.ActiveConnection = pConn
	End Sub

	'프로시저명 입력
	Public Sub setProcName(pProcName)
		g_objCmd.CommandText = pProcName
	End Sub

	'입력값
	Public Sub setParam(pName, pValue)
		If isNull(pValue) = true Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adVarChar,adParamInput,4000, null)
		ElseIf Len(CStr(pValue)) > 4000 Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adLongVarChar,adParamInput,2147483647,pValue)
		Else
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adVarChar,adParamInput,4000,pValue)
		End If
	End Sub

	Public Sub setParamOutput(pName)
		g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName, adVarChar, adParamOutput,4000)
		g_Output.Add pName, ""
	End Sub

	'레코드셋 반환
	Public Sub getRecordSet()
		Dim rs, rsNext
		Dim i, j, outputName

		Set rs = Server.CreateObject("ADODB.RecordSet")
	    rs.CursorLocation = adUseClient
		rs.Open g_objCmd, ,adOpenForwardOnly, adLockReadOnly

	    Set g_objCmd.ActiveConnection = Nothing

		For i=0 To 10
			Set g_field = Server.CreateObject("Scripting.Dictionary")

			For j=0 To rs.fields.count -1
				g_field.Add LCASE(rs.fields(j).name), j
			Next

			if rs.Eof <> true Then
				g_rs = rs.getRows()
			Else
				g_rs = ""
			End if

			Set g_fieldMaster(i) = g_field
			g_rsMaster(i) =  g_rs
			g_rsMasterCount = g_rsMasterCount + 1

			Set g_field = Nothing

			Set rsNext = rs.NextRecordSet()

			rs.close
			set rs = Nothing

			If rsNext Is Nothing Then
				Exit For
			End If
			
			Set Rs = rsNext
		Next

'Record Set 의 ActiveConnection 이 Nothing 이면 NextRecordSet 이 안됨
'		Set rs.ActiveConnection = Nothing

		For Each outputName In g_Output.Keys
			g_Output.Item(outputName) = g_objCmd.Parameters(outputName).Value
		Next

	    Set g_objCmd = Nothing
	End Sub

	'RecordSet 이 있는지 확인하기 위한 함수 (현재 사용안함)
	Private Function isRecordSetIdxOk(pRecordSetIdx)
		If pRecordSetIdx < 0 Or g_rsMasterCount < pRecordSetIdx Then
			isRecordSetIdxOk = False
		Else
			isRecordSetIdxOk = True
		End If
	End Function

	'output을 처리하기 위한 함수
	Public Function getOutput(pName)
		getOutput = g_Output.Item(pName)
	End Function

	'레코드 하나를 가져오기 위한 함수
	'레코드셋 인덱스, 로우 인덱스, 컬럼명 순서로 처리함
	Public Function getRecord(pRecordSetIdx, pRowIdx, pFieldName)
		Dim rsTmp, fieldTmp
		Dim fieldIdx

		rsTmp = g_rsMaster(pRecordSetIdx)
		Set fieldTmp = g_fieldMaster(pRecordSetIdx)

		fieldIdx = fieldTmp.Item(LCASE(pFieldName))
		
		If fieldIdx = "" Then
			Err.Raise 5
		Else
			getRecord = rsTmp(Cint(fieldIdx), pRowIdx)
		End if
	End Function

	'레코드의 갯수, 레코드셋 인덱스를 기준으로
	Public Function getRecordCount(pRecordSetIdx)
		Dim rsTmp
		rsTmp = g_rsMaster(pRecordSetIdx)

		if isArray(rsTmp) = False Then
			getRecordCount = 0
		Else
			getRecordCount = UBound(rsTmp, 2) + 1
		End if
	End Function

	'rs.getRows 에 대응하기 위한 함수
	Public Function getRecordArray(pRecordSetIdx)
		getRecordArray = g_rsMaster(pRecordSetIdx)
	End Function

	'그냥 실행
	Public Sub Execute()
		g_objCmd.Execute, , adExecuteNoRecords
		Set g_objCmd.ActiveConnection = Nothing

		For Each outputName In g_Output.Keys
			g_Output.Item(outputName) = g_objCmd.Parameters(outputName).Value
		Next

		Set g_objCmd = Nothing
	End Sub
End Class

'구버전 호환용------------------------------------------------------------------------
Class NE_ExecProc
	'저장프로시저 이용을 위한 클래스
	'2012-03-02 안현모 : 최초 개발

'Sample Code
'		set list = new NE_ExecProc
'		list.setConnection(et_lms)
'		list.setProcName("dbo.usp_ahm_AC_COUPON_ORDER_list")
'
'		list.setParam "@PAGE",npage,"i" 'Name, Value, Type(s or i)
'		list.setParam "@PAGE_SIZE",page_size,"i" 'Name, Value, Type(s or i)
'		list.setParam "@COUPONSET",cs_seq,"s" 'Name, Value, Type(s or i)
'		list.setParam "@DATE_FROM",s_date,"s" 'Name, Value, Type(s or i)
'		list.setParam "@DATE_TO",e_date,"s" 'Name, Value, Type(s or i)
'		list.setParam "@SEARCH_TYPE",mem,"s" 'Name, Value, Type(s or i)
'		list.setParam "@SEARCH_VALUE",search,"s" 'Name, Value, Type(s or i)
'		list.setParam "@ISUSE",isuse,"s" 'Name, Value, Type(s or i)

'		set rs = list.getRecordSet() 'RS로 레코드셋 반환
'		set list = Nothing

	private g_objCmd 'ADO.Command 객체를 담기위한 전역변수

	'클래스 생성자
	Private Sub Class_Initialize()
		Set g_objCmd = Server.CreateObject("ADODB.Command")
		g_objCmd.CommandType = adCmdStoredProc
    END Sub

	'클래스 파괴자
	Private Sub Class_Terminate()
		set g_objCmd = Nothing
    END Sub

	'커넥션 정보 입력
	Public Sub setConnection(pConn)
		g_objCmd.ActiveConnection = pConn
	End Sub

	'프로시저명 입력
	Public Sub setProcName(pProcName)
		g_objCmd.CommandText = pProcName
	End Sub

	'입력값
	Public Sub setParam(pName, pValue, pType)
		if pType = "s" Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adVarChar,adParamInput,4000)
		Elseif pType = "i" Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adInteger,adParamInput,0)
		Elseif pType = "t" Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adLongVarChar,adParamInput,2147483647)
		Else
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adVarChar,adParamInput,4000)
		End if
		g_objCmd.Parameters(pName) = pValue
	End Sub

	'레코드셋 반환
	Public Function getRecordSet()
		Set getRecordSet = Server.CreateObject("ADODB.RecordSet")
	    getRecordSet.CursorLocation = adUseClient

		getRecordSet.Open g_objCmd, ,adOpenForwardOnly, adLockReadOnly
		'rs.Open g_objCmd, ,adOpenStatic, adLockReadOnly

'		W rs.fields.count
'		W rs.fields(0).name

	    Set g_objCmd.ActiveConnection = Nothing
	    Set g_objCmd = Nothing
	    Set getRecordSet.ActiveConnection = Nothing
	End Function

	'그냥 실행
	Public Sub Execute()
		g_objCmd.Execute, , adExecuteNoRecords
	    Set g_objCmd.ActiveConnection = Nothing
	    Set g_objCmd = Nothing
	End Sub
End Class


Class NE_Proc
	'저장프로시저 이용을 위한 클래스
	'2012-06-21 안현모 : 최초 개발

'Sample Code
'		set list = new NE_Proc
'		list.setConnection(et_lms)
'		list.setProcName("dbo.usp_ahm_AC_COUPON_ORDER_list")
'
'		list.setParam "@PAGE",npage,"i" 'Name, Value, Type(s or i)
'		list.setParam "@PAGE_SIZE",page_size,"i" 'Name, Value, Type(s or i)
'		list.setParam "@COUPONSET",cs_seq,"s" 'Name, Value, Type(s or i)
'		list.setParam "@DATE_FROM",s_date,"s" 'Name, Value, Type(s or i)
'		list.setParam "@DATE_TO",e_date,"s" 'Name, Value, Type(s or i)
'		list.setParam "@SEARCH_TYPE",mem,"s" 'Name, Value, Type(s or i)
'		list.setParam "@SEARCH_VALUE",search,"s" 'Name, Value, Type(s or i)
'		list.setParam "@ISUSE",isuse,"s" 'Name, Value, Type(s or i)

'		list.getRecordSet()

'		list.getRecordCount()
'		list.getRecord(i, "fieldName")
'		set list = Nothing

	private g_objCmd 'ADO.Command 객체를 담기위한 전역변수
	private g_fieldsName()
	private g_rsGet

	'클래스 생성자
	Private Sub Class_Initialize()
		Set g_objCmd = Server.CreateObject("ADODB.Command")
		g_objCmd.CommandType = adCmdStoredProc
    END Sub

	'클래스 파괴자
	Private Sub Class_Terminate()
		set g_rsGet = Nothing
		set g_objCmd = Nothing
    END Sub

	'커넥션 정보 입력
	Public Sub setConnection(pConn)
		g_objCmd.ActiveConnection = pConn
	End Sub

	'프로시저명 입력
	Public Sub setProcName(pProcName)
		g_objCmd.CommandText = pProcName
	End Sub

	'입력값
	Public Sub setParam(pName, pValue, pType)
		if pType = "s" Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adVarChar,adParamInput,4000)
		Elseif pType = "i" Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adInteger,adParamInput,0)
		Elseif pType = "t" Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adLongVarChar,adParamInput,2147483647)
		Else
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adVarChar,adParamInput,4000)
		End if
		g_objCmd.Parameters(pName) = pValue
	End Sub

	'레코드셋 반환
	Public Sub getRecordSet()
		Dim i
		Dim rs
		Set rs = Server.CreateObject("ADODB.RecordSet")
	    rs.CursorLocation = adUseClient

		rs.Open g_objCmd, ,adOpenForwardOnly, adLockReadOnly

	    Set g_objCmd.ActiveConnection = Nothing
		Set rs.ActiveConnection = Nothing

		reDim g_fieldsName(rs.Fields.Count -1)
		
		For i=0 To rs.fields.count -1
			g_fieldsName(i) = LCASE(rs.fields(i).name)
		Next

		if rs.Eof <> true Then
			g_rsGet = rs.getRows()
		Else
			g_rsGet = ""
		End if

		rs.close
		set rs = nothing
	    Set g_objCmd = Nothing
	End Sub

	Public Function getRecordCount()
		if isArray(g_rsGet) = False Then
			getRecordCount = 0
		Else
			getRecordCount = UBound(g_rsGet, 2) + 1
		End if
	End Function

	Public Function getRecordArray()
		getRecordArray = g_rsGet
	End Function

	Public Function getRecord(pRowIdx, pFieldName)
		Dim i
		
		getRecord = "없는컬럼"

		For i=0 To UBound(g_fieldsName)
			If g_fieldsName(i) = LCASE(pFieldName) Then
				getRecord = g_rsGet(i, pRowIdx)
				Exit For
			End if
		Next
	End Function

	'그냥 실행
	Public Sub Execute()
		g_objCmd.Execute, , adExecuteNoRecords
		Set g_objCmd.ActiveConnection = Nothing
	    Set g_objCmd = Nothing
	End Sub
End Class

Class NE_ProcV2
	'저장프로시저 이용을 위한 클래스
	'2013-03-11 안현모 : 리뉴얼

'Sample Code
'		set list = new NE_Proc
'		list.setConnection(et_lms)
'		list.setProcName("dbo.usp_ahm_AC_COUPON_ORDER_list")
'
'		list.setParam "@PARAM1", param1
'		list.setParam "@PARAM2", param2
'		list.setParam "@PARAM3", param3

'		list.setParamOutput "@OUTPUT1"

'		list.getRecordSet()

'		Response.Write list.getRecordCount()

'		Response.Write list.getRecord(i, "fieldName")

'		Response.Write list.getOutput("@OUTPUT1")

'		set list = Nothing

	Private g_objCmd 'ADO.Command 객체를 담기위한 전역변수
	Private g_field '컬럼명 저장을 위한 Dictionary 변수
	Private g_Output '아웃풋 컬럼명 저장을 위한 Dictionary 변수
	Private g_rs '반환된 데이터 저장을 위한 변수

	'클래스 생성자
	Private Sub Class_Initialize()
		Set g_objCmd = Server.CreateObject("ADODB.Command")
		
		Set g_field = Server.CreateObject("Scripting.Dictionary")

		Set g_Output = Server.CreateObject("Scripting.Dictionary")
		g_objCmd.CommandType = adCmdStoredProc
    END Sub

	'클래스 파괴자
	Private Sub Class_Terminate()
		
		Set g_field = nothing
		Set g_Output = nothing

		set g_rs = Nothing
		set g_objCmd = Nothing
    END Sub

	'커넥션 정보 입력
	Public Sub setConnection(pConn)
		g_objCmd.ActiveConnection = pConn
	End Sub

	'프로시저명 입력
	Public Sub setProcName(pProcName)
		g_objCmd.CommandText = pProcName
	End Sub

	'입력값
	Public Sub setParam(pName, pValue)
		'pValue 를 문자열로 환산하여 4000자가 넘어가면 text 타입으로, 아니면 varchar(4000) 타입으로
		If Len(CStr(pValue)) > 4000 Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adLongVarChar,adParamInput,2147483647,pValue)
		Else
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adVarChar,adParamInput,4000,pValue)
		End If
	End Sub

	'output 파라미터
	Public Sub setParamOutput(pName)
		g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName, adVarChar, adParamOutput,4000)
		g_Output.Add pName, ""
	End Sub

	'레코드셋 반환
	Public Sub getRecordSet()
		Dim rs
		Dim i, tmp

		Set rs = Server.CreateObject("ADODB.RecordSet")
	    rs.CursorLocation = adUseClient

		rs.Open g_objCmd, ,adOpenForwardOnly, adLockReadOnly

	    Set g_objCmd.ActiveConnection = Nothing
		Set rs.ActiveConnection = Nothing

		For i=0 To rs.fields.count -1
			g_field.Add LCASE(rs.fields(i).name), i
		Next

		if rs.Eof <> true Then
			g_rs = rs.getRows()
		Else
			g_rs = ""
		End if

		rs.close
		set rs = Nothing

		For Each tmp In g_Output.Keys
			g_Output.Item(tmp) = g_objCmd.Parameters(tmp).Value
		Next

	    Set g_objCmd = Nothing
	End Sub

	'가져온 레코드의 갯수
	Public Function getRecordCount()
		if isArray(g_rs) = False Then
			getRecordCount = 0
		Else
			getRecordCount = UBound(g_rs, 2) + 1
		End if
	End Function

	'Array로 받아옴 기존의 getRows() 에 대응
	Public Function getRecordArray()
		getRecordArray = g_rs
	End Function

	'output 변수
	Public Function getOutput(pName)
		getOutput = g_Output.Item(pName)
	End Function

	'레코드 내용을 1개 가져옴
	'로우 인덱스, 필드명
	Public Function getRecord(pRowIdx, pFieldName)
		Dim fieldIdx

		fieldIdx = g_field.Item(LCASE(pFieldName))
		
		If fieldIdx = "" Then
			Err.Raise 5
		Else
			getRecord = g_rs(Cint(fieldIdx), pRowIdx)
		End If
	End Function

	'단순 실행만
	Public Sub Execute()
		g_objCmd.Execute, , adExecuteNoRecords
		Set g_objCmd.ActiveConnection = Nothing

		For Each tmp In g_Output.Keys
			g_Output.Item(tmp) = g_objCmd.Parameters(tmp).Value
		Next

	    Set g_objCmd = Nothing
	End Sub
End Class
%>