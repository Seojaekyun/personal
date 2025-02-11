<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyShop</title>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- jQuery 라이브러리 추가 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	body {
		margin: 0;
		font-family: Arial, sans-serif;
	}
	#slide {
		position: relative; /* 부모 요소를 기준으로 버튼을 배치하기 위해 relative 설정 */
		width: 100%; /* 화면 전체 너비 */
		height: 373px; /* 고정 높이 */
		overflow: hidden; /* 이미지가 넘치지 않도록 */
		display: flex;
		justify-content: center; /* 슬라이드 컨테이너를 중앙 정렬 */
	}
	#slide .slide-wrapper {
		display: flex; /* 이미지들을 가로로 나열 */
		width: calc(1896px * 7); /* 이미지 너비 * 이미지 개수 */
		transition: transform 2s ease; /* 슬라이드 애니메이션 */
	}
	#slide img {
		width: 1896px; /* 각 이미지의 너비 */
		height: 373px; /* 고정 높이 */
		object-fit: cover; /* 이미지 비율 유지 */
	}
	#slide .button-container {
		position: absolute;
		top: 50%;
		left: 0;
		right: 0;
		transform: translateY(-50%); /* 수직 중앙 정렬 */
		display: flex;
		justify-content: space-between; /* 좌우 버튼을 양쪽 끝에 배치 */
		padding: 15% 15%; /* 좌우 여백 추가 */
		opacity: 0; /* 기본적으로 버튼 숨김 */
		transition: opacity 0.3s ease; /* 부드러운 전환 효과 */
	}
	#slide:hover .button-container {
		opacity: 1; /* 호버 시 버튼 표시 */
	}
	#slide button {
		background-color: rgba(0, 0, 0, 0.6); /* 반투명한 배경색 */
		font-weight: 500;
		font-size: 18px;
		color: white; /* 버튼 텍스트 색상 */
		border: none;
		width: 40px;
		height: 40px;
		line-height: 40px;
		border-radius: 50%; /* 둥근 버튼 */
		cursor: pointer;
		display: flex;
		align-items: center;
		justify-content: center;
	}
	section {
		width: 1100px;
		margin: auto;
		background: white;
	}
	section > div {
		width: 1000px;
		height: 400px;
		border: 2px solid black;
		margin: auto;
	}
</style>
<script>
	$(document).ready(function() {
		var slideWidth=1896; // 각 이미지의 너비
		var slides=$(".simg");
		var slideContainer=$("#slide .slide-wrapper");
		var slideCount=slides.length;
		
		// ⭐ 앞뒤로 이미지를 복제하여 무한 루프 구현
		slides.clone().appendTo(slideContainer); // 뒤에 복제
		slides.clone().prependTo(slideContainer); // 앞에 복제
		
		var newSlideCount=slideContainer.children().length; // 전체 슬라이드 개수
		
		// ⭐ 올바른 초기 위치 설정
		var startIndex=slideCount; // 원본 첫 번째 이미지가 중앙에 오도록 설정
		var currentSlide=startIndex;
		
		// ⭐ transition 없이 첫 번째 슬라이드로 즉시 이동 (이동 애니메이션 방지)
		slideContainer.css({
			'transition': 'none',
			'transform': 'translateX(' + (-slideWidth * currentSlide) + 'px)'
		});
		
		// ⭐ 0.1초 후 transition 활성화 (초기 애니메이션 문제 방지)
		setTimeout(function() {
			slideContainer.css('transition', 'transform 0.5s ease');
		}, 100);
		
		function slideNext() {
			currentSlide++;
			slideContainer.css({
				'transition': 'transform 0.5s ease',
				'transform': 'translateX(' + (-slideWidth * currentSlide) + 'px)'
			});
			
			setTimeout(function() {
				if (currentSlide >= newSlideCount - slideCount) {
					currentSlide = slideCount;
					slideContainer.css({
						'transition': 'none',
						'transform': 'translateX(' + (-slideWidth * currentSlide) + 'px)'
					});
					setTimeout(function() {
						slideContainer.css('transition', 'transform 0.5s ease');
					}, 100);
				}
			}, 500);
		}
		
		function slidePrev() {
			currentSlide--;
			slideContainer.css({
				'transition': 'transform 0.5s ease',
				'transform': 'translateX(' + (-slideWidth * currentSlide) + 'px)'
			});
			
			setTimeout(function() {
				if (currentSlide < slideCount) {
					currentSlide = newSlideCount - slideCount - 1;
					slideContainer.css({
						'transition': 'none',
						'transform': 'translateX(' + (-slideWidth * currentSlide) + 'px)'
					});
					setTimeout(function() {
						slideContainer.css('transition', 'transform 0.5s ease');
					}, 100);
				}
			}, 500);
		}
		
		// ⭐ 4초 후 자동 슬라이드 시작
		setTimeout(function() {
			setInterval(slideNext, 4500);
		}, 0);
		
		// 버튼 클릭 이벤트
		$('button[data-direction="left"]').click(slidePrev);
		$('button[data-direction="right"]').click(slideNext);
	});
	
</script>
</head>
<body>
	<div id="slide">
		<div class="slide-wrapper">
			<img class="simg" src="../static/resources/kurlyev1.png" alt="Slide Image"><img class="simg" src="../static/resources/kurlyev2.png" alt="Slide Image"><img class="simg" src="../static/resources/kurlyev3.png" alt="Slide Image"><img class="simg" src="../static/resources/kurlyev4.png" alt="Slide Image"><img class="simg" src="../static/resources/kurlyev5.png" alt="Slide Image"><img class="simg" src="../static/resources/kurlyev6.png" alt="Slide Image"><img class="simg" src="../static/resources/kurlyev7.png" alt="Slide Image">
		</div>
		<div class="button-container">
			<button type="button" data-direction="left" class="css-1lsz3kj e9otvnb0">〈</button>
			<button type="button" data-direction="right" class="css-kfz8up e9otvnb0">〉</button>
		</div>
	</div>

	<section>
		구멍가게 입니다.
	</section>
</body>
</html>