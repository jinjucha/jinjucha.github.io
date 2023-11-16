<!-- #include virtual="/_lib/global/unicode.asp" -->

<!-- #include virtual="/_lib/global/func.asp" -->
<!-- #include virtual="/_lib/dsn/dsn.asp" -->
<!-- #include virtual="/_lib/global/ado.asp" -->


</head>
<body>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<table>
<%
Response.Buffer			=	true
Response.Expires		=	0
Response.ContentType	=	"application/x-msexcel"
Response.CacheControl	=	"public"
Response.AddHeader  "Content-Disposition" , "attachment; filename=list_" & date & ".xls"
'https://www.nekids.co.kr/_lib/global/some_encoding.asp

'query="select  tseq,  pass from tblTeacher"
'query = "select mbr_id , mi_email, mi_tel,mi_cph,mi_zipcd,mi_addr,mi_addr_dtl from tblmbrinfo where mbr_id in ('tndus33','heesoo33','jisun0227','ilove7823','fing7823') "
'query = "select mbr_id , mbr_ipin, mbr_brtdy from tblmbr where mbr_id in ('tndus33','heesoo33','jisun0227','ilove7823','fing7823') "
'query = "usp_psy_tblData_getAll"
'query ="select tr_seq, tr_brtdy from tblchldr  where tr_brtdy <> '' "
query = "select m.mbr_id, mbr_nm, i.mi_email  from tblmbr M with(nolock) inner join tblmbrinfo I with(nolock) on M.mbr_id = I.mbr_id where mi_email <> '' and mbr_lev_yn = 'N' and m.mbr_id <> 'qlsskaka123' order by m.mbr_nm "
'query = "select a.mbr_id, a.mi_zipcd, a.mi_addr, a.mi_addr_dtl  from tblmbrinfo a inner join tblmbr b on a.mbr_id=b.mbr_id where b.mbr_lev_yn ='N' "
'query = "select a.mbr_id, c.new_zip  from tblmbrinfo a inner join tblmbr b on a.mbr_id=b.mbr_id "
'query = query & " inner join newzip$ c on b.mbr_id=c.mbr_id "
'query = query& " where b.mbr_lev_yn ='N' and c.new_zip <> ''"

Set rs = getrecordset(query, dsn_nekids)

If rs.bof Or rs.eof Then
           rsGet = ""
Else
           rsGet = rs.getrows
End If
rs.close
Set rs = Nothing
%>

<%
If IsArray(rsGet) Then
           For i = 0 To ubound(rsGet,2)
                    ' rs_purcode          = rsGet(0,i)						
					 mbr_id				  = rsGet(0,i)						
					 mbr_nm				 = rsGet(1,i)						
					 mi_email		     = Trim(rsGet(2,i))
                    ' mi_tel				= rsGet(2,i)
                    ' mi_cph				= rsGet(3,i)
                    ' mi_zipcd	         = rsGet(1,i)
                    ' mi_addr	         = rsGet(2,i)
					' mi_addr_dtl	         = rsGet(3,i)
					
					'If Len(Trim(mbr_pwd)) > 0 Then 	mbr_pwd		= fnc_passEncrypt(mbr_pwd)
					'If Len(Trim(mi_tel)) > 0 Then 	mi_tel		= fnc_passEncrypt(mi_tel)
					'If Len(Trim(mi_cph)) > 0 Then 	mi_cph		= fnc_passEncrypt(mi_cph)
					If Len(Trim(mi_email)) > 0 Then 	mi_email		= fnc_passDecrypt(mi_email)
					'If Len(Trim(mi_addr)) > 0 Then 	mi_addr		= fnc_passEncrypt(mi_addr)
					'If Len(Trim(mi_addr_dtl)) > 0 Then 	mi_addr_dtl		= fnc_passEncrypt(mi_addr_dtl)


					'If Len(Trim(mi_zipcd)) > 1 Then	mi_zipcd		= fnc_passDecrypt(mi_zipcd)
					'If Len(Trim(mi_addr)) > 1 Then		mi_addr		= fnc_passDecrypt(mi_addr)
					'If Len(Trim(mi_addr_dtl)) > 1 Then		mi_addr_dtl		= fnc_passDecrypt(mi_addr_dtl)
					'If Len(Trim(rs_phone1)) > 2 Then 	rs_phone1		= fnc_passDecrypt(rs_phone1)
					'If Len(Trim(rs_phone2)) > 2 Then 	rs_phone2		= fnc_passDecrypt(rs_phone2)
                    'response.write "<tr><td>"
					'response.write mi_id &"</td><td>"& tr_brtdy &"<td></tr>"

					response.flush
	%>
		<tr>
		<td><%=mbr_id%></td><Td><%=mbr_nm%></td><td><%=mi_email%></td><!-- <td><%=mi_addr_dtl%></td> -->
		</tr>
	<%
                    '  next_query = "exec usp_psy_tblData_getupdate " & rs_purcode & ",'" & rs_pwd & "';"
					' next_query = "update tblchldr set tr_brtdy='"& tr_brtdy &"' where tr_seq='"& mi_id &"'"
					' next_query = "update tblmbr set mi_email='"& mi_email &"', mi_tel='"& mi_tel &"', mi_cph='"& mi_cph &"', mi_zipcd='"& mi_zipcd &"', mi_addr='"& mi_addr &"', mi_addr_dtl='"& mi_addr_dtl &"' where mbr_id='"& rs_purcode &"' ; "
					' next_query = "update tblmgr set mgr_pwd='"&mbr_pwd&"' where mgr_id='"& mbr_id &"'"
					' next_query = "update tblmbrinfo set mi_zipcd='"&mi_zipcd&"' where mbr_id='"& mbr_id &"'"
                    ' ww next_query
					 
	                ' execSQL next_query, dsn_nekids
           Next
End if    
%>
</table>

</body>
</html>
