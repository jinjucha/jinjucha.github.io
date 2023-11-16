<%
'*********************************************************
'*
'*	파일 이름   : func.asp
'*	파일 설명   : 모든영역에서 자주 사용되어지며 공통으로 발생되어지는 함수들을 선언 및 정의한다
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
'*		구현 부분				 *
'*
'*	fromDBHtmlStr 추가
'*********************************************************

'-----------------------------------------------------
'Change Query String
'-----------------------------------------------------

Function fnc_SSLCOVERIMG(fn_imgUrl)
	fn_imgUrl = Replace(""&fn_imgUrl,"http://pic.neungyule.com","https://pic.neungyule.com")
	fn_imgUrl = Replace(fn_imgUrl,"http://upfile.neungyule.com","https://upfile.neungyule.com")
	fn_imgUrl = Replace(fn_imgUrl,"http://booksfile.neungyule.com","https://booksfile.neungyule.com")
	fn_imgUrl = Replace(fn_imgUrl,"http://www.neteacher.co.kr","https://www.neteacher.co.kr")
	fn_imgUrl = Replace(fn_imgUrl,"http://m.neteacher.co.kr","https://m.neteacher.co.kr")
	fn_imgUrl = Replace(fn_imgUrl,"http://www.nebooks.co.kr","https://www.nebooks.co.kr")
	fn_imgUrl = Replace(fn_imgUrl,"http://www.nekids.co.kr","https://www.nekids.co.kr")
	fn_imgUrl = Replace(fn_imgUrl,"http://mobilevod.neungyule.com","https://mobilevod.neungyule.com")
	fn_imgUrl = Replace(fn_imgUrl,"http://dimg.donga.com/","https://dimg.donga.com/")
	fn_imgUrl = Replace(fn_imgUrl,"http://image.donga.com/","https://image.donga.com/")

	fnc_SSLCOVERIMG = fn_imgUrl
End Function


Function ckStr(dest, ishtml)

	If ishtml = "" Then ishtml = "0"

	If ishtml = "0" Then
		dest = Replace(dest, "'", "''")
	ElseIf ishtml = "1" Then
		dest = Replace(dest, "'", "''")
		dest = Replace(dest, "<", "&lt;")
		dest = Replace(dest, ">", "&gt;")
		dest = Replace(dest, "script", "")
		dest = Replace(dest, "union", "")
		dest = Replace(dest, "update", "")
		dest = Replace(dest, "delete", "")
		dest = Replace(dest, "xp_cmdshell", "")
		dest = Replace(dest, "select", "")
		dest = Replace(dest, "drop", "")
		dest = Replace(dest, "truncate", "")
		dest = Replace(dest, "dbcc", "")
	End If

	ckStr = dest
End Function

Function onchkFile(chkfile)
	Dim returnNum : returnNum = "1"

'-----------------------2011-03-04 송대웅 수정 시작-----------------------
	If chkfile <> "" Then
		If InStr(chkfile, LCase(".zip")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".hwp")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".doc")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".docx")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".ppt")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".pptx")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".xls")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".xlsx")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".jpg")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".gif")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".png")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".bmp")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".pdf")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".txt")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".xml")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".mp3")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".wma")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".wmv")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".mp4")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".flv")) > 0 Then returnNum = "0"
		If InStr(chkfile, LCase(".asp")) > 0 Then returnNum = "1"
		If InStr(chkfile, ";") > 0 Then returnNum = "1"
	End if
'----------------------2011-03-04 송대웅 수정 끝 -----------------------
	onchkFile = returnNum
End Function

Function fnc_bitCampare(num, pos)
	If (num And (2 ^ (pos-1))) = (2 ^ (pos-1)) Then
		fnc_bitCampare = 1
	else
		fnc_bitCampare = 0
	End if
End Function

Function getHTML(urlInfo)
	dim Http, strBuffer
	Set Http = CreateObject("msxml2.serverXmlhttp")
	Http.Open "GET", urlInfo, False
	Http.Send
	strBuffer = BinDecode(Http.responseBody)

	Set Http = Nothing

	getHTML = strBuffer
end Function

Function BinDecode(byVal binData)
	Dim i, byteChr, strV

	For i = 1 to LenB(binData)
		byteChr = AscB(MidB(binData,i,2))
		If byteChr > 127 Then
			i = i + 1
			strV = strV & Chr("&H" & Hex(byteChr) & Hex(AscB(MidB(binData,i,2))))
		Else
			strV = strV & Chr(byteChr)
		End if
	Next

	BinDecode = strV
End Function

'/*--------------------------------------------------------
'// 비밀번호 유효성 체크
'--------------------------------------------------------*/
Function chkValid(sType, ByVal str)
	Dim objRegExp 
	Set objRegExp = New RegExp
	objRegExp.IgnoreCase = False
	objRegExp.Global = True

	If sType = "id" Then 
		'영문으로 시작하는 영문+숫자 5~20 
		objRegExp.Pattern = "^[a-zA-Z]{1}[a-zA-Z0-9_-]{4,19}$" 
		chkPattern = objRegExp.Test(str)
	ElseIf sType = "pw" Then 

		Dim checker : checker = 0 '조합의 수.

		'영문 대소문자
		objRegExp.Pattern = "[A-Za-z]"
		if objRegExp.Test(str) then checker = checker + 1
		'숫자
		objRegExp.Pattern = "[0-9]"
		if objRegExp.Test(str) then checker = checker + 1
		'기호
		objRegExp.Pattern = "[~!?@\#$%<>^&*\()\-=+_\']"
		if objRegExp.Test(str) then checker = checker + 1
		'두개 이상의 문자가 있는지 판단.
		if checker >= 2 then
			'최소 문자 수 설정 (세가지 조합 : 8자, 두가지 조합 : 10자).
			'if checker >= 3 then minLength = 8 else minLength = 10
			'패턴에 따른 리턴.
			objRegExp.Pattern = "^[a-zA-Z0-9~!?@\#$%<>^&*\()\-=+_\']{8,20}$"
			chkPattern = objRegExp.Test(str)
		else
			chkPattern = false
		end if

	End If 

	'객체 소멸
	Set objRegExp = Nothing
	
	chkValid = chkPattern
End Function 


'/*--------------------------------------------------------
'// DB Insert 시 특수문자 처리
'--------------------------------------------------------*/
Function toDBHtmlStr(CheckValue)
	Dim Str

	If IS_NV(CheckValue) <> "" Then
		Str = CheckValue
		Str = Replace(Str, "&", "&amp;")
		Str = Replace(Str, "<", "&lt;")
		Str = Replace(Str, ">", "&gt;")
		Str = Replace(Str, chr(34), "&quot;")
		Str = Replace(Str, "'", "''")
		'Str = Replace(Str, chr(13) & chr(10), "")
		ToDBHtmlStr = Str
	Else
		ToDBHtmlStr = ""
	End If
End Function

' ---------------------------------------------------------------------------
'	엔터 값 바꾸어주기
'	input	: string (DB value , <br>)
' ---------------------------------------------------------------------------
Function Nl2br(enter_str)
	Dim replaceStr
	replaceStr = replace(IS_NV(enter_str), chr(13) & chr(10), "<br />")
	Nl2br = replaceStr
End Function

Function fromDBHtmlStr(CheckValue)
	Dim Str

	If IS_NV(CheckValue) <> "" Then
		Str = CheckValue
		Str = Replace(Str, "&amp;", "&")
		Str = Replace(Str, "&lt;", "<")
		Str = Replace(Str, "&gt;", ">")
		Str = Replace(Str, "&quot;", chr(34))
		Str = Replace(Str, "''", "'")
		'Str = Replace(Str, chr(13) & chr(10), "")
		FromDBHtmlStr = Str
	Else
		FromDBHtmlStr = ""
	End If
