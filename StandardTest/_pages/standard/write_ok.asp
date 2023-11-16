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

<%
	'L_MENU = "0"
	L_MENU = "11"
	M_MENU = "1"
	S_MENU = "1"

	Dim sslPort 
	If request.servervariables("LOCAL_ADDR") = "61.32.254.47" Then
		sslPort = ""
	Else
		sslPort = ""
	End If
%>
<%
  dim tkb_num, tk_buyer_name, i
  
  Response.write "tkb_num:" & request("tkb_num") &"<br>"
  if request("tkb_num") > 0 then
    for i = 1 to request("tkb_num") step 1	
      tk_buyer_name = request("tk_buyer_name" & i) &"|"& request("tk_buyer_tel" & i) &"|"& request("tk_buyer_email" & i)
	  Response.write "1.tk_buyer_name:" & tk_buyer_name & "<br>"
	
	if i = 1 then
	  tkb_buyer = tk_buyer_name
	  Response.write "2. tkb_buyer:" & tkb_buyer & ",tk_buyer_name:" & tk_buyer_name & "<br>"
	else
	  tkb_buyer =  tkb_buyer & "," & tk_buyer_name
	  'tkb_buyer =  tkb_buyer & "|" & tk_buyer_name
	   Response.write "3.tkb_buyer:" & tkb_buyer & ",tk_buyer_name:" & tk_buyer_name & "<br>"
	end if
    next
    if i = request("tkb_num") then
      tkb_buyer =  tkb_buyer & ","
	  Response.write "tkb_buyer:" & tkb_buyer & "<br>"
    end if
  end if
  
  'response.write ("<script language='Javascript'>")
  'response.write ("alert('이벤트가 등록 되었습니다.');")
  'response.write "document.location.href = 'write.asp'"
  'response.write ("</script>")
  'response.End()
%>
