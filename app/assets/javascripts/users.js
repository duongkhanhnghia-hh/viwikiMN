// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function  line_center() {
	var height = 0;
	var tableTitHeight = document.getElementById("tableTit").clientHeight + 5;
	if (document.getElementById("div_pq").clientHeight 
		< document.getElementById("div_npq").clientHeight){
		height = document.getElementById("div_npq").clientHeight + tableTitHeight  + 10;
	}
	else
		height = document.getElementById("div_pq").clientHeight + tableTitHeight  + 10;
		document.getElementById("line_center").style.height = height.toString() + "px";
		document.getElementById("line_center").style.marginTop = -tableTitHeight.toString() + "px";
}
window.onload = line_center;

function  emailcl(i) {
	nameId = "emaildetail" + i;
	if (document.getElementById(nameId).style.display == "none"){
		document.getElementById(nameId).style.display = "block";
		document.getElementById(nameId+"hr").style.display = "block";
	}
	else{
		document.getElementById(nameId).style.display = "none";
		document.getElementById(nameId+"hr").style.display = "none";
	}
	line_center();
}
function detail(user_id,roleall_id) {
	var nameId = "emaildetail" + user_id + roleall_id;
	var checkbox = "checkbox" + user_id + roleall_id;
	if(document.getElementById(nameId).style.color == "black"){
		document.getElementById(nameId).style.color = "red";
		var arr = [user_id, roleall_id, 0];
	}else{
		document.getElementById(nameId).style.color = "black";
		var arr = [user_id, roleall_id, 1];
	}

	$.ajax({
        url : "/users/action",
        type : "post",
        data : { data_value: JSON.stringify(arr) }
    });
	console.log(arr);
}
function choose(user_id, role){
	console.log(user_id);
	console.log(role);
	var arr = [user_id, role];
	$.ajax({
        url : "/users/chooseRole",
        type : "post",
        data : { data_value: JSON.stringify(arr) }
    });
	console.log(user_id);
	console.log(role);

}

    //<% @user_pq[0].roles.push @roles[2] %>