End Function

Function StripTags(htmlDoc)
  dim rex

  set rex = new Regexp
  rex.Pattern= "<[^>]+>"
  rex.Global=true
  StripTags =rex.Replace(htmlDoc,"")
End Function

Function Lpad(oriStr,num,preStr)
		tmpSt = "" 
		If Len(oriStr) < Cint(num) Then
			For i=1 to (Cint(num)-Len(oriStr))
				tmpStr = preStr&tmpStr
			Next
			oriStr = tmpStr&oriStr
		End If
		
		LPAD = oriStr
End Function

Sub NullCheckVariable(ByVal theValue)
	if theValue = "" Then
		Call Alert("입력사항을 다시 확인해 주세요")
		Call HistoryGo(-1)
		Response.End
	End if
End Sub



Function Alert(Msg)
	Response.Write("<SCRIPT LANGUAGE='JavaScript'>")
	Response.Write("alert('"&Msg&"');")
	Response.Write("</SCRIPT>")
End Function

Function HistoryGo(Count)
	Response.Write("<SCRIPT LANGUAGE='JavaScript'>")
	Response.Write("history.go("&Count&");")
	Response.Write("</SCRIPT>")
End Function
'-----------------------------------------------------
'암호화
'-----------------------------------------------------
const BASE_64_MAP_INIT = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

Dim nl
Dim Base64EncMap(63)
Dim Base64DecMap(127)

' must be called before using anything else
PUBLIC SUB initCodecs()
	' init vars
	nl = "<P>" & chr(13) & chr(10)
	' setup base 64
	Dim max, idx
	 max = len(BASE_64_MAP_INIT)
	for idx = 0 to max - 1
	   ' one based string
	   Base64EncMap(idx) = mid(BASE_64_MAP_INIT, idx + 1, 1)
	next
	for idx = 0 to max - 1
	   Base64DecMap(ASC(Base64EncMap(idx))) = idx
	next
END SUB

' encode base 64 encoded string
PUBLIC FUNCTION base64Encode(plain)

	if len(plain) = 0 then
	   base64Encode = ""
	   exit function
	end if

	Dim ret, ndx, by3, first, second, third
	by3 = (len(plain) \ 3) * 3
	ndx = 1
	do while ndx <= by3
	   first  = asc(mid(plain, ndx+0, 1))
	   second = asc(mid(plain, ndx+1, 1))
	   third  = asc(mid(plain, ndx+2, 1))
	   ret = ret & Base64EncMap(  (first \ 4) AND 63 )
	   ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) )
	   ret = ret & Base64EncMap( ((second * 4) AND 60) + ((third \ 64) AND 3 ) )
	   ret = ret & Base64EncMap( third AND 63)
	   ndx = ndx + 3
	loop
	' check for stragglers
	if by3 < len(plain) then
		first  = asc(mid(plain, ndx+0, 1))
		ret = ret & Base64EncMap(  (first \ 4) AND 63 )
		if (len(plain) MOD 3 ) = 2 then
			second = asc(mid(plain, ndx+1, 1))
			ret = ret & Base64EncMap( ((first * 16) AND 48) + ((second \ 16) AND 15 ) )
			ret = ret & Base64EncMap( ((second * 4) AND 60) )
		else
			ret = ret & Base64EncMap( (first * 16) AND 48)
			ret = ret & "="
		end if
		ret = ret & "="
	end if

	base64Encode = ret
 END FUNCTION

 ' decode base 64 encoded string
 PUBLIC FUNCTION base64Decode(scrambled)

	if len(scrambled) = 0 then
		base64Decode = ""
		exit function
	end if

	' ignore padding
	Dim realLen
	realLen = len(scrambled)
	do while mid(scrambled, realLen, 1) = "="
		realLen = realLen - 1
	Loop

	Dim ret, ndx, by4, first, second, third, fourth
	ret = ""
	by4 = (realLen \ 4) * 4
	ndx = 1
	do while ndx <= by4
		first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1)))
		second = Base64DecMap(asc(mid(scrambled, ndx+1, 1)))
		third  = Base64DecMap(asc(mid(scrambled, ndx+2, 1)))
		fourth = Base64DecMap(asc(mid(scrambled, ndx+3, 1)))
		ret = ret & chr( ((first * 4) AND 255) +   ((second \ 16) AND 3))
		ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15) )
		ret = ret & chr( ((third * 64) AND 255) +  (fourth AND 63) )
		ndx = ndx + 4
	loop
	' check for stragglers, will be 2 or 3 characters
	if ndx < realLen then
		first  = Base64DecMap(asc(mid(scrambled, ndx+0, 1)))
		second = Base64DecMap(asc(mid(scrambled, ndx+1, 1)))
		ret = ret & chr( ((first * 4) AND 255) +   ((second \ 16) AND 3))

		if realLen MOD 4 = 3 then
			third = Base64DecMap(asc(mid(scrambled,ndx+2,1)))
			ret = ret & chr( ((second * 16) AND 255) + ((third \ 4) AND 15) )
		end if
	end if

	base64Decode = ret
 END FUNCTION

call initCodecs

''''''''''''''''''''''''''''''''''
'Response.Write
''''''''''''''''''''''''''''''''''
Function W(dest)
	Response.Write(dest)
End Function

''''''''''''''''''''''''''''''''''
'Response.Write And BR 태그
''''''''''''''''''''''''''''''''''
Function WW(dest)
	Response.Write(dest & "<br>")
End Function

''''''''''''''''''''''''''''''''''
'Response.Write + vbCrLf
''''''''''''''''''''''''''''''''''
Function WC(dest)
	Response.Write(dest & vbCrLf)
End Function

''''''''''''''''''''''''''''''''''
'Response.Flush 플러쉬
''''''''''''''''''''''''''''''''''
Function F()
	Response.Flush
End Function

''''''''''''''''''''''''''''''''''
'Response.End
''''''''''''''''''''''''''''''''''
Function E()
	Response.End
End Function


''''''''''''''''''''''''''''''''''
'Request.Get
''''''''''''''''''''''''''''''''''
Function R(name)
	R = Trim(Request(name))
End Function

''''''''''''''''''''''''''''''''''
'Request.Form
''''''''''''''''''''''''''''''''''
Function RF(name)
	RF = Trim(Request.Form(name))
End Function

''''''''''''''''''''''''''''''''''
'Request.QueryString
''''''''''''''''''''''''''''''''''
Function RQ(name)
	RQ = Trim(Request.QueryString(name))
End Function

''''''''''''''''''''''''''''''''''
'Request.Cookies
''''''''''''''''''''''''''''''''''
Function RC(key)
	RC = Trim(Request.Cookies(key))
End Function

''''''''''''''''''''''''''''''''''
'Request.Servervariables
''''''''''''''''''''''''''''''''''
Function RV(name)
	RV = Request.ServerVariables(name)
End Function

