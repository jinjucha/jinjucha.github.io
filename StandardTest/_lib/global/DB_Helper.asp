<%
Class DB_Helper
	'�������ν��� �̿��� ���� Ŭ����
	'���� ���ڵ�� ����
	'2013-03-11 ������ : ������

'Sample Code
'		set list = new DB_Helper
'		list.setConnection(et_lms)
'		list.setProcName("dbo.usp_ahm_procXXXX")
'
'		list.setParam "@PARAM1",param1 'Name, Value
'		list.setParamOutput "@OUTPUT1"

'		list.getRecordSet()

'		Response.Write list.getRecordCount(0) '���ڵ�� ���������� 0���� ����

'		Response.Write list.getRecord(0, i, "fieldName") '���ڵ���ε���, �ο� �ε���, �ʵ��

'		Response.Write list.getOutput("@OUTPUT1")

'		set list = Nothing

	Private g_objCmd 'ADO.Command ��ü�� ������� ��������
	
	Private g_rs '��ȯ�� ������ ������ ���� ����
	Private g_field '�÷��� ������ ���� Dictionary ����

	'�̺κ��� �ܼ� Array ó���� ���� ���� �� ����.
	Private g_rsMaster(10) '���ڵ���� �����ϱ� ���� Array
	Private g_fieldMaster(10) '�÷����� ������ Dictionary ������ �����ϱ� ���� Array

	Private g_Output '�ƿ�ǲ �÷��� ������ ���� Dictionary ����

	Private g_rsMasterCount '��ȯ�� ���ڵ�� ����

	'Ŭ���� ������
	Private Sub Class_Initialize()
		Set g_objCmd = Server.CreateObject("ADODB.Command")
		
		Set g_Output = Server.CreateObject("Scripting.Dictionary")
		g_objCmd.CommandType = adCmdStoredProc

		g_rsMasterCount = 0
    END Sub

	'Ŭ���� �ı���
	Private Sub Class_Terminate()
		set g_rs = Nothing
		Set g_field = nothing

		Set g_Output = nothing

		set g_objCmd = Nothing
    END Sub

	'Ŀ�ؼ� ���� �Է�
	Public Sub setConnection(pConn)
		g_objCmd.ActiveConnection = pConn
	End Sub

	'���ν����� �Է�
	Public Sub setProcName(pProcName)
		g_objCmd.CommandText = pProcName
	End Sub

	'�Է°�
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

	'���ڵ�� ��ȯ
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

'Record Set �� ActiveConnection �� Nothing �̸� NextRecordSet �� �ȵ�
'		Set rs.ActiveConnection = Nothing

		For Each outputName In g_Output.Keys
			g_Output.Item(outputName) = g_objCmd.Parameters(outputName).Value
		Next

	    Set g_objCmd = Nothing
	End Sub

	'RecordSet �� �ִ��� Ȯ���ϱ� ���� �Լ� (���� ������)
	Private Function isRecordSetIdxOk(pRecordSetIdx)
		If pRecordSetIdx < 0 Or g_rsMasterCount < pRecordSetIdx Then
			isRecordSetIdxOk = False
		Else
			isRecordSetIdxOk = True
		End If
	End Function

	'output�� ó���ϱ� ���� �Լ�
	Public Function getOutput(pName)
		getOutput = g_Output.Item(pName)
	End Function

	'���ڵ� �ϳ��� �������� ���� �Լ�
	'���ڵ�� �ε���, �ο� �ε���, �÷��� ������ ó����
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

	'���ڵ��� ����, ���ڵ�� �ε����� ��������
	Public Function getRecordCount(pRecordSetIdx)
		Dim rsTmp
		rsTmp = g_rsMaster(pRecordSetIdx)

		if isArray(rsTmp) = False Then
			getRecordCount = 0
		Else
			getRecordCount = UBound(rsTmp, 2) + 1
		End if
	End Function

	'rs.getRows �� �����ϱ� ���� �Լ�
	Public Function getRecordArray(pRecordSetIdx)
		getRecordArray = g_rsMaster(pRecordSetIdx)
	End Function

	'�׳� ����
	Public Sub Execute()
		g_objCmd.Execute, , adExecuteNoRecords
		Set g_objCmd.ActiveConnection = Nothing

		For Each outputName In g_Output.Keys
			g_Output.Item(outputName) = g_objCmd.Parameters(outputName).Value
		Next

		Set g_objCmd = Nothing
	End Sub
End Class

'������ ȣȯ��------------------------------------------------------------------------
Class NE_ExecProc
	'�������ν��� �̿��� ���� Ŭ����
	'2012-03-02 ������ : ���� ����

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

