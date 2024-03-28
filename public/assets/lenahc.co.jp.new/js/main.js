$(window).on("load", function () {
	const ww = $(window).width();
	fixingPage();
	overflow();
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

	overflow();

	function overflow() {
		$(".scrollContainerWrapper").each(function () {
			const scrollContent = $(this).find(".scrollContent");
			const scrollContentWidth = scrollContent.width();
			const scrollContainer = $(this).find(".scrollContainer");
			const scrollContainerWidth = scrollContainer.width();
			const scrollContainerInnerWidth = scrollContainer.innerWidth();
			const scrollContainerBaseWidth = scrollContainerInnerWidth - ((scrollContainerInnerWidth - scrollContainerWidth) / 2);

			if (scrollContentWidth > scrollContainerBaseWidth) {
				scrollContainer.addClass("overflow");
			} else {
				scrollContainer.removeClass("overflow");
			}
		});
	}

	function fixingPage() {
		const btnMenu = $("#btn-menu");
		const navMain = $("#nav-main");
		const navMainA = $("#nav-main a");
		const navFooter = $("#page-footer");
		const navReserve = $("#nav-reserve");
		const navReserveA = $("#nav-reserve a");
		const btnReserve = $(".btn-reserve");
		btnMenu.removeClass("active");
		const phh2 = $("#page-header").outerHeight(true);
		$("#page-main").css("padding-top", phh2);
		$(".btn-reserve-2").css("height", phh2);

		navReserveA.off("click");
		navReserveA.on("click", function () {
			navReserve.removeClass("active");
		});
		navReserve.off("click");
		navReserve.on("click", function () {
			$(this).removeClass("active");
		});

		if (ww < 768) {
			navMain.hide();

			btnMenu.off("click");
			btnMenu.on("click", function () {
				navReserve.removeClass("active");
				$(this).toggleClass("active");
				navMain.slideToggle();
				$("#body-cover").toggleClass("active");
			});
			navMainA.off("click");
			navMainA.on("click", function () {
				navMain.slideUp();
				btnMenu.removeClass("active");
				$("#body-cover").removeClass("active");
			});
			navMain.off("click");
			navMain.on("click", function () {
				$(this).slideUp();
				btnMenu.removeClass("active");
				$("#body-cover").removeClass("active");
			});
			$("#body-cover").off("click");
			$("#body-cover").on("click", function () {
				navMain.slideUp();
				btnMenu.removeClass("active");
				$(this).removeClass("active");
			});

			btnReserve.off("click");
			btnReserve.on("click", function () {
				navMain.slideUp();
				btnMenu.removeClass("active");
				$("#body-cover").removeClass("active");
				navReserve.toggleClass("active");
			});

		} else {

			btnReserve.off("click");
			btnReserve.on("click", function () {
				//navMain.slideUp();
				//btnMenu.removeClass("active");
				$("#body-cover").removeClass("active");
				navReserve.toggleClass("active");
			});

		}
	}
	// $('.dropdown-btn').on('click', function () {
	// 	$(this).toggleClass('active');
	// 	$(this).next('.dropdown-content').slideToggle();
	// })
}); //eof
