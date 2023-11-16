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
<script type="text/javascript" src="/inc/js/validate.js?_v=10119"></script>

<!-- #include virtual = "/_pages/inc/layout/first.asp" -->
<!-- #include virtual = "/_pages/inc/layout/auth_check.asp" -->
<!-- #include virtual="/_lib/global/func.asp" -->
<!-- #include virtual="/_lib/dsn/dsn.asp" -->
<!-- #include virtual="/_lib/global/ado.asp" -->
<!-- #include virtual="/inc/domain/bbsfunc.asp" -->
<!-- #include virtual="/inc/domain/globalheader.asp" --><%'DOCTYPE, HTML 포함%>
<%
	L_MENU = "0"
	M_MENU = "1"
	S_MENU = "1"
%>
<%
	
	Dim inspUserId : inspUserId = ckstr(r("inspUserId"),1)
	Dim inspChkCd : inspChkCd = ckstr(r("inspChkCd"),1)
	
	Dim sslPort 
	If request.servervariables("LOCAL_ADDR") = "61.32.254.47" Then
		sslPort = ""
	Else
		sslPort = ""
	End If

	query = "[usp_cjj_tbl_inspc_C05_result_list]	@inspUserId		= '" & inspUserId & "'," &_
							"@inspChkCd		= '" & inspChkCd & "'," &_
							"@resultType		= '" & "indv" & "'"

	Set rs = getrecordset(query, dsn_nekids)
	If rs.eof Or rs.bof Then
		rsGet = ""
		response.write "<script language='javascript'>"
		response.write "alert('검사결과가 나오지 않았습니다.');"
		response.write "close();"
		response.write "</script>"
	Else
		rsGet = rs.getrows()
	End If
	rs.close
	Set rs = Nothing