'		set rs = list.getRecordSet() 'RS�� ���ڵ�� ��ȯ
'		set list = Nothing

	private g_objCmd 'ADO.Command ��ü�� ������� ��������

	'Ŭ���� ������
	Private Sub Class_Initialize()
		Set g_objCmd = Server.CreateObject("ADODB.Command")
		g_objCmd.CommandType = adCmdStoredProc
    END Sub

	'Ŭ���� �ı���
	Private Sub Class_Terminate()
		set g_objCmd = Nothing
    END Sub

	'Ŀ�ؼ� ���� �Է�
	Public Sub setConnection(pConn)
		g_objCmd.ActiveConnection = pConn
	End Sub

	'���ν����� �Է�
	Public Sub setProcName(pProcName)
		g_objCmd.CommandText = pProcName
	End Sub

	'�Է°�
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

	'���ڵ�� ��ȯ
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

	'�׳� ����
	Public Sub Execute()
		g_objCmd.Execute, , adExecuteNoRecords
	    Set g_objCmd.ActiveConnection = Nothing
	    Set g_objCmd = Nothing
	End Sub
End Class


Class NE_Proc
	'�������ν��� �̿��� ���� Ŭ����
	'2012-06-21 ������ : ���� ����

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

	private g_objCmd 'ADO.Command ��ü�� ������� ��������
	private g_fieldsName()
	private g_rsGet

	'Ŭ���� ������
	Private Sub Class_Initialize()
		Set g_objCmd = Server.CreateObject("ADODB.Command")
		g_objCmd.CommandType = adCmdStoredProc
    END Sub

	'Ŭ���� �ı���
	Private Sub Class_Terminate()
		set g_rsGet = Nothing
		set g_objCmd = Nothing
    END Sub

	'Ŀ�ؼ� ���� �Է�
	Public Sub setConnection(pConn)
		g_objCmd.ActiveConnection = pConn
	End Sub

	'���ν����� �Է�
	Public Sub setProcName(pProcName)
		g_objCmd.CommandText = pProcName
	End Sub

	'�Է°�
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

	'���ڵ�� ��ȯ
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
		
		getRecord = "�����÷�"

		For i=0 To UBound(g_fieldsName)
			If g_fieldsName(i) = LCASE(pFieldName) Then
				getRecord = g_rsGet(i, pRowIdx)
				Exit For
			End if
		Next
	End Function

	'�׳� ����
	Public Sub Execute()
		g_objCmd.Execute, , adExecuteNoRecords
		Set g_objCmd.ActiveConnection = Nothing
	    Set g_objCmd = Nothing
	End Sub
End Class

Class NE_ProcV2
	'�������ν��� �̿��� ���� Ŭ����
	'2013-03-11 ������ : ������

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

	Private g_objCmd 'ADO.Command ��ü�� ������� ��������
	Private g_field '�÷��� ������ ���� Dictionary ����
	Private g_Output '�ƿ�ǲ �÷��� ������ ���� Dictionary ����
	Private g_rs '��ȯ�� ������ ������ ���� ����

	'Ŭ���� ������
	Private Sub Class_Initialize()
		Set g_objCmd = Server.CreateObject("ADODB.Command")
		
		Set g_field = Server.CreateObject("Scripting.Dictionary")

		Set g_Output = Server.CreateObject("Scripting.Dictionary")
		g_objCmd.CommandType = adCmdStoredProc
    END Sub

	'Ŭ���� �ı���
	Private Sub Class_Terminate()
		
		Set g_field = nothing
		Set g_Output = nothing

		set g_rs = Nothing
		set g_objCmd = Nothing
    END Sub

	'Ŀ�ؼ� ���� �Է�
	Public Sub setConnection(pConn)
		g_objCmd.ActiveConnection = pConn
	End Sub

	'���ν����� �Է�
	Public Sub setProcName(pProcName)
		g_objCmd.CommandText = pProcName
	End Sub

	'�Է°�
	Public Sub setParam(pName, pValue)
		'pValue �� ���ڿ��� ȯ���Ͽ� 4000�ڰ� �Ѿ�� text Ÿ������, �ƴϸ� varchar(4000) Ÿ������
		If Len(CStr(pValue)) > 4000 Then
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adLongVarChar,adParamInput,2147483647,pValue)
		Else
			g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName,adVarChar,adParamInput,4000,pValue)
		End If
	End Sub

	'output �Ķ����
	Public Sub setParamOutput(pName)
		g_objCmd.Parameters.Append g_objCmd.CreateParameter(pName, adVarChar, adParamOutput,4000)
		g_Output.Add pName, ""
	End Sub

	'���ڵ�� ��ȯ
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

	'������ ���ڵ��� ����
	Public Function getRecordCount()
		if isArray(g_rs) = False Then
			getRecordCount = 0
		Else
			getRecordCount = UBound(g_rs, 2) + 1
		End if
	End Function

	'Array�� �޾ƿ� ������ getRows() �� ����
	Public Function getRecordArray()
		getRecordArray = g_rs
	End Function

	'output ����
	Public Function getOutput(pName)
		getOutput = g_Output.Item(pName)
	End Function

	'���ڵ� ������ 1�� ������
	'�ο� �ε���, �ʵ��
	Public Function getRecord(pRowIdx, pFieldName)
		Dim fieldIdx

		fieldIdx = g_field.Item(LCASE(pFieldName))
		
		If fieldIdx = "" Then
			Err.Raise 5
		Else
			getRecord = g_rs(Cint(fieldIdx), pRowIdx)
		End If
	End Function

	'�ܼ� ���ุ
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