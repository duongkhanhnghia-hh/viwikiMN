// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function choose(user_id, role){
	console.log(document.getElementById(user_id).innerHTML);
	if(role =='Admin' || role == 'User' || role=='None')
		document.getElementById(user_id).innerHTML=role;
	else if (document.getElementById(user_id).innerHTML !='admin' 
		 && document.getElementById(user_id).innerHTML !='Admin')
		document.getElementById(user_id).innerHTML='Editor';
	var arr = [user_id, role];
	$.ajax({
        url : "/users/chooseRole",
        type : "post",
        data : { data_value: JSON.stringify(arr) }
    });

}
function detailroles(){
	alert("Welcome to Roles Details!                                                                      Admin là người có thể phân quyền cho các tài khoản và chỉnh sửa tất cả các chuyên mục, Editor có quyền chỉnh sửa chuyên mục mà checkbox người đó được tích, User là tài khoản thường không có quyền gì nhưng đã được Admin phân quyền, None là tài khoản mới đăng ký chưa được phân quyền");

}
window.onload = function() {
var email = document.getElementById('email').children[0].textContent;
	if( email.length > 25){
		index = email.indexOf("@");
		var emailSub = email.substring(0,25 - (email.length - index)) + "..." + email.substring(index, email.length);
		document.getElementById('email').children[0].textContent = emailSub; 
	}
};

    //<% @user_pq[0].roles.push @roles[2] %>

$(document).ready(function () {
          if (!$.browser.webkit) {
              $('.slimScrollDiv').html('<p>Sorry! Non webkit users. :(</p>');
          }
      });