%>
<% 
	If IsArray(rsGet) Then
		For i = 0 To UBound(rsGet, 2)
			inspChkCd	   = rsGet(1,0)
			inspUserId	   = rsGet(2,0)
			classNm		   = rsGet(3,0)
			childClassNm   = rsGet(4,0)
			childMbrSex	   = rsGet(5,0)
			childMbrNm	   = rsGet(6,0)
			childMbrBrtdy  = rsGet(7,0)
			rgstYmd		   = rsGet(8,0)
			
			type_t_score_1_1 = rsGet(9,0) '언어 T점수 선호
			type_t_score_1_2 = rsGet(10,0) '언어 T점수 능력
			type_t_score_1_3 = rsGet(11,0) '언어 T점수 전체
			type_t_score_2_1 = rsGet(12,0) '논리수학 T점수 선호
			type_t_score_2_2 = rsGet(13,0) '논리수학 T점수 능력
			type_t_score_2_3 = rsGet(14,0) '논리수학 T점수 전체
			type_t_score_3_1 = rsGet(15,0) '시공간 T점수 선호
			type_t_score_3_2 = rsGet(16,0) '시공간 T점수 능력
			type_t_score_3_3 = rsGet(17,0) '시공간 T점수 전체
			type_t_score_4_1 = rsGet(18,0) '음악 T점수 선호
			type_t_score_4_2 = rsGet(19,0) '음악 T점수 능력
			type_t_score_4_3 = rsGet(20,0) '음악 T점수 전체
			type_t_score_5_1 = rsGet(21,0) '신체운동 T점수 선호
			type_t_score_5_2 = rsGet(22,0) '신체운동 T점수 능력
			type_t_score_5_3 = rsGet(23,0) '신체운동 T점수 전체
			type_t_score_6_1 = rsGet(24,0) '대인관계 T점수 선호
			type_t_score_6_2 = rsGet(25,0) '대인관계 T점수 능력
			type_t_score_6_3 = rsGet(26,0) '대인관계 T점수 전체
			type_t_score_7_1 = rsGet(27,0) '자기성찰 T점수 선호
			type_t_score_7_2 = rsGet(28,0) '자기성찰 T점수 능력
			type_t_score_7_3 = rsGet(29,0) '자기성찰 T점수 전체
			type_t_score_8_1 = rsGet(30,0) '자연탐구 T점수 선호
			type_t_score_8_2 = rsGet(31,0) '자연탐구 T점수 능력
			type_t_score_8_3 = rsGet(32,0) '자연탐구 T점수 전체

			type_t_score_9_1 = rsGet(33,0) '언어 백분위 점수 선호
			type_t_score_9_2 = rsGet(34,0) '언어 백분위 점수 능력
			type_t_score_9_3 = rsGet(35,0) '언어 백분위 점수 전체
			type_t_score_10_1 = rsGet(36,0) '논리수학 백분위 점수 선호
			type_t_score_10_2 = rsGet(37,0)	'논리수학 백분위 점수 능력	
			type_t_score_10_3 = rsGet(38,0) '논리수학 백분위 점수 전체
			type_t_score_11_1 = rsGet(39,0) '시공간 백분위 점수 선호
			type_t_score_11_2 = rsGet(40,0) '시공간 백분위 점수 능력
			type_t_score_11_3 = rsGet(41,0) '시공간 백분위 점수 전체
			type_t_score_12_1 = rsGet(42,0) '음악 백분위 점수 선호
			type_t_score_12_2 = rsGet(43,0) '음악 백분위 점수 능력
			type_t_score_12_3 = rsGet(44,0) '음악 백분위 점수 전체
			type_t_score_13_1 = rsGet(45,0) '신체운동 백분위 점수 선호
			type_t_score_13_2 = rsGet(46,0) '신체운동 백분위 점수 능력
			type_t_score_13_3 = rsGet(47,0) '신체운동 백분위 점수 전체
			type_t_score_14_1 = rsGet(48,0) '대인관계 백분위 점수 선호
			type_t_score_14_2 = rsGet(49,0) '대인관계 백분위 점수 능력
			type_t_score_14_3 = rsGet(50,0) '대인관계 백분위 점수 전체
			type_t_score_15_1 = rsGet(51,0) '자기성찰 백분위 점수 선호
			type_t_score_15_2 = rsGet(52,0) '자기성찰 백분위 점수 능력
			type_t_score_15_3 = rsGet(53,0) '자기성찰 백분위 점수 전체
			type_t_score_16_1 = rsGet(54,0) '자연탐구 백분위 점수 선호
			type_t_score_16_2 = rsGet(55,0) '자연탐구 백분위 점수 능력
			type_t_score_16_3 = rsGet(56,0) '자연탐구 백분위 점수 전체
	
			type_f_score_1_1 = rsGet(57,0) '선호순위 1순위
			type_f_score_1_2 = rsGet(58,0) '선호순위 2순위
			type_f_score_2_1 = rsGet(59,0) '능력순위 1순위
			type_f_score_2_2 = rsGet(60,0) '능력순위 2순위

			type_total_score_1 = rsGet(61,0) '전체순위 1순위
			type_total_score_2 = rsGet(62,0) '전체순위 2순위
			type_total_score_3 = rsGet(63,0) '전체순위 7순위
			type_total_score_4 = rsGet(64,0) '전체순위 8순위

			type_trans_1 = rsGet(65,0) '언어_해석
			type_trans_2 = rsGet(66,0) '논리수학_해석
			type_trans_3 = rsGet(67,0) '시공간_해석
			type_trans_4 = rsGet(68,0) '음악_해석
			type_trans_5 = rsGet(69,0) '신체운동_해석
			type_trans_6 = rsGet(70,0) '대인관계_해석
			type_trans_7 = rsGet(71,0) '자기성찰_해석
			type_trans_8 = rsGet(72,0) '자연_해석
			type_plan_1  = rsGet(73,0) '총평

            type_level_1_1 = rsGet(74,0) '언어_수준
            type_level_2_1 = rsGet(75,0) '논리수학_수준
            type_level_3_1 = rsGet(76,0) '시공간_수준
            type_level_4_1 = rsGet(77,0) '음악_수준
            type_level_5_1 = rsGet(78,0) '신체운동_수준
            type_level_6_1 = rsGet(79,0) '대인관계_수준
            type_level_7_1 = rsGet(80,0) '자기성찰_수준
            type_level_8_1 = rsGet(81,0) '자연_수준

            type_t_score_1_1_1 = rsGet(82,0) '언어편차t점수
            type_t_score_2_1_1 = rsGet(83,0) '논리수학편차t점수
            type_t_score_3_1_1 = rsGet(84,0) '시공간편차t점수
            type_t_score_4_1_1 = rsGet(85,0) '음악편차t점수
            type_t_score_5_1_1 = rsGet(86,0) '신체운동편차t점수
            type_t_score_6_1_1 = rsGet(87,0) '대인간편차t점수
            type_t_score_7_1_1 = rsGet(88,0) '자기성찰편차t점수
            type_t_score_8_1_1 = rsGet(89,0) '자연친화편차t점수



		
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- #include virtual = "/_pages/inc/layout/head.asp" -->
<style>
.standardArea .rstbx.kids05 td .text{
    font-size: 14px;
}


.standardArea .rstbx .scon01 table td{}
.standardArea .rstbx .scon01 table td div{height:15px;padding:5px 0}
.standardArea .rstbx .scon01 table td .per{
	font-size: 13px;
}


