$(window).on("load", function () {
	const ww = $(window).width();
	fixingPage();
	
//	var i = 0;
//	while(i==0){
//		setTimeout(function(){
//			alert("test");
//			$('.body-slide div:nth-child(2)').css('opacity','1');
//		},1000);
//		setTimeout(function(){
//			alert("test");
//			$('.body-slide div:nth-child(3)').css('opacity','1');
//		},1000);
//		setTimeout(function(){
//			alert("test");
//			$('.body-slide div:nth-child(2)').css('opacity','0');
//		},1000);
//		setTimeout(function(){
//			alert("test");
//			$('.body-slide div:nth-child(3)').css('opacity','0');
//		},1000);
//	}
	
	//	overflow();
	if (ww < 768) {
		$(window).on("resize", function () {
			fixingPage();
		})
	}

	//ページ内スムーススクロール
	$("a[href^='#']:not(.notscroll)").on("click", function () {
		// スクロールの速度
		var speed = 400; // ミリ秒
		// アンカーの値取得
		var href = $(this).attr("href");
		// 移動先を取得
		var target = $(href == "#" || href == "" ? "html" : href);
		// 移動先を数値で取得
		var position = target.offset().top;
		// スムーススクロール
		$("body,html").animate({
			scrollTop: position - 120
		}, speed, "swing");
		return false;
	});

//	overflow();

//	function overflow() {
//		$(".scrollContainerWrapper").each(function () {
//			const scrollContent = $(this).find(".scrollContent");
//			const scrollContentWidth = scrollContent.width();
//			const scrollContainer = $(this).find(".scrollContainer");
//			const scrollContainerWidth = scrollContainer.width();
//			const scrollContainerInnerWidth = scrollContainer.innerWidth();
//			const scrollContainerBaseWidth = scrollContainerInnerWidth - ((scrollContainerInnerWidth - scrollContainerWidth) / 2);
//
//			if (scrollContentWidth > scrollContainerBaseWidth) {
//				scrollContainer.addClass("overflow");
//			} else {
//				scrollContainer.removeClass("overflow");
//			}
//		});
//	}

	function fixingPage() {
		const btnMenu = $("#btn-menu");
		const navMain = $("#nav-main");
		const navMainA = $("#nav-main a");
		btnMenu.removeClass("active");
		const phh2 = $("#page-header").outerHeight(true);
		$("#page-main").css("padding-top", phh2);

//		if (ww < 768) {
//			navMain.hide();

			btnMenu.off("click");
			btnMenu.on("click", function () {
				$(this).toggleClass("active");
				navMain.toggleClass("active");
				$("#body-cover").toggleClass("active");
			});
			navMainA.off("click");
			navMainA.on("click", function () {
				navMain.removeClass("active");
				btnMenu.removeClass("active");
				$("#body-cover").removeClass("active");
			});
			navMain.off("click");
			navMain.on("click", function () {
				$(this).removeClass("active");
				btnMenu.removeClass("active");
				$("#body-cover").removeClass("active");
			});
			$("#body-cover").off("click");
			$("#body-cover").on("click", function () {
				navMain.removeClass("active");
				btnMenu.removeClass("active");
				$(this).removeClass("active");
			});
//		}
	}
}); //eof
