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
<%
	L_MENU = "17"
	M_MENU = "4"
	S_MENU = "1"
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<!-- #include virtual = "/_pages/inc/layout/head.asp" -->
<script type="text/javascript">

$(function(){	
	$('ul.tabs li').click(function(){
			var tab_id = $(this).attr('data-tab');

			$('ul.tabs li').removeClass('on off');
			$('.tab_cont').removeClass('on');
			$(this).prevAll("li").addClass("off");

			$(this).addClass('on');
			$("#"+tab_id).addClass('on');
		});
});
</script>
</head>
<body>
<div id="wrapper">
	<!-- #include virtual = "/_pages/inc/layout/header.asp" -->
	<!-- visualArea -->
	<div class="visualArea visualA">
		<div class="visualCont visualAbg">
			<h2>부가서비스</h2>
			<!-- #include virtual = "/_pages/inc/layout/location.asp" -->
		</div><!-- //visualCont -->
	</div><!-- //visualArea -->
	<!-- container -->
	<div id="container">
		<!-- contArea -->
		<div id="contArea">
				<!-- titleArea -->
			<div class="titleArea titleIconN1">
				<h3>유아 발달 표준화 검사 </h3>
				<b>유아 표준화 검사로 우리아이의 특성을 파악해 보세요. </b>
			</div><!-- //titleArea -->

				<ul class="tabTypeD std">
					<li class="on"><a href="javascript://"><span>유아 발달<br />표준화 검사란?</span></a></li>
					<li><a href="./exam01.asp"><span>검사하기</span></a></li>
					<!--<li><a href="./exam05.asp"><span>검사결과</span></a></li>-->
					<li>
					<% If C_MBR_TP = "0" Or C_MBR_TP = "4" Or C_MBR_TP = "5" Then %>
					<a href="./exam05_2_2.asp"><span>검사결과</span></a>
					<% ELSE %>
					<a href="./exam05.asp"><span>검사결과</span></a>
					<% End IF%>
					</li>
					<!--<li><a href="javascript://" onclick="alert('준비 중입니다')"><span>검사하기</span></a></li>-->
					<!--<li><a href="javascript://" onclick="alert('준비 중입니다')" ><span>검사결과</span></a></li>-->
				</ul>

			<!-- standardArea -->
			<div class="standardArea">
				<div class="cont cont01">
					<h4>검사 종류와 특징</h4>
					<ul class="tabs">
						<li class="on" data-tab="tab1"><a  href="javascript://">영•유아 발달검사</a></li>
						<li data-tab="tab2"><a  href="javascript://">유아 발달검사</a></li>
						<li data-tab="tab3"><a  href="javascript://">유아 자아개념검사</a></li>
						<li data-tab="tab4"><a  href="javascript://">유아 성격검사</a></li>
						<li data-tab="tab5"><a  href="javascript://">유아 다중지능검사</a></li>
						<li data-tab="tab6"><a  href="javascript://">독서능력검사 </a></li>
					</ul>

					<div id="tab1" class="tab_cont on">
						<div class="bx">
							<div class="bximg">
								<img src="https://pic.neungyule.com/nekids/img/standard/img_book01.jpg" alt="영•유아 발달검사" />
								<a href="./exam01.asp?inspcd=C01">검사하기</a>
								<!--<a href="javascript://" onclick="alert('준비 중입니다')">검사하기</a>-->
							</div>
							<div class="bxinfo">
								<dl>
									<dt>유아기 발달 어떻게 이해할 것인가? (25개월~48개월)</dt>
									<dd>발달은 자연스러운 성숙과 더불어 학습적 경험이나 훈련, 연습 등에 의해 이끌어지고 질적 변화가 이루어지기 때문에 부모가 아동의 호기심에 민감하게 반응하고, 다양한 자극을 통해 경험을 확대해 줄 경우, 아동의 발달을 이끄는데 큰 도움이 됩니다.</dd>
								</dl>
								<dl>
									<dt>검사의 개요</dt>
									<dd>영·유아기 언어발달에 문제가 발생하면 언어 문제 뿐만 아니라 친구 사귀기나 규칙 지키기와 같은 사회발달의 문제로까지 확대될 수 있기 때문에 각 영역의 발달 수준을 파악하여 문제가 발생하면 적극적으로 대처해야 합니다.</dd>
								</dl>
								<dl>
									<dt>검사의 특징</dt>
									<dd>현장 경험이 풍부한 교사와 유아교육학, 발달심리학 전공자들의 오랜 연구를 통해 하위 구성 요인을 추출하였습니다.</dd>
									<dd>표준보육과정과 누리과정의 내용범주를 기초로 영유아 대상 교육과정에서 다루고 있는 모든 내용을 포함시켰으며, 교육기관 내에서의 발달 영역뿐만 아니라 아동의 감정 및 정서능력, 자조행동발달 정도를 포함시켜 부모와의 관계나 가정 내에서의 발달 정도를 다면적이고 심층적 으로 살펴볼 수 있습니다.</dd>
									<dd>상세 결과 피드백을 제공함으로써 부모나 교사는 또래 간 개인차뿐만 아니라 개인 내 영역별 발달 수준을 정확히 파악하고, 수준에 알맞은 교육과 양육을 하는데 유용한 정보를 얻을 수 있습니다.</dd>
								</dl>
							</div>
						</div>
					</div>
					<div id="tab2" class="tab_cont">
						<div class="bx">
							<div class="bximg">
								<img src="https://pic.neungyule.com/nekids/img/standard/img_book02.jpg" alt="유아 발달검사" />
								<a href="./exam01.asp?inspcd=C04">검사하기</a>
								<!--<a href="javascript://" onclick="alert('준비 중입니다')">검사하기</a>-->
							</div>
							<div class="bxinfo">
								<dl>
									<dt>유아기 발달 어떻게 이해할 것인가? (만 3~7세)</dt>
									<dd>유아기 발달은 생애 발달의 기초로써, 그 이후의 발달에도 영향을 미칠 뿐만 아니라 한 영역의 발달 문제가 다른 영역의 발달 문제로 확대될 수 있기 때문에 현재 아동의 발달 수준을 정확히 이해하는 것은 중요한 의미를 갖습니다. 즉, 언어발달의 결정적 시기인 유아기 언어발달의 문제는 언어문제 뿐만 아니라 친구 사귀기나 규칙 지키기와 같은 사회발달의 문제로까지 확대될 가능성이 있기 때문에 빨리 정확한 수준을 알고 대처하는 것이 매우 중요합니다.</dd>
								</dl>
								<dl>
									<dt>검사의 개요</dt>
									<dd>본 검사는 부모, 교사, 상담가, 보육이나 교육 종사자들에게 아동이 또래 안에서 나타나는 발달 수준 및 개인 내 발달 정도를 이해하는데 도움이 되는 정보를 제공합니다.</dd>
								</dl>
								<dl>
									<dt>검사의 특징</dt>
									<dd>현장 경험이 풍부한 교사와 유아교육학, 발달심리학 전공자들의 오랜 연구를 통해 하위 구성 요인을 추출하였습니다.</dd>
									<dd>누리과정과 표준보육과정에서 다루고 있는 내용범주를 기초로 유아대상 교육과정에서 다루고 있는 모든 내용을 고루 포함시켰으며, 교육기관 내에서의 발달영역 뿐만 아니라 아동의 감정 및 정서능력, 자조행동발달 정도를 포함시켜 부모와의 관계나 가정 내에서의 발달정도를 다면적이고 심층적으로 살펴볼 수 있습니다.</dd>
									<dd>상세 결과 피드백을 제공함으로써 부모나 교사는 또래 간 개인차뿐만 아니라 개인 내 영역별 발달 수준을 정확히 파악하고, 수준에 알맞은 교육과 양육을 하는데 유용한 정보를 얻을 수 있습니다.</dd>
								</dl>
							</div>
						</div>
					</div>
					<div id="tab3" class="tab_cont">
						<div class="bx">
							<div class="bximg">
								<img src="https://pic.neungyule.com/nekids/img/standard/img_book03.jpg" alt="유아 자아개념검사" />
								<a href="./exam01.asp?inspcd=C02">검사하기</a>
								<!--<a href="javascript://" onclick="alert('준비 중입니다')">검사하기</a>-->
							</div>
							<div class="bxinfo">
								<dl>
									<dt>지나치게 소극적인 아이... 무엇이 문제인가? (만 3~7세)</dt>
									<dd>자아개념은 자신에 대한 총체적인 지각으로 한 개인이 자신의 신체, 행동, 능력 등에 대해 가지고 있는 가치, 신념, 견해를 의미합니다. 즉, “나는 누구인가?”, “나는 어떤 특성을 가지고 있는가?”, “나는 어떤 능력을 가지고 있는가?” 등의 질문에 대한 답이 바로 자아개념이 됩니다.  긍정적 자아개념을 가지고, 자기 자신을 가치있고, 유능하다고 여기면, 그러한 자아개념에 합치되도록 매사에 열심히 노력하는 반면, 부정적 자아개념을 가지고, 자기 자신을 쓸모없고, 무능하다고 생각하면, 매사에 소극적으로 행동하게 됩니다.</dd>
								</dl>
								<dl>
									<dt>검사의 개요</dt>
									<dd>본 검사는 부모, 교사, 상담가, 보육이나 교육 종사자들에게 유아의 건강한 발달을 위해 요구되는데 자아개념의 특성에 관한 객관적이고 정확한 정보를 제공합니다.</dd>
								</dl>
								<dl>
									<dt>검사의 특징</dt>
									<dd>현장 경험이 풍부한 교사와 교육학, 교육심리학 전공자들의 오랜 연구를 통해 하위 척도를 추출하였습니다.</dd>
									<dd>자아개념을 구성하는 하위 척도별로 하위 요인을 세분화하여 살펴봄으로써 유아가 가진 특성을 다면적이고 심층적으로 살펴볼 수 있습니다.</dd>
									<dd>상세한 결과 피드백을 제공함으로써 교사와 학부모가 유아를 지도하는데 유용한 정보를 얻을 수 있습니다.</dd>
								</dl>
							</div>
						</div>
					</div>
					<div id="tab4" class="tab_cont">
						<div class="bx">
							<div class="bximg">
								<img src="https://pic.neungyule.com/nekids/img/standard/img_book04.jpg" alt="유아 성격검사" />
								<a href="./exam01.asp?inspcd=C03">검사하기</a>
								<!--<a href="javascript://" onclick="alert('준비 중입니다')" >검사하기</a>-->
							</div>
							<div class="bxinfo">
								<dl>
									<dt>유아의 성격을 어떻게 이해할 것인가? (만 3~7세)</dt>
									<dd>일반적으로 성격은 시간적·공간적으로 안정적인 개인의 특성을 말합니다. 성격은 타고난 생물학적 특성과 출생 후 제공되는 환경적 자극과 지원에 의해 형성되고, 이것은 삶에서 만나게 되는 문제들을 해결할 때 보이는 독특한 개인차가 됩니다. 실제로 성격은 전 생애동안 어느 정도 변합니다. 그러나 유아가 현재 발달하고 있으며 어릴수록 변화가능성이 더 높다는 점에서 어린 유아의 현재 성격 속성을 확인하고 그에 맞는 적절한 자극을 제공하는 것은 효과적이고 중요합니다.</dd>
								</dl>
								<dl>
									<dt>검사의 개요</dt>
									<dd>유아의 성격을 여러 가지 구성요소들로 세분하여 측정함으로써 유아가 다양한 상황에서 보이는 행동을 이해할 뿐만 아니라 어떻게 행동할 것인지를 예측하고 그에 따라 적절하게 반응할 준비를 하는데 필요한 정보를 얻을 수 있습니다.</dd>
								</dl>
								<dl>
									<dt>검사의 특징</dt>
									<dd>발달심리학, 유아교육학, 아동학 등 다양한 분야의 연구 결과들을 통해 하위 구성요인을 추출하였습니다.</dd>
									<dd>아동이나 성인 성격검사에서 측정되는 요인들과 관련이 높은 요인들로 구성함으로써 추후 아동기나 성인기의 성격에 대한 설명과 일관성을 살펴볼 수 있습니다.</dd>
									<dd>상세 결과 피드백을 제공하여 부모와 교사가 유아 개인의 발달수준을 정확히 파악하고 적절한 교육과 양육을 하는데 유용한 정보를 얻을 수 있습니다.</dd>
								</dl>
							</div>
						</div>
					</div>
					<div id="tab5" class="tab_cont">
						<div class="bx">
							<div class="bximg">
								<img src="https://pic.neungyule.com/nekids/img/standard/img_book05.jpg" alt="유아 다중지능검사" />
								<a href="./exam01.asp?inspcd=C05">검사하기</a>
								<!--<a href="javascript://" onclick="alert('준비 중입니다')">검사하기</a>-->
							</div>
							<div class="bxinfo">
								<dl>
									<dt>지능높은 유아는 모든 부분에서 뛰어난 능력을 나타내는 것일까?(만 3~7세)</dt>
									<dd>흔히 지능이 높은 유아는 모든 영역에서 우수하다고 믿습니다. 과연 그럴까요? 가드너의 다중지능이론은 지능이 높은 유아는 모든 영역에서 우수하다는 종래의 획일주의적인 지능