''''''''''''''''''''''''''''''''''
'Response.Redirect
'''''''''''''''''''''''''''''''
Function RR(url)
	Response.Redirect url
End Function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'	Javascript 호출 Window control 함수
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function ALERT(msg)
	msg = Replace(msg, "'", "\'") '작은 따옴표 에러방지
	W("<Script>")
	W("alert('" & msg & "');")
	W("</Script>")
End Function

Function BACK()
	W("<Script>")
	W("history.back();")
	W("</Script>")
	E()
End Function

Function GO(url)
	url = Replace(url, "'", "") '스크립트 에러 방지
	W("<Script>")
	W("location.href = '" & url & "';")
	W("</Script>")
	E()
End Function

Function MW(url, windowName, features)
	url		= Replace(url, "'", "") '스크립트 에러방지
	windowName	= Replace(windowName, "'", "")
	features	= Replace(features, "'", "")

	W("<Script>")
	W("window.showModelessDialog( '"&url&"','"&windowName&"', "&features&");")
	W("</Script>")
End Function

Function OPEN(url, winName, features)
	url		= replace(url, "'", "\'")
	winName	= replace(winName, "'", "\'")
	features= replace(features, "'", "\'")

	W("<script>window.open('" & url & "','" & winName & "', '" & features & "');</script>")
end function

Function CLOSE()
	W("<script>window.close();</script>")
	E()
end function

''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'	User Define Function g 유용한 간편화 함수
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function IS_NV(t)
	IS_NV = isNull(t) or t = ""
end function

Function IS_NUM(t)
	if IS_NV(t) then
		IS_NUM = false
	else
		if isNumeric(t) then
			IS_NUM = true
		else
			IS_NUM = false
		end if
	end if
end function

Function C_INT(val)
	if IS_NUM(val) then
		C_INT = val + 0
	else
		C_INT = -1
	end if
end function

Function C_STR(val)
	if IS_NV(val) then
		C_STR = ""
	else
		C_STR = "" & CSTR(val)
	end if
end function

Function D_INT(val, defaults)
	If IsNumeric(val)	Then
		D_INT = val
	else
		D_INT	= defaults
	End If
End Function

Function D_STR(val, defaults)
	If IS_NV(val)	Then
		D_STR = defaults
	Else
		D_STR = val
	End if
End Function

function IIF(t, y, n)
	if t then
		IIF = y
	else
		IIF = n
	end if
end Function


Function NL2BR(val)
	Dim replaceStr
	replaceStr = replace(d_str(val,""), chr(13) & chr(10), "<br />")
	NL2BR = replaceStr
End Function


function GetBytes(str)
	Dim i, bytes, c
	str = C_STR(str)
	bytes = 0
	for i = 1 to len(str)
		c = mid(str, i, 1)
		if asc(c) < 0 or asc(c) > 127 then
			bytes = bytes + 2
		else
			bytes = bytes + 1
		end if
	next
	GetBytes = bytes
end Function

Function fnc_TrimStr(str, strlen)

	dim rValue,TrimStr_i
	dim nLength, tmpStr, tmpLen
	nLength = 0.00
	rValue = ""

	for TrimStr_i = 1 to len(str)
		tmpStr = MID(str,TrimStr_i,1)
		tmpLen = ASC(tmpStr)

		if (tmpLen < 0) then
			nLength = nLength + 1.4 '한글일때 길이값 설정
			rValue = rValue & tmpStr
		elseif (tmpLen >= 97 and tmpLen <= 122) then
			nLength = nLength + 0.85 '영문소문자 길이값 설정
			rValue = rValue & tmpStr
		elseif (tmpLen >= 65 and tmpLen <= 90) then
			nLength = nLength + 1 ' 영문대문자 길이값 설정
			rValue = rValue & tmpStr
		else
			nLength = nLength + 0.8 '특수문자 기호값...
			rValue = rValue & tmpStr
		end if

		If (nLength > strlen) then
			rValue = rValue & "..."
			exit for
		end if
	next

	fnc_TrimStr = rValue

End Function

''''''''''''''''''''''''''''''''''''''''''''''''
' 디버깅용 함수
''''''''''''''''''''''''''''''''''''''''''''''''
Function Print()

	Dim keys

	WW "<b>REQUEST_METHOD </b>: " & RV("REQUEST_METHOD")

	If RV("REQUEST_METHOD") = "GET"	then
		For Each keys In Request.QueryString
			WW "<B>" & keys & "</B> : " & gReqQ(keys)
		Next
	Else
		For Each keys In Request.Form
			WW "<B>" & keys & "</B> : " & gReqF(keys)
		Next
	End if

End Function

Sub Check_SQLInjection()
      Dim LWItem, strlogfilename, HLogfso, FormData, ErrParity, HLogGetFile, errURL,getData,getParam
      errURL = "/"
	  ErrParity = 0
	  getData =""
	  getParam=""
      For each LWItem in Request.QueryString
      '      response.write (LWItem & ":" & Reuqest.QueryString(LWItem) & "<BR>")
            if Request.QueryString(LWItem) <> empty then
				if inStr(lcase(Request.QueryString(LWItem)), "delete") > 0 and inStr(lcase(Request.QueryString(LWItem)), "from") > 0 then
					ErrParity = 111
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end if
				if (inStr(lcase(Request.QueryString(LWItem)), "char") > 0 or inStr(lcase(Request.QueryString(LWItem)), "varchar") > 0) and inStr(lcase(Request.QueryString(LWItem)), "master") > 0 then
					ErrParity = 112
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end if
				if (inStr(lcase(Request.QueryString(LWItem)), "varchar") > 0 or inStr(lcase(Request.QueryString(LWItem)), "cursor") > 0) and inStr(lcase(Request.QueryString(LWItem)), "sysobjects") > 0 then
					ErrParity = 113
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.QueryString(LWItem)), "update") > 0 and inStr(lcase(Request.QueryString(LWItem)), "set") > 0 and inStr(lcase(Request.QueryString(LWItem)), ".js") > 0 then
					ErrParity = 114
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.QueryString(LWItem)), "master") > 0 and inStr(lcase(Request.QueryString(LWItem)), "sysdatabases") > 0 then
					ErrParity = 115
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.QueryString(LWItem)), ";") > 0 and inStr(lcase(Request.QueryString(LWItem)), "exec") > 0 And ( inStr(lcase(Request.QueryString(LWItem)), "sp_") > 0 or inStr(lcase(Request.QueryString(LWItem)), "xp_") > 0) Then
					ErrParity = 116
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.QueryString(LWItem)), "declare") > 0 and inStr(lcase(Request.QueryString(LWItem)), "cursor") > 0 then
					ErrParity = 117
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end If
				if inStr(lcase(Request.QueryString(LWItem)), "xtype") > 0 and inStr(lcase(Request.QueryString(LWItem)), "where") > 0 then
					ErrParity = 118
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end if

				if inStr(lcase(Request.QueryString(LWItem)), "drop") > 0 and inStr(lcase(Request.QueryString(LWItem)), "table") > 0 then
					ErrParity = 119
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end if

				if inStr(lcase(Request.QueryString(LWItem)), "declare") > 0 and inStr(lcase(Request.QueryString(LWItem)), "exec") > 0 then

					ErrParity = 120
					getData = Request.QueryString(LWItem)
					getParam = LWItem
					exit for
				end If
            end if
      Next
      For each LWItem in Request.Form
      '      response.write (LWItem & ":" & Reuqest.QueryString(LWItem) & "<BR>")
            FormData = FormData & "&" & lwItem & "=" & Request.Form(LWItem)
            if Request.Form(LWItem) <> empty then
				if inStr(lcase(Request.Form(LWItem)), "delete") > 0 and inStr(lcase(Request.Form(LWItem)), "from") > 0 then
					ErrParity = 211
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end if
				if (inStr(lcase(Request.Form(LWItem)), "char") > 0 or inStr(lcase(Request.Form(LWItem)), "varchar") > 0) and inStr(lcase(Request.Form(LWItem)), "master") > 0 then
					ErrParity = 212
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end if
				if (inStr(lcase(Request.Form(LWItem)), "varchar") > 0 or inStr(lcase(Request.Form(LWItem)), "cursor") > 0) and inStr(lcase(Request.Form(LWItem)), "sysobjects") > 0 then
					ErrParity = 213
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.Form(LWItem)), "update") > 0 and inStr(lcase(Request.Form(LWItem)), "set") > 0 and inStr(lcase(Request.Form(LWItem)), ".js") > 0 then
					ErrParity = 214
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.Form(LWItem)), "master") > 0 and inStr(lcase(Request.Form(LWItem)), "sysdatabases") > 0 then
					ErrParity = 215
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.Form(LWItem)), ";") > 0 and inStr(lcase(Request.Form(LWItem)), "exec") > 0 And ( inStr(lcase(Request.Form(LWItem)), "sp_") > 0 or inStr(lcase(Request.Form(LWItem)), "xp_") > 0) Then
					ErrParity = 216
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.Form(LWItem)), "declare") > 0 and inStr(lcase(Request.Form(LWItem)), "cursor") > 0 then
					ErrParity = 217
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end If
				if inStr(lcase(Request.Form(LWItem)), "xtype") > 0 and inStr(lcase(Request.Form(LWItem)), "where") > 0 then
					ErrParity = 218
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end if

				if inStr(lcase(Request.Form(LWItem)), "drop") > 0 and inStr(lcase(Request.Form(LWItem)), "table") > 0 then
					ErrParity = 219
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end if

				if inStr(lcase(Request.Form(LWItem)), "declare") > 0 and inStr(lcase(Request.Form(LWItem)), "exec") > 0 then

					ErrParity = 220
					getData = Request.Form(LWItem)
					getParam = LWItem
					exit for
				end If
            end if
      Next

      For each LWItem in Request.Cookies
      '      response.write (LWItem & ":" & Reuqest.QueryString(LWItem) & "<BR>")
            FormData = FormData & "&" & lwItem & "=" & Request.Cookies(LWItem)
            if Request.Cookies(LWItem) <> empty then
				if inStr(lcase(Request.Cookies(LWItem)), "delete") > 0 and inStr(lcase(Request.Cookies(LWItem)), "from") > 0 then
					ErrParity = 311
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end if
				if (inStr(lcase(Request.Cookies(LWItem)), "char") > 0 or inStr(lcase(Request.Cookies(LWItem)), "varchar") > 0) and inStr(lcase(Request.Cookies(LWItem)), "master") > 0 then
					ErrParity = 312
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end if
				if (inStr(lcase(Request.Cookies(LWItem)), "varchar") > 0 or inStr(lcase(Request.Cookies(LWItem)), "cursor") > 0) and inStr(lcase(Request.Cookies(LWItem)), "sysobjects") > 0 then
					ErrParity = 313
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.Cookies(LWItem)), "update") > 0 and inStr(lcase(Request.Cookies(LWItem)), "set") > 0 and inStr(lcase(Request.Cookies(LWItem)), ".js") > 0 then
					ErrParity = 314
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.Cookies(LWItem)), "master") > 0 and inStr(lcase(Request.Cookies(LWItem)), "sysdatabases") > 0 then
					ErrParity = 315
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.Cookies(LWItem)), ";") > 0 and inStr(lcase(Request.Cookies(LWItem)), "exec") > 0 And ( inStr(lcase(Request.Cookies(LWItem)), "sp_") > 0 or inStr(lcase(Request.Cookies(LWItem)), "xp_") > 0) Then
					ErrParity = 316
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end if
				if inStr(lcase(Request.Cookies(LWItem)), "declare") > 0 and inStr(lcase(Request.Cookies(LWItem)), "cursor") > 0 then
					ErrParity = 317
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end If
				if inStr(lcase(Request.Cookies(LWItem)), "xtype") > 0 and inStr(lcase(Request.Cookies(LWItem)), "where") > 0 then
					ErrParity = 318
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end if

				if inStr(lcase(Request.Cookies(LWItem)), "drop") > 0 and inStr(lcase(Request.Cookies(LWItem)), "table") > 0 then
					ErrParity = 319
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end if

				if inStr(lcase(Request.Cookies(LWItem)), "declare") > 0 and inStr(lcase(Request.Cookies(LWItem)), "exec") > 0 then

					ErrParity = 320
					getData = Request.Cookies(LWItem)
					getParam = LWItem
					exit for
				end If
            end if
      Next

	  if ErrParity >= 1 Then
		  alert "Injection Attack"
		  response.end	  	  
            strlogfilename = server.mappath("\")& "\sql_injection_log\sqlInjection_Log.txt"
          ' response.write(strlogfilename)
		     Dim fs, objFile
             Set fs = Server.CreateObject("Scripting.FileSystemObject")
				Set objFile = fs.OpenTextFile(strlogfilename,8)
				objFile.writeLine("Time=" & now )
				objFile.writeLine("c-ip="& request.ServerVariables("REMOTE_ADDR")& " / " & "ErrParity:" &ErrParity)
				objFile.writeLine("Param="& getParam)
				objFile.writeLine(getData)
				objFile.writeLine("reffer=" & Request.ServerVariables("HTTP_REFERER") )
				objFile.writeLine("Page:" & Request.ServerVariables("SCRIPT_NAME") &"  news===========")
				objFile.close
				%>
					<script language="javascript">alert("parameter error");document.location = "<%=errURL%>"</script>
				<%
				Response.end
	  End IF
End Sub



'sql injection check				'현모대리 버전으로 교체
'call Check_SQLInjection()


'*********************************************************
'*		초기화 부분				 *
'*********************************************************
Dim gv_domain, gv_protocol, gv_addUrl, gv_loginUrl, gv_mainUrl, gv_MemberUrl, gv_telephone, gv_adminemail, gv_imgdomain

gv_adminemail	= "akai0820@xxxx.yyyy"
gv_telephone	= "02-2014-7236"

gv_MemberUrl= "http://" & RV("HTTP_HOST") & "/pages/member/member_login.asp" ' 로그인 FORM
gv_loginUrl	= "https://" & RV("HTTP_HOST") & "/pages/member/login.asp" ' 로그인 PROC
gv_mainUrl	= "http://" & RV("HTTP_HOST") & "/pages/index/index.asp" ' 메인

If RV("SERVER_PROTOCOL") = "HTTP/1.1" Then gv_protocol = "http" Else gv_protocol = "https" End If

Function fnc_passEncrypt(getValue)
	If getValue = "" Then
		fnc_passEncrypt = ""
		Exit Function
	End if
	fnc_passEncrypt = fnc_passEncrypt1(getValue)
End Function

Function fnc_passDecrypt(getValue)
	If getValue = "" Then
		fnc_passDecrypt = ""
		Exit Function
	Else
		' 문자열 복호화.
		getValue = Replace(getValue,"%2F","/")
		getValue = Replace(getValue,"%2B","+")

		fnc_passDecrypt = fnc_passDecrypt1(getValue)
	end if
End Function

' ---------------------------------------------------------------------------
' 배열요소 값 중에 인자값과 같은 값이 있는지 확인
' arr:배열,val:찾을 값
' ---------------------------------------------------------------------------
Function InArray(arr,val)
		result = False
		For k=0 To UBound(arr)
			If Trim(arr(k)) = val Then
				result = True
				Exit For
			End If
		Next

		InArray = result
End Function

'
'Function fnc_getgrade(idnum)
'
'
'	Dim f_query, f_rs, f_rsGet, f_i
'	Dim f_rs_mtypes, f_rs_p_idnum
'
'	f_query = "usp_cpd_tblmember_view3 " & idnum
'	Set f_rs = getRecordset(f_query, dsn_member)
'
'	If f_rs.eof Or f_rs.bof Then
'		f_rsGet = ""
'	Else
'		f_rsGet = f_rs.getrows
'	End If
'	f_rs.close
'	Set f_rs = Nothing
'
'	If IsArray(f_rsGet) Then
'		f_rs_mtypes		= f_rsGet(0,0)
'		f_rs_p_idnum	= ""&f_rsGet(1,0)
'	End If
'
'	If f_rs_mtypes = "2" And f_rs_p_idnum = "" Then ' 단체 대표
'		fnc_getgrade = "5"
'	elseIf f_rs_mtypes = "2" And f_rs_p_idnum <> "" Then ' 단체 일반회원
'		fnc_getgrade = "6"
'	elseIf f_rs_mtypes = "1" Then ' 일반회원
'		fnc_getgrade = "1"
'	End if
'End Function


Function fnc_getgrade(g_idnum)
'** 구독보류 설정된것으로 적용
	Dim g_query, g_rs, g_rsGet
	Dim g_rs_mtypes, g_rs_p_idnum, g_rs_myItemType

	'return : @mtypes, @p_idnum, @myItemType
	g_query = "usp_jjw_myGrantInfo_breakOn @idnum = '"& g_idnum &"'"
	Set g_rs = getRecordset(g_query, dsn_young)

	If g_rs.eof Or g_rs.bof Then
		g_rsGet = ""
	Else
		g_rsGet = g_rs.getrows
	End If
	g_rs.close
	Set g_rs = Nothing

	If IsArray(g_rsGet) Then
		g_rs_mtypes		= g_rsGet(0,0)
		g_rs_p_idnum	= g_rsGet(1,0)
		g_rs_myItemType	= g_rsGet(2,0)
	Else
		g_rs_mtypes		= 0
		g_rs_p_idnum	= 0
		g_rs_myItemType	= 0
	End If

	'If g_rs_mtypes = "1" Then ' 일반회원
	'	권한 시작
	'	1 영타임즈 구독				fnc_bitCampare(g_rs_myItemType, 1) = "1"
	'	2 영타임즈 스타터 구독		fnc_bitCampare(g_rs_myItemType, 2) = "1"
	'	4 온라인					fnc_bitCampare(g_rs_myItemType, 3) = "1"
	'ElseIf g_rs_mtypes = "2" Then ' 단체회원
	'	권한 시작
	'	1 영타임즈					fnc_bitCampare(g_rs_myItemType, 1) = "1"
	'	2 영타임즈 Q				fnc_bitCampare(g_rs_myItemType, 2) = "1"
	'	4 영타임즈 스타터			fnc_bitCampare(g_rs_myItemType, 3) = "1"

	'	1 , 2 영타임즈 Q, 4 영타임즈 스타터
	'End If

	fnc_getgrade = g_rs_myItemType
End Function

Function fnc_getgrade_breakOff(g_idnum)
'** 탈퇴할때는 구독보류 배려 안함
	Dim g_query, g_rs, g_rsGet
	Dim g_rs_mtypes, g_rs_p_idnum, g_rs_myItemType

	'return : @mtypes, @p_idnum, @myItemType
	g_query = "usp_jjw_myGrantInfo @idnum = '"& g_idnum &"'"
	Set g_rs = getRecordset(g_query, dsn_young)

	If g_rs.eof Or g_rs.bof Then
		g_rsGet = ""
	Else
		g_rsGet = g_rs.getrows
	End If
	g_rs.close
	Set g_rs = Nothing

	If IsArray(g_rsGet) Then
		g_rs_mtypes		= g_rsGet(0,0)
		g_rs_p_idnum	= g_rsGet(1,0)
		g_rs_myItemType	= g_rsGet(2,0)
	Else
		g_rs_mtypes		= 0
		g_rs_p_idnum	= 0
		g_rs_myItemType	= 0
	End If

	'If g_rs_mtypes = "1" Then ' 일반회원
	'	권한 시작
	'	1 영타임즈 구독				fnc_bitCampare(g_rs_myItemType, 1) = "1"
	'	2 영타임즈 스타터 구독		fnc_bitCampare(g_rs_myItemType, 2) = "1"
	'	4 온라인					fnc_bitCampare(g_rs_myItemType, 3) = "1"
	'ElseIf g_rs_mtypes = "2" Then ' 단체회원
	'	권한 시작
	'	1 영타임즈					fnc_bitCampare(g_rs_myItemType, 1) = "1"
	'	2 영타임즈 Q				fnc_bitCampare(g_rs_myItemType, 2) = "1"
	'	4 영타임즈 스타터			fnc_bitCampare(g_rs_myItemType, 3) = "1"

	'	1 , 2 영타임즈 Q, 4 영타임즈 스타터
	'End If

	fnc_getgrade = g_rs_myItemType
End Function

' ---------------------------------------------------------------------------
' 파일의 내용을 읽기
' ---------------------------------------------------------------------------
Function ReadFile(filename, encode)
	Dim objStream, fileCont

	Set objStream = Server.CreateObject("ADODB.Stream")
	objStream.Open
	objStream.Charset = encode 
	objStream.Type = 2
	objStream.LoadFromFile filename
	fileCont = objStream.ReadText
	objStream.Close
	Set objStream = Nothing

	ReadFile = fileCont
End Function

'Request로 받은값 처리시 비었을때 기본값 지정
'ex)			PageRowCnt = BlankThen(Request("PageRowCnt"),"15")
Function BlankThen(Str, ReturnValue)
	If isnull(Str) or len(trim(Str)) = 0 then
		BlankThen	= ReturnValue
	Else
		BlankThen = Str
	End If 
End Function 

' 날짜중에 한자리 일 경우 앞에 0 붙임
Function DatePZeroCheckWord(CheckValue)
	CheckValue = CStr(CheckValue)		'문자열로 변경. 작동안하는 경우가 가끔 있어서..2006-12-06 김희진
	If Len(CheckValue) = 1 Then
		CheckValue= "0" +CheckValue
		DatePZeroCheckWord = CheckValue
	Else
		DatePZeroCheckWord = CheckValue
	End If
End Function

	'날짜 형식에 맞춰서...   2012년 7월 11일 (수)
Function MakeDateIU(DateStr)
	If IsDate(DateStr) Then
		MakeDateIU = Right(Year(DateStr),4)&"년 " & Month(DateStr)&"월 "&Day(DateStr) & "일 " & "[" & left(WeekdayName(weekday(DateStr)),1)&"]"
	Else
		MakeDateIU = ""	'날짜가 아니면 빈값 반환
	End if
End Function

	'날짜 형식에 맞춰서...   2012년 7월 11일
Function MakeDateKARA(DateStr)
	If IsDate(DateStr) Then
		MakeDateKARA = Right(Year(DateStr),4)&"년 " & Month(DateStr)&"월 "&Day(DateStr) & "일 " 
	Else
		MakeDateKARA = ""	'날짜가 아니면 빈값 반환
	End if
End Function

Function fnc_TrimStr(str, strlen)

	dim rValue,TrimStr_i
	dim nLength, tmpStr, tmpLen
	nLength = 0.00
	rValue = ""
	for TrimStr_i = 1 to len(str)
		tmpStr = MID(str,TrimStr_i,1)
		tmpLen = ASC(tmpStr)
		if (tmpLen < 0) then
			nLength = nLength + 1.4 '한글일때 길이값 설정
			rValue = rValue & tmpStr
		elseif (tmpLen >= 97 and tmpLen <= 122) then
			nLength = nLength + 0.85 '영문소문자 길이값 설정
			rValue = rValue & tmpStr
		elseif (tmpLen >= 65 and tmpLen <= 90) then
			nLength = nLength + 1 ' 영문대문자 길이값 설정
			rValue = rValue & tmpStr
		else
			nLength = nLength + 0.8 '특수문자 기호값...
			rValue = rValue & tmpStr
		end if

		If (nLength > strlen) then
			rValue = rValue & "..."
			exit for
		end if
	next

	fnc_TrimStr = rValue

End Function

'user agent체크하여, 모바일/웹브라우져구분 함수추가 add by bestsun 2014.01.06
Function fnc_isMobile()
	dim u, b, x_device
	set u=Request.ServerVariables("HTTP_USER_AGENT")
	set b=new RegExp

	b.Pattern="android|iemobile|ip(hone|od|ad)|windows (ce|phone)"
	b.IgnoreCase=true
	b.Global=True
	
	if b.test(u) Then
		fnc_isMobile = True
	Else 
		fnc_isMobile = False 
	End If 
End Function 

'다음에디터 생성
Function MakeEditor(iframeid, textareaId, contents)
	%>
	<div id="<%=textareaId%>_subeditor" name="<%=textareaId%>_subeditor" style="display:none" style="width:0px;height:0px;"><%=contents%></div>
	<textarea id="<%=textareaId%>" name="<%=textareaId%>" style="display:none"><%=contents%></textarea>
	<iframe id="<%=iframeid%>" name="<%=iframeid%>" src="/inc/DaumEditor/editor.html?tid=<%=textareaId%>&_ver=<%=Left(date,7)%>" width="100%" height="500" marginwidth="0" marginheight="0" frameborder="no"></iframe>
	<%
End Function
'다음에디터 사이즈조절
Function MakeEditor_S(iframeid, textareaId, contents)
	%>
	<div id="<%=textareaId%>_subeditor" name="<%=textareaId%>_subeditor" style="display:none" style="width:0px;height:0px;"><%=contents%></div>
	<textarea id="<%=textareaId%>" name="<%=textareaId%>" style="display:none"><%=contents%></textarea>
	<iframe id="<%=iframeid%>" name="<%=iframeid%>" src="/inc/DaumEditor/editor.html?tid=<%=textareaId%>&_ver=<%=Left(date,7)%>" width="100%" height="300" marginwidth="0" marginheight="0" frameborder="no"></iframe>
	<%
End Function


'--------------------------------------------------------------------------------------------
' 전사 개인정보 조회 로그기록 저장 추가 
' add by bestsun 2015.01.16
'--------------------------------------------------------------------------------------------
Function  fn_privacy_reg(domainUrl , user_id , user_name , userIp , contents )
	
	Dim dsn_privacy
	dsn_privacy = "Provider=SQLOLEDB;Data Source=211.43.209.5; Initial Catalog=KY_PRIVACY; User ID=dbUserPrivacy; Password=12ycavirpresubd!@;"
 
	Dim db_privacy: set db_privacy = server.createobject("adodb.connection")
	db_privacy.open dsn_privacy
	
	Dim sql
	sql = "insert  tblPivacyProcessResult ( domainUrl , peopleInfo1 , peopleInfo2, remoteip , conndate , contents ) "
	sql = sql & " values ('"& domainUrl &"' , '" & user_id &"'  , '" & user_name &"' , '" & userIp &"' , getdate() , '" & contents &"'  ) "
	
	db_privacy.Execute(sql)

	db_privacy.close
	Set db_privacy = Nothing
	
End Function  




'--------------------------------------------------------------------------------------------
' 키즈몰 구독기간
' add by hyunjeong 2016.08.24
'--------------------------------------------------------------------------------------------
Function fnc_ChangeTxt(mm)
	fnc_ChangeTxt = year(mm) & "년 " & month(mm) & "월"	
End Function

Function fnc_getTerm(period, flag)
	today = Date()

	'If day(today) > 19 Then	'20일부터 다음단계
	'	start_month = dateadd("m",+1,today)
	'Else
		start_month = today
	'End If
	
	If period <> 0 Then
		term = CInt(period) - 1
		end_month = dateadd("m",+term,start_month)

		If flag = "new" Then
			fnc_getTerm = fnc_ChangeTxt(start_month) & " ~ " & fnc_ChangeTxt(end_month)
		ElseIf flag = "ori" Then
			fnc_getTerm = start_month & " ~ " & end_month
		End If
	End If
End Function

Function fnc_changeTerm(period)

End Function


'--------------------------------------------------------------------------------------------
' 키즈몰 호수
' add by hyunjeong 2016.09.21
' 3월 : 1호 ~ 2월 : 12호
'--------------------------------------------------------------------------------------------
Function fnc_getHosu(rs_monthly_idx)
	new_date = CDate(rs_monthly_idx)

'	If day(new_date) > 19 Then	'20일부터 다음단계
'		this_month = dateadd("m",+1,new_date)
'	Else
		this_month = new_date
'	End If

	new_month = dateadd("m",-2,this_month)	'해당 월-2달 = 해당 호수

	new_month = mid(new_month, 6, 2)		'월만 가져오기

	If Left(new_month, 1) = 0 Then
		Hosu = Right(new_month, 1)
	Else
		Hosu = new_month
	End If

	fnc_getHosu = Hosu
End Function


'--------------------------------------------------------------------------------------------
' 키즈몰 호수에 맞는 해당 월 가져오기
' add by hyunjeong 2016.10.18
'--------------------------------------------------------------------------------------------
Function fnc_getMonth(hosu)
	mm = 0
	mm = CInt(hosu) + 2

	If mm > 12 Then
		mm = mm - 12
	End If

	fnc_getMonth = mm
End Function


'--------------------------------------------------------------------------------------------
' 키즈몰 결제 관련 함수
' add by hyunjeong 2016.08.31
'--------------------------------------------------------------------------------------------
Function strPur_status(tmp_Pur_status)
	Select Case tmp_Pur_status
		Case "0" : strPur_status = "결제전"
		Case "1" : strPur_status = "입금확인중"
		Case "4" : strPur_status = "입금전취소"
		Case "9" : strPur_status = "결제완료"
		Case Else : strPur_status = "전체"
	End Select
End Function

Function strPM(tmp_pm_code)
	Select Case tmp_pm_code
		Case "1" : strPm = "신용카드"
		Case "2" : strPm = "무통장입금"
		Case "3" : strPm = "계좌이체"
		Case "4" : strPm = "핸드폰결제"
		Case "10" : strPm = "KVP"
	End Select
End Function

Function fnc_pm_code(fn_pm_code)
	select case fn_pm_code
		case "1"
			fnc_pm_code = "신용카드"
		case "2"
			fnc_pm_code = "무통장 입금"
		case "3"
			fnc_pm_code = "실시간 계좌이체"
		case "4"
			fnc_pm_code = "핸드폰결제"
	end Select
End Function

Function strPS(tmp_pur_status, tmp_payback_status , tmp_refund_price)
	Select Case tmp_pur_status
		Case "0" : strPS = "결제전"
		Case "1" : strPS = "입금확인중"
		Case "4" : strPS = "입금전취소"
		Case "9" :
			strPS = "<font color=""blue"">결제완료</font>"

			If tmp_payback_status = "1" Then
				strPS = strPS & "</br><font color='red'>결제취소(전체)</font>"
			ElseIf tmp_refund_price > 0 Then
				strPS = strPS & "</br><font color='green'>결제취소(부분)</font>"
			End if
	End Select
End Function

Function strPS_Front(tmp_pur_status, tmp_payback_status , tmp_refund_price)
	Select Case tmp_pur_status
		Case "0" : strPS_Front = "결제전"
		Case "1" : strPS_Front = "입금확인중"
		Case "4" : strPS_Front = "입금전취소"
		Case "9" :
			If tmp_payback_status = "1" Then
				strPS_Front = "결제취소(전체)"
			ElseIf tmp_refund_price > 0 Then
				strPS_Front = "결제취소(부분)"
			Else
				strPS_Front = "<span class=""org_txt"">결제완료</span>"
			End if
	End Select
End Function


Function fnc_vcdbank(num)
	Select Case Right("00" & num , 3)
		Case "002" : fnc_vcdbank = "산업은행"
		Case "003" : fnc_vcdbank = "기업은행"
		Case "005" : fnc_vcdbank = "외환은행"
		Case "004" : fnc_vcdbank = "국민은행"
		Case "006" : fnc_vcdbank = "국민은행"
		Case "007" : fnc_vcdbank = "수협은행"
		Case "011" : fnc_vcdbank = "농협은행"
		Case "020" : fnc_vcdbank = "우리은행"
		Case "023" : fnc_vcdbank = "SC제일은행"
		Case "027" : fnc_vcdbank = "한국씨티은행"
		Case "031" : fnc_vcdbank = "대구은행"
		Case "032" : fnc_vcdbank = "부산은행"
		Case "034" : fnc_vcdbank = "광주은행"
		Case "035" : fnc_vcdbank = "제주은행"
		Case "037" : fnc_vcdbank = "전북은행"
		Case "039" : fnc_vcdbank = "경남은행"
		Case "045" : fnc_vcdbank = "새마을금고"
		Case "048" : fnc_vcdbank = "신협"
		Case "071" : fnc_vcdbank = "우체국"
		Case "081" : fnc_vcdbank = "하나은행"
		Case "088" : fnc_vcdbank = "신한은행"
		Case "026" : fnc_vcdbank = "신한은행"
		Case "209" : fnc_vcdbank = "동양증권"
		Case "230" : fnc_vcdbank = "미래에셋"
		Case "278" : fnc_vcdbank = "신한금융투자"
		Case "240" : fnc_vcdbank = "삼성증권"
		Case "243" : fnc_vcdbank = "한국투자증권"
		Case "269" : fnc_vcdbank = "한화증권"
	End select
End Function

Function fnc_lastfilename(fileUrl)
	fnc_lastfilename = Mid(fileUrl, InStrRev(fileUrl, "/") + 1)
End Function


'--------------------------------------------------------------------------------------------
'카드전표출력
'--------------------------------------------------------------------------------------------
Function fnc_receipt_real(fn_tid, fn_pm_code, fn_pur_status, fn_payback_status)

	If gv_lg_purchase_type = "test" Then
		fn_LGD_MID = "t" & gv_lg_purchase_id
	Else
		fn_LGD_MID = gv_lg_purchase_id
	End if

	fn_LGD_MERTKEY = gv_lg_purchase_key

	'response.write gv_lg_purchase_type
	

	If fn_pur_status = "9" And Trim(fn_payback_status) = "" Then
		Select Case fn_pm_code
			Case 1 : fnc_receipt_real = "<a id=""btn_excel"" class=""btnOrange btnSmall"" onclick=""javascript:showReceiptByTID('" & fn_LGD_MID & "','" & fn_tid & "','" & LGU_MD5(fn_LGD_MID & fn_tid & fn_LGD_MERTKEY) & "')""> 카드전표 출력</a>"
			Case 2 : fnc_receipt_real = "<a id=""btn_excel"" class=""btnOrange btnSmall"" onclick=""javascript:showReceiptByTID('" & fn_LGD_MID & "','" & fn_tid & "','" & LGU_MD5(fn_LGD_MID & fn_tid & fn_LGD_MERTKEY) & "')""> 거래내역 확인서</a>" 
			Case 3 : fnc_receipt_real = "<a id=""btn_excel"" class=""btnOrange btnSmall"" onclick=""javascript:showReceiptByTID('" & fn_LGD_MID & "','" & fn_tid & "','" & LGU_MD5(fn_LGD_MID & fn_tid & fn_LGD_MERTKEY) & "')""> 거래내역 확인서</a>"
		End Select
		
	Else
		fnc_receipt_real = ""
	End If
	

End Function


'--------------------------------------------------------------------------------------------
'카드전표출력
'--------------------------------------------------------------------------------------------
Function fnc_receipt_real_front(fn_tid, fn_pm_code, fn_pur_status, fn_payback_status)

	If gv_lg_purchase_type = "test" Then
		fn_LGD_MID = "t" & gv_lg_purchase_id
	Else
		fn_LGD_MID = gv_lg_purchase_id
	End if

	fn_LGD_MERTKEY = gv_lg_purchase_key

	'response.write gv_lg_purchase_type
	

	If fn_pur_status = "9" And Trim(fn_payback_status) = "" Then
		Select Case fn_pm_code
			Case 1 : fnc_receipt_real_front = "<a href=""javascript://"" class=""btn_receipt"" onclick=""javascript:showReceiptByTID('" & fn_LGD_MID & "','" & fn_tid & "','" & LGU_MD5(fn_LGD_MID & fn_tid & fn_LGD_MERTKEY) & "')""> 카드전표 출력</a>"
			Case 2 : fnc_receipt_real_front = "<a href=""javascript://"" class=""btn_receipt"" onclick=""javascript:showReceiptByTID('" & fn_LGD_MID & "','" & fn_tid & "','" & LGU_MD5(fn_LGD_MID & fn_tid & fn_LGD_MERTKEY) & "')""> 거래내역 확인서</a>" 
			Case 3 : fnc_receipt_real_front = "<a href=""javascript://"" class=""btn_receipt"" onclick=""javascript:showReceiptByTID('" & fn_LGD_MID & "','" & fn_tid & "','" & LGU_MD5(fn_LGD_MID & fn_tid & fn_LGD_MERTKEY) & "')""> 거래내역 확인서</a>"
		End Select
		
	Else
		fnc_receipt_real_front = ""
	End If
	

End Function

Function strSendflag(tmp_sendflag)
	Select Case tmp_sendflag
		Case "0" : strSendflag = "배송완료"
		Case "1" : strSendflag = "배송중"
		Case "3" : strSendflag = "일시정지"
		Case "4" : strSendflag = "구독취소"
		Case Else : strSendflag = "상품준비중"
	End Select
End Function 


Function getOneWayEncrypt(pStr, pLevel)
	Dim obj, salt

	'레벨이 1이면 SHA256 으로 암호화

	if pLevel = 1 Then
		salt = "!*@^$#@"
		set obj = new Encrypt_SHA256
		
		getOneWayEncrypt = obj.SHA256(pStr & salt)
		
		set obj = nothing
	Else
		salt = "!*@^$#@"
		set obj = new Encrypt_SHA256

		getOneWayEncrypt = obj.SHA256(pStr & salt)
		
		set obj = nothing
	End if

End Function

Function fnc_tblcomcd_CategoryNm(schKnd)
	query = "exec [usp_set_tblcomcd_view]		@ccCd		=  '" & schKnd & "'"
	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then 
		rsCategory		= ""
	Else
		rsCategory		= rs.getrows
	End If
	rs.close
	Set rs = Nothing

	If IsArray(rsCategory) Then
		rs_codeNm				= rsCategory(1,0)
	End If

	fnc_tblcomcd_CategoryNm = rs_codeNm
End Function

Function fnc_getMinutes(dt1)
	dt2 = "1900-01-01"

	If (isDate(dt1) And IsDate(dt2)) = false Then 
		TimeSpan = "00:00:00" 
		Exit Function 
	End If 

	seconds = Abs(DateDiff("S", dt1, dt2)) 
	minutes = seconds \ 60 
	hours = minutes \ 60 
	minutes = minutes mod 60 
	seconds = seconds mod 60 

	If CStr(hours) = "0" Then
		fnc_getMinutes = minutes & "분 " & seconds & "초"
	Else
		fnc_getMinutes = hours & "시간 " & minutes & "분 " & seconds & "초"
	End If
End Function

'Function fnc_getMinutes(dt1)
'  w dt1 & "<Br>"
'   studytime = FormatDateTime(CDate(dt1),2) & ":" & Right(dt1,2) & "<br>"
'	minutes = seconds \ 60 
'	hours = minutes \ 60 
'	minutes = minutes mod 60 
'	seconds = seconds mod 60 
'
'	If CStr(hours) = "0" Then
'		fnc_getMinutes = minutes & "분 " & seconds & "초"
'	Else
'		fnc_getMinutes = hours & "시간 " & minutes & "분 " & seconds & "초"
'	End If
'
'    fnc_getMinutes = "24:00:00"
'End Function

Function fnc_getAVGMinutes(dt1, modValue1, modValue2)
	If CStr(modValue1) = "0" Then
		fnc_getAVGMinutes = "0분 0초"
		Exit Function
	End If

	If CStr(modValue2) = "0" Then
		fnc_getAVGMinutes = "0분 0초"
		Exit Function
	End if

	dt2 = "1900-01-01"

	If (isDate(dt1) And IsDate(dt2)) = false Then 
		TimeSpan = "00:00:00" 
		Exit Function 
	End If 

	seconds = Abs(DateDiff("S", dt1, dt2))

	seconds = seconds \ CInt(modValue1) \ CInt(modValue2)	'수업일수, 가입원생로 나눔

	minutes = seconds \ 60 
	hours = minutes \ 60 
	minutes = minutes mod 60 
	seconds = seconds mod 60

	
	If CStr(hours) = "0" Then
		fnc_getAVGMinutes = minutes & "분 " & seconds & "초"
	Else
		fnc_getAVGMinutes = hours & "시간 " & minutes & "분 " & seconds & "초"
	End If

End Function

Function fnc_getAVGMinutes_2(dt1, modValue1)
	If CStr(modValue1) = "0" Then
		fnc_getAVGMinutes_2 = "0분 0초"
		Exit Function
	End If

	dt2 = "1900-01-01"

	If (isDate(dt1) And IsDate(dt2)) = false Then 
		TimeSpan = "00:00:00" 
		Exit Function 
	End If 

	seconds = Abs(DateDiff("S", dt1, dt2))
	seconds = seconds \ CInt(modValue1) 	'이미 수업일수 * 가입원생으로 데이터가 넘어오는 경우니 1개로만 나눔

	minutes = seconds \ 60 
	hours = minutes \ 60 
	minutes = minutes mod 60 
	seconds = seconds mod 60

	If CStr(hours) = "0" Then
		fnc_getAVGMinutes_2 = minutes & "분 " & seconds & "초"
	Else
		fnc_getAVGMinutes_2 = hours & "시간 " & minutes & "분 " & seconds & "초"
	End if


End Function

Function fnc_getEVbookinfo(level, ho_num)

	'tblEV_StudyBookInfo 에 있는 테이블의 키와 맞춰야 함.
	Select Case level
		Case "1"
			Select Case ho_num
				Case "1" : fnc_getEVbookinfo = 1
				Case "2" : fnc_getEVbookinfo = 2
				Case "3" : fnc_getEVbookinfo = 3
				Case "4" : fnc_getEVbookinfo = 4
				Case "5" : fnc_getEVbookinfo = 5
				Case "6" : fnc_getEVbookinfo = 6
				Case "7" : fnc_getEVbookinfo = 7
				Case "8" : fnc_getEVbookinfo = 8
				Case "9" : fnc_getEVbookinfo = 9
				Case "10" : fnc_getEVbookinfo = 10
			End select
		Case "2"
			Select Case ho_num
				Case "1" : fnc_getEVbookinfo = 11
				Case "2" : fnc_getEVbookinfo = 12
				Case "3" : fnc_getEVbookinfo = 13
				Case "4" : fnc_getEVbookinfo = 14
				Case "5" : fnc_getEVbookinfo = 15
				Case "6" : fnc_getEVbookinfo = 16
				Case "7" : fnc_getEVbookinfo = 17
				Case "8" : fnc_getEVbookinfo = 18
				Case "9" : fnc_getEVbookinfo = 19
				Case "10" : fnc_getEVbookinfo = 20
			End Select
		Case "3"
			Select Case ho_num
				Case "1" : fnc_getEVbookinfo = 21
				Case "2" : fnc_getEVbookinfo = 22
				Case "3" : fnc_getEVbookinfo = 23
				Case "4" : fnc_getEVbookinfo = 24
				Case "5" : fnc_getEVbookinfo = 25
				Case "6" : fnc_getEVbookinfo = 26
				Case "7" : fnc_getEVbookinfo = 27
				Case "8" : fnc_getEVbookinfo = 28
				Case "9" : fnc_getEVbookinfo = 29
				Case "10" : fnc_getEVbookinfo = 30
			End Select
		Case "4"
			Select Case ho_num
				Case "1" : fnc_getEVbookinfo = 31
				Case "2" : fnc_getEVbookinfo = 32
				Case "3" : fnc_getEVbookinfo = 33
				Case "4" : fnc_getEVbookinfo = 34
				Case "5" : fnc_getEVbookinfo = 35
				Case "6" : fnc_getEVbookinfo = 36
				Case "7" : fnc_getEVbookinfo = 37
				Case "8" : fnc_getEVbookinfo = 38
				Case "9" : fnc_getEVbookinfo = 39
				Case "10" : fnc_getEVbookinfo = 40
			End select
	End Select

End Function

Function fnc_js_val_make (fn_txt, fn_flag)

	If CStr(fn_flag) = "1" Then
		Select Case fn_txt
			Case "Rhyme Song" : fnc_js_val_make = "TMPX1"
			Case "애니메이션" : fnc_js_val_make = "TMPX2"
			Case "문장챈트" : fnc_js_val_make = "TMPX3"
			Case "파닉스챈트" : fnc_js_val_make = "TMPX4"
			Case "스토리송" : fnc_js_val_make = "TMPX5"
			Case "단어챈트" : fnc_js_val_make = "TMPX6"
			Case "수업영상" : fnc_js_val_make = "TMPX7"
			Case "리뷰" : fnc_js_val_make = "TMPX8"
			Case Else : fnc_js_val_make = fn_txt
		End select
	elseIf CStr(fn_flag) = "2" Then
		Select Case fn_txt
			Case "TMPX1" : fnc_js_val_make = "Rhyme Song"
			Case "TMPX2" : fnc_js_val_make = "애니메이션"
			Case "TMPX3" : fnc_js_val_make = "문장챈트"
			Case "TMPX4" : fnc_js_val_make = "파닉스챈트"
			Case "TMPX5" : fnc_js_val_make = "스토리송"
			Case "TMPX6" : fnc_js_val_make = "단어챈트"
			Case "TMPX7" : fnc_js_val_make = "수업영상"
			Case "TMPX8" : fnc_js_val_make = "리뷰"
			Case Else : fnc_js_val_make = fn_txt
		End select
	End if

End Function

Function getTimeStringSeconds(seconds) 

	Dim hourTxt, minTxt, secTxt 

	If seconds > 0 Then 	

		If fix(seconds / 3600) > 0 Then 

			hourTxt = fix(seconds / 3600) 

			If Len(hourTxt) = 1 Then
                hourTxt = "0" & hourTxt
            End if
		End If 

		If fix((seconds MOD 3600) / 60) > 0 Then 

			minTxt = fix(((seconds) MOD 3600) / 60)
			If Len(minTxt) = 1 Then 
                minTxt = "0" & minTxt 
            End if
		Else 
			minTxt = "0"

		End If 

		If fix(seconds MOD 60) > 0 Then 

			secTxt = (seconds MOD 60)
			If Len(secTxt) = 1 Then
                secTxt = "0" & secTxt
            End if
		Else 

			secTxt = "0"

		End If 

	End If 
    
    If hourTxt = "" Then
        getTimeStringSeconds = minTxt & "분 " & secTxt & "초"
    Else 
        getTimeStringSeconds = hourTxt & "시간 " & minTxt & "분 " & secTxt & "초"
    End If 
	

End Function
%>
<!--#include file="SqlInjection_check.asp"--> 
<!--#include file="aes.asp"-->
