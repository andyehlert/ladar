/**
 * 
 */

function LoadPage() {
	
	$('.menu-button').unbind("click");
	
	$('#si-button').on("click", function() {
		$('.content').load("pages/user_login.jsp");
		LoadPage();
		return false;
	});
	
	$('#hiw-button').on("click", function() {
		$('.content').load("pages/how_it_works.jsp");
		LoadPage();
		return false;
	});
	
	$('#cu-button').on("click", function() {
		$('.content').load("pages/contact_us.jsp");
		LoadPage();
		return false;
	});
}