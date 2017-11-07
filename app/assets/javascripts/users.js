// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.



function  emailcl(i) {
	nameId = "emaildetail" + i;
	if (document.getElementById(nameId).style.display == "none")
		document.getElementById(nameId).style.display = "block";
	else
		document.getElementById(nameId).style.display = "none";
}
function detailred(user_id,roleall_id) {
	var nameId = "emaildetailred" + user_id + roleall_id;
	if(document.getElementById(nameId).style.color == "black"){
		document.getElementById(nameId).style.color = "red";
		var arr = [user_id, roleall_id, 0]
	}else{
		document.getElementById(nameId).style.color = "black";
		var arr = [user_id, roleall_id, 1]
	}

	$.ajax({
        url : "/users/action",
        type : "post",
        data : { data_value: JSON.stringify(arr) }
    });
	console.log(JSON.stringify(arr));
}
function detailblack(user_id,roleall_id) {
	var nameId = "emaildetailblack" + user_id + roleall_id;
	if(document.getElementById(nameId).style.color == "black"){
		document.getElementById(nameId).style.color = "red";
		var arr = [user_id, roleall_id, 0]
	}else{
		document.getElementById(nameId).style.color = "black";
		var arr = [user_id, roleall_id, 1]
	}

	$.ajax({
        url : "/users/action",
        type : "post",
        data : { data_value: JSON.stringify(arr) }
    });
	console.log(JSON.stringify(arr));
}

    //<% @user_pq[0].roles.push @roles[2] %>