</style>
</head>
<body scroll=auto>
<div id="wrapper">
	<!-- #include virtual = "/_pages/inc/layout/header.asp" -->
	<!-- visualArea -->
	<div class="visualArea visualA">
		<div class="visualCont visualAbg">
			<h2>유아 발달 표준화 검사 </h2>
			<!-- #include virtual = "/_pages/inc/layout/location.asp" -->
		</div><!-- //visualCont -->
	</div><!-- //visualArea -->
	<!-- container -->
	<div id="container">
		<!-- contArea -->
		<div id="contArea">
				<!-- titleArea -->
			<div class="titleArea titleIconN1">
				<h3>유아 발달 표준화 검사</h3>
				<b>유아 표준화 검사로 우리아이의 특성을 파악해 보세요. </b>
			</div><!-- //titleArea -->

				<ul class="tabTypeD std">
					<li ><a href="./index.asp"><span>유아 발달<br />표준화 검사란?</span></a></li>
					<li><a href="./exam01.asp"><span>검사하기</span></a></li>
					<li class="on"><a href="#"><span>검사결과</span></a></li>
				</ul>

			<!-- standardArea -->
			<div class="standardArea">
				<div class="rstbx kids05">
					<div class="cont01">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_01.jpg" alt="유아다중지능검사" />
						<dl class="ir">
							<dt>소개 및 활용</dt>
							<dd>본 검사를 통하여 유아의 지능을 객관적으로 측정함으로써 유아의 지적 능력에서의 특성을 올바르게 이해하고 부모와 교사가 유아의 양육과 교육에 필요한 유용한 정보를 얻을 수 있습니다.</dd>
						</dl>
						<dl class="ir">
							<dt>검사특징</dt>
							<dd>현대 지능이론 중 새로이 주목을 받고 있는 다중지능이론을 토대로 유아의 지능을 8개 유형으로 나누어 측정합니다.</dd>
							<dd>기존의 다중지능검사들은 유아의 능력 수준만을 측정함으로써 향후 유아의 성장 가능성을 예측할 수 없다는 문제점을 가지고 잇는 반면, 본 검사는 유아의 현재 능력 수준 뿐만 아니라 선호를 함께 측정함 으로써 유아의 향후 발달 수준을 정확하게 예측할 수 있습니다.</dd>
							<dd>개인간 발달 수준을 비교한 정보가 제공되어 유아의 발달 수준이 다른 아동들과 비교하여 어느 정도 수준인지에 대해 객관적 정보를 얻을 수 있습니다.</dd>
						</dl>
					</div>

					<div class="cont02 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_02.jpg" alt="유아다중지능검사 척도" />
						<table class="ir">
							<caption>유아성격검사 요인 테이블</caption>
							<thead>
								<tr>
									<th scope="col">척도</th>
									<th scope="col">설명</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">언어지능</th>
									<td>단어, 어휘의 의미와 소리에 대해 민감하여, 언어의 구조 및 언어가 사용될 수 잇는 다양한 방법을 잘 알고 사용할 수 있는 지능</td>
								</tr>
								<tr>
									<th scope="row">논리수학지능</th>
									<td>수와 같은 추상적인 상징체계를 조작하고 그들의 관계를 인식하며 논리적이고 체계적으로 아이디어를 잘 평가하는 지능</td>
								</tr>
								<tr>
									<th scope="row">시공간지능</th>
									<td>색, 모양, 대칭, 이미지 등 시각자극을 정확하게 지각하고, 그러한 시각자극들의 각도나 방향이 바뀌어도 정확하게 지각할 수 있으며 순서적 관계나 복잡한 위계적 관계를 시각화를 통해 이해하는 지능</td>
								</tr>
								<tr>
									<th scope="row">음악지능</th>
									<td>음의 높낮이 박자 속도 선율에 대해 민감하고, 음악을 만들고 분석하는 능력이 있으며 정서적인 측면을 잘 이해하는 지능</td>
								</tr>
								<tr>
									<th scope="row">신체운동지능</th>
									<td >자신을 표현하고 목적 달성을 하기 위해 몸을 기술적으로 잘 사용하며, 사물을 기술적으로 다루는데 민감한 지능</td>
								</tr>
								<tr>
									<th scope="row">대인간지능</th>
									<td >타인의 기분이나 기질, 동기, 의도 등을 잘 알아차리고 이에 대해 적절하고 민감하게 반응하는 지능</td>
								</tr>
								<tr>
									<th scope="row">자기성찰지능</th>
									<td >자신의 내부상태에 대해 민감하며, 자신의 강약점, 욕구를 파악하고, 자신에 대한 정보를 적절하게 사용하여 적응적으로 행동하는 데 민감한 지능</td>
								</tr>
								<tr>
									<th scope="row">자연친화지능</th>
									<td >자연물, 동식물에 관심을 가지고 잘돌보거나 자연현상을 잘 이해하고, 자연을 보존하는데 관심이 있는 지능</td>
								</tr>
							</tbody>
						</table>
					</div>

					<div class="cont02 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_03.jpg" alt="검사해석시 참고사항" />
						<div class="ir">
							<em>검사 해석시 참고사항</em>
							<dl>
								<dt>해석기준</dt>
								<dd>
									<table>
											<caption>해석기준 테이블</caption>
											<thead>
												<tr>
													<th scope="col">평가</th>
													<th scope="col">매우낮음</th>
													<th scope="col">낮음</th>
													<th scope="col">보통</th>
													<th scope="col">높음</th>
													<th scope="col">매우높음</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<th scope="row">T점수</th>
													<td>29이하</td>
													<td>30~39</td>
													<td>40~59</td>
													<td>60~69</td>
													<td>70점 이상</td>
												</tr>
												<tr>
													<th scope="row">백분위점수</th>
													<td>2이하</td>
													<td>3~18</td>
													<td>18~83</td>
													<td>84~96</td>
													<td>97이상</td>
												</tr>
											</tbody>
									</table>
								</dd>
								<dt>T점수</dt>
								<dd>원점수를 평균 50, 표준편차 10인 표준점수로 반환한 수치입니다. 원점수를 T점수로 변환함으로써 검사 점수 간의 비교가 용이합니다.</dd>
								<dt>백분위점수</dt>
								<dd>해당 원점수가 전체 유아 중 몇 %에 해당하는지를 나타냅니다. 예를 들어, 백분위 75%는 해당 유아가 받은 원점수 보다 더 낮은 점수를 받은 유아는 75%이며, 더 높은 점수를 받은 유아는 25%라는 것을 의미합니다.</dd>
							</dl>
						</div>
					</div>

					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_04.jpg" alt="다중지능검사 결과 프로파일" />
						<div class="cht_wrap1">
							<canvas class="rader_chart1"></canvas>
						</div>
						<div class="info info1">
							<span class="tx1"><%=childMbrNm%></span>
							<span class="tx2"><%=type_f_score_1_1%></span>
							<span class="tx3"><%=type_f_score_1_2%></span>
						</div>
						<div class="cht_wrap2">
							<canvas class="rader_chart2"></canvas>
						</div>
						<div class="info info2">
							<span class="tx1"><%=childMbrNm%></span>
							<span class="tx2"><%=type_f_score_2_1%></span>
							<span class="tx3"><%=type_f_score_2_2%></span>
						</div>
						<div class="cht_wrap3" >
							<canvas class="rader_chart3"></canvas>
						</div>
						<div class="info info3">
							<span class="tx1"><%=childMbrNm%></span>
							<span class="tx2"><%=type_total_score_1%></span>
							<span class="tx3"><%=type_total_score_2%></span>
						</div>
					</div><!-- //cont03  -->
		
					<!-- 언어 지능 -->
					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_05.jpg?v2" alt="우리 아이의 언어 지능에 대해 알아봅시다!" />
						<div class="scon01">
							<table style="width:787px;table-layout:fixed;">
									<caption>척도, T점수</caption>
									<colgroup>
										<col style="width:85px" />
										<col style="width:86px" />
										<col style="width:71px" />
										<col  />
										<col  />
										<col  />
										<col  />
										<col  />
										<col  />
									</colgroup>
									<thead class="ir">
										<tr>
											<th scope="col" colspan="9"><span class="ir">매우낮음, 낮음, 보통, 높음, 매우높음</span></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" rowspan="3" style="border-collapse: separate;">언어<br/>지능</th>
											<th scope="row">선호</th>
											<td><p class="per"><%=type_t_score_1_1%>(<%=type_t_score_9_1%>)</p></td>
											<td colspan="6" class="graph"><div style=""><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">능력</th>
											<td><p class="per"><%=type_t_score_1_2%>(<%=type_t_score_9_2%>)</p></td>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">전체</th>
											<td><p class="per"><%=type_t_score_1_3%>(<%=type_t_score_9_3%>)</p></td>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
									</tbody>
							</table>
						</div>

						<div class="scon02" style="top:563px">
							<table>
									<caption>결과해석</caption>
									<colgroup><col class="td5"><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col">수준</th>
											<th scope="col">결과해석</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="languageJ"></td>
											<td>
												<div class="text"><%=type_trans_1%></div>
											</td>
										</tr>
									</tbody>
							</table>
						</div>

					</div>
					<!-- //언어 지능  -->

					<!-- 논리수학지능 -->
					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_06.jpg?v2" alt="우리 아이의  논리수학지능 대해 알아봅시다!" />
						<div class="scon01" style="top:322px;left:108px">
							<table style="width:787px">
									<caption>척도, T점수</caption>
									<colgroup><col class="td3"><col class="td2"><col class="td4"><col /><col /><col /><col /><col /><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col" colspan="9"><span class="ir">매우낮음, 낮음, 보통, 높음, 매우높음</span></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" rowspan="3">논리<br/>수학<br />지능</th>
											<th scope="row">선호</th>
											<td><p class="per"><%=type_t_score_2_1%>(<%=type_t_score_10_1%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">능력</th>
											<td><p class="per"><%=type_t_score_2_2%>(<%=type_t_score_10_2%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">전체</th>
											<td><p class="per"><%=type_t_score_2_3%>(<%=type_t_score_10_3%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
									</tbody>
							</table>
						</div>

						<div class="scon02" style="top:575px">
							<table>
									<caption>결과해석</caption>
									<colgroup><col class="td5"><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col">수준</th>
											<th scope="col">결과해석</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="logicMathJ"></td>
											<td>
												<div class="text"><%=type_trans_2%></div>
											</td>
										</tr>
									</tbody>
							</table>
						</div>

					</div>
					<!-- //논리수학지능 -->
					
					<!-- 시공간지능 -->
					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_07.jpg?v2" alt="우리 아이의 시공간지능에 대해 알아봅시다!" />
						<div class="scon01" style="top:322px;left:108px">
							<table style="width:787px">
									<caption>척도, T점수</caption>
									<colgroup><col class="td3"><col class="td2"><col class="td4"><col /><col /><col /><col /><col /><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col" colspan="9"><span class="ir">매우낮음, 낮음, 보통, 높음, 매우높음</span></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" rowspan="3">시공간<br />지능</th>
											<th scope="row">선호</th>
											<td><p class="per"><%=type_t_score_3_1%>(<%=type_t_score_11_1%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">능력</th>
											<td><p class="per"><%=type_t_score_3_2%>(<%=type_t_score_11_2%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">전체</th>
											<td><p class="per"><%=type_t_score_3_3%>(<%=type_t_score_11_3%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
									</tbody>
							</table>
						</div>

						<div class="scon02" style="top:575px">
							<table>
									<caption>결과해석</caption>
									<colgroup><col class="td5"><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col">수준</th>
											<th scope="col">결과해석</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="timeNSpaceJ"></td>
											<td>
												<div class="text"><%=type_trans_3%></div>
											</td>
										</tr>
									</tbody>
							</table>
						</div>

					</div>
					<!-- //시공간지능 -->
					
					<!-- 음악 지능 -->
					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_08.jpg?v2" alt="우리 아이의  음악지능에 대해 알아봅시다!" />
						<div class="scon01" style="top:322px;left:108px">
							<table style="width:787px">
									<caption>척도, T점수</caption>
									<colgroup><col class="td3"><col class="td2"><col class="td4"><col /><col /><col /><col /><col /><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col" colspan="9"><span class="ir">매우낮음, 낮음, 보통, 높음, 매우높음</span></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" rowspan="3">음악<br />지능</th>
											<th scope="row">선호</th>
											<td><p class="per"><%=type_t_score_4_1%>(<%=type_t_score_12_1%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">능력</th>
											<td><p class="per"><%=type_t_score_4_2%>(<%=type_t_score_12_2%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">전체</th>
											<td><p class="per"><%=type_t_score_4_3%>(<%=type_t_score_12_3%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
									</tbody>
							</table>
						</div>

						<div class="scon02" style="top:575px">
							<table>
									<caption>결과해석</caption>
									<colgroup><col class="td5"><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col">수준</th>
											<th scope="col">결과해석</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="musicalJ"></td>
											<td>
												<div class="text"><%=type_trans_4%></div>
											</td>
										</tr>
									</tbody>
							</table>
						</div>

					</div>
					<!-- //음악 지능 -->
					
					<!-- 신체운동지능 -->
					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_09.jpg?v2" alt="우리아이의 신체운동지능에 대해 알아봅시다!" />
						<div class="scon01" style="top:322px;left:108px">
							<table style="width:787px">
									<caption>척도, T점수</caption>
									<colgroup><col class="td3"><col class="td2"><col class="td4"><col /><col /><col /><col /><col /><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col" colspan="9"><span class="ir">매우낮음, 낮음, 보통, 높음, 매우높음</span></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" rowspan="3">신체<br />운동<br />지능</th>
											<th scope="row">선호</th>
											<td><p class="per"><%=type_t_score_5_1%>(<%=type_t_score_13_1%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">능력</th>
											<td><p class="per"><%=type_t_score_5_2%>(<%=type_t_score_13_2%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">전체</th>
											<td><p class="per"><%=type_t_score_5_3%>(<%=type_t_score_13_3%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
									</tbody>
							</table>
						</div>

						<div class="scon02" style="top:575px">
							<table>
									<caption>결과해석</caption>
									<colgroup><col class="td5"><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col">수준</th>
											<th scope="col">결과해석</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="physicalJ"></td>
											<td>
												<div class="text"><%=type_trans_5%></div>
											</td>
										</tr>
									</tbody>
							</table>
						</div>

					</div>
					<!-- //신체운동지능  -->
					<!-- 대인간지능 -->
					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_10.jpg?v2" alt="우리아이의 대인간지능에 대해 알아봅시다!" />
						<div class="scon01" style="top:322px;left:108px">
							<table style="width:787px">
									<caption>척도, T점수</caption>
									<colgroup><col class="td3"><col class="td2"><col class="td4"><col /><col /><col /><col /><col /><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col" colspan="9"><span class="ir">매우낮음, 낮음, 보통, 높음, 매우높음</span></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" rowspan="3">대인간<br />지능</th>
											<th scope="row">선호</th>
											<td><p class="per"><%=type_t_score_6_1%>(<%=type_t_score_14_1%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">능력</th>
											<td><p class="per"><%=type_t_score_6_2%>(<%=type_t_score_14_2%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">전체</th>
											<td><p class="per"><%=type_t_score_6_3%>(<%=type_t_score_14_3%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
									</tbody>
							</table>
						</div>

						<div class="scon02" style="top:575px">
							<table>
									<caption>결과해석</caption>
									<colgroup><col class="td5"><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col">수준</th>
											<th scope="col">결과해석</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="interpersonalJ"></td>
											<td>
												<div class="text"><%=type_trans_6%></div>
											</td>
										</tr>
									</tbody>
							</table>
						</div>

					</div>
					<!-- //대인간지능  -->
					<!-- 자기성찰지능  -->
					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_11.jpg?v2" alt="우리아이의 자기성찰지능에 대해 알아봅시다!" />
						<div class="scon01" style="top:322px;left:108px">
							<table style="width:787px">
									<caption>척도, T점수</caption>
									<colgroup><col class="td3"><col class="td2"><col class="td4"><col /><col /><col /><col /><col /><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col" colspan="9"><span class="ir">매우낮음, 낮음, 보통, 높음, 매우높음</span></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" rowspan="3">자기<br />성찰<br />지능</th>
											<th scope="row">선호</th>
											<td><p class="per"><%=type_t_score_7_1%>(<%=type_t_score_15_1%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">능력</th>
											<td><p class="per"><%=type_t_score_7_2%>(<%=type_t_score_15_2%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">전체</th>
											<td><p class="per"><%=type_t_score_7_3%>(<%=type_t_score_15_3%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
									</tbody>
							</table>
						</div>

						<div class="scon02" style="top:575px">
							<table>
									<caption>결과해석</caption>
									<colgroup><col class="td5"><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col">수준</th>
											<th scope="col">결과해석</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="introspectionJ"></td>
											<td>
												<div class="text"><%=type_trans_7%></div>
											</td>
										</tr>
									</tbody>
							</table>
						</div>

					</div>
					<!-- //자기성찰지능  -->
					<!-- 자연친화지능  -->
					<div class="cont03 mt20">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_12.jpg?v2" alt="우리아이의 자연친화지능에 대해 알아봅시다!" />
						<div class="scon01" style="top:322px;left:108px">
							<table style="width:787px">
									<caption>척도, T점수</caption>
									<colgroup><col class="td3"><col class="td2"><col class="td4"><col /><col /><col /><col /><col /><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col" colspan="9"><span class="ir">매우낮음, 낮음, 보통, 높음, 매우높음</span></th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" rowspan="3">자연<br />친화<br />지능</th>
											<th scope="row">선호</th>
											<td><p class="per"><%=type_t_score_8_1%>(<%=type_t_score_16_1%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">능력</th>
											<td><p class="per"><%=type_t_score_8_2%>(<%=type_t_score_16_2%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
										<tr>
											<th scope="row">전체</th>
											<td><p class="per"><%=type_t_score_8_3%>(<%=type_t_score_16_3%>)</p></th>
											<td colspan="6" class="graph"><div><em>&nbsp;</em><span></span></div></td>
										</tr>
									</tbody>
							</table>
						</div>

						<div class="scon02" style="top:575px">
							<table>
									<caption>결과해석</caption>
									<colgroup><col class="td5"><col /></colgroup>
									<thead class="ir">
										<tr>
											<th scope="col">수준</th>
											<th scope="col">결과해석</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td id="natureFriendlyJ"></td>
											<td>
												<div class="text"><%=type_trans_8%></div>
											</td>
										</tr>
									</tbody>
							</table>
						</div>

					</div>
					<!-- //자연친화지능  -->
				
				<!-- 결과요약 -->
				<div class="cont03 mt20">
					<img src="https://pic.neungyule.com/nekids/img/standard/img_kids05_13.jpg" alt="결과요약" />
					<div class="cht_wrap">
						<canvas class="rader_chart"></canvas>
					</div>
					<div class="Itg">
						<span class="tx1">1순위 : <%=type_total_score_1%></span>
						<span class="tx2">2순위 : <%=type_total_score_2%></span>
					</div>
					<div class="Itg last">
						<span class="tx1">1순위 : <%=type_total_score_3%></span>
						<span class="tx2">2순위 : <%=type_total_score_4%></span>
					</div>
				</div>
				<!-- //결과요약  -->
				
				<!-- 총평 -->
				<div class="cont03 mt20">
					<img src="/_pages/img/standard/img_kids05_14.jpg" alt="총평" />
					<div class="scon02" style="top:214px">
						<div class="text"><%=type_plan_1%></div>
					</div>
					<b class="name"><%=childMbrNm%></b>
				</div>
				<!-- //총평  -->
<%
	Next
	
	End If
%>
	

				</div><!-- //rstbx -->
		</div><!-- standardArea -->
<script src="/_pages/inc/js/chart.js"></script>
<script src="/_pages/inc/js/utils.js"></script>
<script>

window.onload = function() {

	var languageT = ["<%=type_t_score_1_1%>","<%=type_t_score_1_2%>","<%=type_t_score_1_3%>","<%=type_t_score_1_1_1%>"];	
	var logicMathT = ["<%=type_t_score_2_1%>","<%=type_t_score_2_2%>","<%=type_t_score_2_3%>","<%=type_t_score_2_1_1%>"];	
	var timeNSpaceT = ["<%=type_t_score_3_1%>","<%=type_t_score_3_2%>","<%=type_t_score_3_3%>","<%=type_t_score_3_1_1%>"];
	var musicalT = ["<%=type_t_score_4_1%>","<%=type_t_score_4_2%>","<%=type_t_score_4_3%>","<%=type_t_score_4_1_1%>"];
	var physicalT = ["<%=type_t_score_5_1%>","<%=type_t_score_5_2%>","<%=type_t_score_5_3%>","<%=type_t_score_5_1_1%>"];
	var interpersonalT = ["<%=type_t_score_6_1%>","<%=type_t_score_6_2%>","<%=type_t_score_6_3%>","<%=type_t_score_6_1_1%>"];
	var introspectionT = ["<%=type_t_score_7_1%>","<%=type_t_score_7_2%>","<%=type_t_score_7_3%>","<%=type_t_score_7_1_1%>"];
	var natureFriendlyT = ["<%=type_t_score_8_1%>","<%=type_t_score_8_2%>","<%=type_t_score_8_3%>","<%=type_t_score_8_1_1%>"];

		
	// 방사형 그래프
	var labels = 
					[
						[
							{name:"언어지능", data: 6, achieve : languageT[0]},
							{name:"논리수학지능", data: 6, achieve : logicMathT[0]},
							{name:"시공간지능", data: 6, achieve : timeNSpaceT[0]},
							{name:"음악지능", data: 6, achieve : musicalT[0]},
							{name:"신체운동지능", data: 6, achieve : physicalT[0]},
							{name:"대인간지능", data: 6, achieve : interpersonalT[0]},
							{name:"자기성찰지능", data: 6, achieve : introspectionT[0]},
							{name:"자연친화지능", data: 6, achieve : natureFriendlyT[0]}
						]
						,
						[
							{name:"언어지능", data: 6, achieve : languageT[1]},
							{name:"논리수학지능", data: 6, achieve : logicMathT[1]},
							{name:"시공간지능", data: 6, achieve : timeNSpaceT[1]},
							{name:"음악지능", data: 6, achieve : musicalT[1]},
							{name:"신체운동지능", data: 6, achieve : physicalT[1]},
							{name:"대인간지능", data: 6, achieve : interpersonalT[1]},
							{name:"자기성찰지능", data: 6, achieve : introspectionT[1]},
							{name:"자연친화지능", data: 6, achieve : natureFriendlyT[1]}
						]
						,
						[
							{name:"언어지능", data: 6, achieve : languageT[2]},
							{name:"논리수학지능", data: 6, achieve : logicMathT[2]},
							{name:"시공간지능", data: 6, achieve : timeNSpaceT[2]},
							{name:"음악지능", data: 6, achieve : musicalT[2]},
							{name:"신체운동지능", data: 6, achieve : physicalT[2]},
							{name:"대인간지능", data: 6, achieve : interpersonalT[2] },
							{name:"자기성찰지능", data: 6, achieve : introspectionT[2]},
							{name:"자연친화지능", data: 6, achieve : natureFriendlyT[2]}
						]
                        ,
						[
							{name:"언어지능", data: 6, achieve : languageT[3]},
							{name:"논리수학지능", data: 6, achieve : logicMathT[3]},
							{name:"시공간지능", data: 6, achieve : timeNSpaceT[3]},
							{name:"음악지능", data: 6, achieve : musicalT[3]},
							{name:"신체운동지능", data: 6, achieve : physicalT[3]},
							{name:"대인간지능", data: 6, achieve : interpersonalT[3] },
							{name:"자기성찰지능", data: 6, achieve : introspectionT[3]},
							{name:"자연친화지능", data: 6, achieve : natureFriendlyT[3]}
						]
						
					]
					
		
	var labelsName = [];
	var labelsData = [];
	var color = '';
	var config = {};
	
	for(var d in labels ){
        console.log(d);
		d = +d; //숫자로 변경
		labelsName = [];
		labelsData = [];

		$.each(labels[d], function(i){
			if(this.data != 0) {
				labelsName.push(this.name);
				labelsData.push(this.achieve);
			}
		});

		color = Chart.helpers.color;

		config = {
			type: 'radar',
			data: {
				labels: labelsName,
				datasets: [{
					backgroundColor: color(window.chartColors.blue).alpha(0.2).rgbString(),
					borderColor: window.chartColors.blue,
					pointBackgroundColor: window.chartColors.blue,
					data: labelsData
				}]
			},
			options: {
				layout: {
					padding: {
						left: 0,
						right: 0,
						top: 0,
						bottom: 0
					}
				},
				animation: {
					animateScale: false
				},
				legend: {
					display: false
				},
				title: {
					display: false
				},
				scale: {
					ticks: {
						min: 0,
						max: 80,
						stepSize: 20
					},
					pointLabels: {
						fontSize: 14,
						backdropPaddingX:0,
						backdropPaddingY:0,
						fontColor:"#606060",
						fontStyle:"bold"
					}
				}

			}

		};

		if( (d+1) === 3){	
			
			window.myRadar = new Chart(document.getElementsByClassName("rader_chart" + (d+1)), config);
		} else if(d === 3) {
            window.myRadar = new Chart(document.getElementsByClassName("rader_chart"), config);
        } else{
			window.myRadar = new Chart(document.getElementsByClassName("rader_chart" + (d+1)), config);
		}
	

	}

	var languageP = ["<%=type_t_score_1_1%>","<%=type_t_score_1_2%>","<%=type_t_score_1_3%>"];	
	var logicMathP = ["<%=type_t_score_2_1%>","<%=type_t_score_2_2%>","<%=type_t_score_2_3%>"];	
	var timeNSpaceP = ["<%=type_t_score_3_1%>","<%=type_t_score_3_2%>","<%=type_t_score_3_3%>"];
	var musicalP = ["<%=type_t_score_4_1%>","<%=type_t_score_4_2%>","<%=type_t_score_4_3%>"];
	var physicalP = ["<%=type_t_score_5_1%>","<%=type_t_score_5_2%>","<%=type_t_score_5_3%>"];
	var interpersonalP = ["<%=type_t_score_6_1%>","<%=type_t_score_6_2%>","<%=type_t_score_6_3%>"];
	var introspectionP = ["<%=type_t_score_7_1%>","<%=type_t_score_7_2%>","<%=type_t_score_7_3%>"];
	var natureFriendlyP = ["<%=type_t_score_8_1%>","<%=type_t_score_8_2%>","<%=type_t_score_8_3%>"];

	var jData = { 
			languageJ : "<%=type_t_score_9_3%>", logicMathJ : "<%=type_t_score_10_3%>", 
			timeNSpaceJ : "<%=type_t_score_11_3%>", musicalJ : "<%=type_t_score_12_3%>", 
			physicalJ : "<%=type_t_score_13_3%>", interpersonalJ : "<%=type_t_score_14_3%>", 
			introspectionJ : "<%=type_t_score_15_3%>", natureFriendlyJ : "<%=type_t_score_16_3%>"		
		}

	IntptDataSetting(jData);
	
	//그래프 값 계산
	var all = 60; //전체
	var num = [
		languageP[0], languageP[1], languageP[2],
		logicMathP[0], logicMathP[1], logicMathP[2],
		timeNSpaceP[0], timeNSpaceP[1], timeNSpaceP[2],
		musicalP[0], musicalP[1], musicalP[2],
		physicalP[0], physicalP[1], physicalP[2],
		interpersonalP[0], interpersonalP[1], interpersonalP[2],
		introspectionP[0], introspectionP[1], introspectionP[2],
		natureFriendlyP[0], natureFriendlyP[1], natureFriendlyP[2]
	
	]; //T점수 데이터
	var grighW = 542; //그래프 전체길이

	$(".graph").each(function(id) {

	   gap =  grighW/all*20; //그래프 시작점 20~80 간격
	   percent = num[id]*grighW/all ; //그래프 퍼센트

	   if(num[id] < 20){
		  $(this).find("em").width(0); //20점 이하 0으로 표기

	   }else if(num[id] > 80){
		  $(this).find("em").width(grighW);  //80점 이상 100으로 표기

	   }else{
		  $(this).find("em").width(percent-gap);

	   }
	});
	


};

/********************************
[결과 해석 > 수준] 부분에 데이터 세팅
********************************/
function IntptDataSetting(jData){
	
	var jData = jData;
	var jValue = 0;
	var jText = '';
	Object.keys(jData).forEach(function(k){
		
		jValue = +(jData[k]);

		if (jValue < 30){
			jText = "매우낮음";
		}else if(jValue >= 30 && jValue < 40) {
			jText = "낮음";
		}else if(jValue >= 40 && jValue < 60) {
			jText = "보통";
		}else if(jValue >= 60 && jValue < 70) {
			jText = "높음";
		}else if(jValue >= 0) {
			jText = "매우높음";
		}	
		$("#" + k).text(jText);

	});


}

</script>

		<!-- #include virtual = "/_pages/inc/layout/quick.asp" -->
	</div><!-- //container -->
	<!-- #include virtual = "/_pages/inc/layout/footer.asp" -->
</div><!-- //wrapper -->
</body>
</html>
