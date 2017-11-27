// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function choose(user_id, role){
	if(role =='Admin' || role == 'User' || role=='None')
		document.getElementById(user_id).innerHTML=role;
	else if (document.getElementById(user_id).innerHTML !='admin')
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

    //<% @user_pq[0].roles.push @roles[2] %>