관을 강하게 비판하면서, 인간의 지적 능력은 서로 독립적이며 상이한 여러 유형의 능력으로 구성되어 있고 개인마다 각 유형에서의 발달 수준이 상이하다고 주장합니다. 본 검사는 지능의 8가지 유형을 바탕으로 유아의 지능 특성을 제공합니다.</dd>
								</dl>
								<dl>
									<dt>검사의 개요</dt>
									<dd>유아의 지능을 객관적으로 측정함으로써 유아에게 자신의 지적 능력에서의 특성을 올바르게 이해시키고 부모와 교사가 유아의 양육과 교육에 필요한 유용한 정보를 얻을 수 있습니다.</dd>
								</dl>
								<dl>
									<dt>검사의 특징</dt>
									<dd>현대 지능이론 중 새로이 주목을 받고 있는 다중지능이론을 토대로 유아의 지능을 8개 유형으로 나누어 측정합니다.</dd>
									<dd>기존의 다중지능검사들은 유아의 능력 수준만을 측정함으로써 향후 유아의 성장 가능성을 예측할 수 없다는 문제점을 가지고 있는 반면, 본 검사는 유아의 현재 능력 수준 뿐만 아니라 선호를 함께 측정함으로써 유아의 향후 발달 수준을 정확하게 예측할 수 있습니다.</dd>
									<dd>개인간 발달 수준을 비교한 정보가 제공되어 유아의 발달 수준이 다른 아동들과 비교하여 어느 정도 수준인지에 대해 객관적 정보를 얻을 수 있습니다.</dd>
								</dl>
							</div>
						</div>
					</div>
					<div id="tab6" class="tab_cont">
						<div class="bx">
							<div class="bximg">
								<img src="https://pic.neungyule.com/nekids/img/standard/img_book06.jpg" alt="독서능력검사" />
								<a href="./exam01.asp?inspcd=C06">검사하기</a>
							</div>
							<div class="bxinfo">
								<dl>
									<dt>유아시기의 독서는 왜 중요할까 ? (만3~7세)</dt>
									<dd>독서는 지식과 정보화 시대에 대비하기 위한 21세기의 필수 생존 전략으로 독서로 얻은 새로운 지식과 정보는 개인과 기업 경쟁력의 밑바탕이 됩니다. 유아 시기의 독서를 통해 유아들은 다른 사람을 이해하는 힘을 기를 수 있으며, 어휘력과 상상력이 풍부해지며, 독립심이 강해지고, 세계가 넓어집니다. 본 검사는 7가지 척도로 나누어 검사하고 유아의 독서관련 행동과 습관 그리고 독서환경에 대한 학부모의 관찰 결과를 분석합니다.</dd>
								</dl>
								<dl>
									<dt>검사의 개요</dt>
									<dd>유아의 독서 능력을 여러가지 척도로 평가함으로써 올바른 독서 습관 형성을 위해 유아의 현재 독서능력 뿐만 아니라 독서능력에 영향을 미치는 다양한 요인들의 특성을 파악하여, 문제를 해결 할 수 있습니다.</dd>
								</dl>
								<dl>
									<dt>검사의 특징</dt>
									<dd>심리학, 교육학 유아교육학 등 관련 분야의 다양한 연구 성과물들을 분석하여 유아의 독서능력을 구성하는 요인들과 독서능력에 영향을 미치는 요인들을 추출하였습니다.</dd>
									<dd>유아의 현재 독서능력을 객관적으로 파악할 수 있습니다. 유아의 강점 영역과 약점 영역을 파악할 수 있습니다.</dd>
									<dd>유아의 독서능력에 영향을 미치는 요인들의 특성을 파악함으로써 유아의 독서능력을 함양할 수 있습니다.</dd>
									<dd>독서행동에 관한 부모의 특성을 파악함으로써 자녀에게 좋은 모델로서의 역할을 할 수 있는 유용한 정보를 제공합니다.</dd>
								</dl>
							</div>
						</div>
					</div>
					<h4>심리검사 도입 기관 장점</h4>
					<div class="bx">
						<img src="https://pic.neungyule.com/nekids/img/standard/img_cont01.png" alt="기관 경쟁력 강화" />
						<dl class="ir">
							<dt>전문성</dt>
							<dd>구체적이고 표준화된 도구</dd>
							<dd>문제 행동 자녀를 둔 학부모와 정확한 교육 상담</dd>
							<dt>활용성</dt>
							<dd>강점 유형 분류, 발달 수준을 고려한 분류로 </dd>
							<dd>장점별, 재능별 반편성 가능</dd>
							<dt>다양성</dt>
							<dd>유아의 발달과 특기, 진로 등 컨설팅 영역까지 상담</dd>
						</dl>
					</div>
				</div>
			</div>
			<!-- //standardArea -->
		</div><!-- standardArea -->



		<!-- #include virtual = "/_pages/inc/layout/quick.asp" -->
	</div><!-- //container -->
	<!-- #include virtual = "/_pages/inc/layout/footer.asp" -->
</div><!-- //wrapper -->
</body>
</html>