// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
//= require jstree/dist/jstree

window.cat_selector = "#categories";

$(document).ready(function () {
    $(cat_selector) .on('move_node.jstree', function (e, data) {
		    var ref = $(cat_selector).jstree(true);
        var parent_id = null;
        if (data.parent !== '#') {
            parent_id = ref.get_node(data.parent).data.categoryId;
        }

        var payload = {'parent_id': parent_id};

        sel = ref.get_selected();

            if(!sel.length) {
                return false;
            }

        var node = ref.get_node(sel[0]);

        $.ajax({
            type: "POST",
            url: Routes.category_path(node.data.categoryId),
            dataType: "json",
            data: {"_method": "patch", "name": node.text},
            success: function () {
                console.log(node.data.categoryId);
            }
        });


        $.post(Routes.reparent_category_path(data.node.data.categoryId), payload, function (data) {
            var ref = $(cat_selector).jstree(true);
            ref.open_node(this.parent);
        }.bind(data));
    });

    $(cat_selector).jstree({
        "core": {
            "multiple": false,
            check_callback: function (operation, node, node_parent, node_position, more) {
                // operation can be 'create_node', 'rename_node', 'delete_node', 'move_node' or 'copy_node'
                // in case of 'rename_node' node_position is filled with the new node name
                return gon.editable && !(operation === 'move_node' && (node_parent.parent === null || node.parent === "#"));
            },
            "themes" : { "stripes" : false }
        },
        "types" : {
            "default" : {
                "icon" : "fa fa-folder icon-state-warning icon-lg"
            }
        },
        "plugins" : [ "wholerow", "dnd", "sort", "state", "types" ],
        //,"contextmenu" contextmenu : {
        //     "items": function (node) {
        //         return {
        //             "view": {
        //                 label: "View",
        //                 action: function (obj) {
        //                     window.open("/users/files/view/" + node.id);
        //                 }
        //             },
        //             "rename": {
        //                 label: "Rename",
        //                 action: function (obj) {
        //                     $j("#jstree").jstree(true).edit(node)
        //                 }
        //             },
        //             "create": {
        //                 label: "Create New",
        //                 action: function () {
        //                     createNode(node);
        //                 }
        //             },
        //             "delete": {
        //                 label: "Delete",
        //                 action: function () {
        //                     if (confirm("Really delete " + node.text + "?")) {
        //                         deleteNode(node);
        //                     }
        //                 },
        //                 separator_before: true
        //             }
        //         }
        //     }
        //}
    });

    $("#upload_datafile").on("change", function() {
        $("#upload-form").submit();
    })
});

function extract_excel() {
    var ref = $(cat_selector).jstree(true),
        sel = ref.get_selected();

    if(!sel.length) {
        return false;
    }

    var node = ref.get_node(sel[0]);

    console.log(Routes);
    console.log(sel);
    console.log(node);

    $.ajax({
        type: "POST",
        url: Routes.export_category_path(node.data.categoryId),
        dataType: "json",
        data: {"_method": "export"},
        success: function () {
            console.log("success");
        }
    });
}

function view_posts() {
    var ref = $(cat_selector).jstree(true),
        sel = ref.get_selected();

    if (!sel.length) {
        return false;
    }
    sel = sel[0];
    var category_id = ref.get_node(sel).data.categoryId;
    var r = "/categories/" + category_id + "/posts";
    open(r, '_self');
    return false;
}

function view_description(){
    var ref = $(cat_selector).jstree(true),
        sel = ref.get_selected();

    if (!sel.length) {
        return false;
    }
    sel = sel[0];
    var category_id = ref.get_node(sel).data.categoryId;
    var r = "/categories/" + category_id + "/description";
    open(r, '_self');
    return false;
}

function createPost(){
    document.getElementById("form_post").style.display = "block";
    document.getElementById("noPost").style.display = "none";
}

function editPost(){
    document.getElementById("tittle").value = document.getElementById("post_tittle").innerText;
    document.getElementById("post").value = document.getElementById("post_body").innerText;
    document.getElementById("form_post").style.display = "block";
    document.getElementById("havePost").style.display = "none";
}

function create_post(category_id){
    var post = document.getElementById("post").value;
    var tittle = document.getElementById("tittle").value;
    if(post != "" && tittle != ""){
    var arr = [category_id, post, tittle];
    $.ajax({
        url : "/categories/create-post",
        type : "post",
        data : { data_value: JSON.stringify(arr) }, success: function(){
            location.reload();
        }
        });
    } else if (tittle == "") {
        document.getElementById("requireTit").innerHTML = "Vui lòng tạo Title!";
    }else{
        document.getElementById("requirePost").innerHTML = "Vui lòng tạo Post!";
    }
}

function create_child() {
		var ref = $(cat_selector).jstree(true),
				sel = ref.get_selected();

		if (!sel.length) {
        return false;
    }

		sel = sel[0];
		sel = ref.create_node(sel, 'Tên chuyên mục');

		if (sel) {
		    ref.edit(sel, null, function(node, status, cancelled) {
            if (cancelled || !status) {
                ref.delete_node(node);
                return;
            }

            var parent_id = ref.get_node(node.parent).data.categoryId;
            var payload = {name: node.text, 'parent_id': parent_id};

            $.post(Routes.categories_path(), payload, function (data) {
                if (this.data === null) {
                    this.data = {};
                }

                this.data.categoryId = data.id;
            }.bind(node));

        });
		}

    return false;
}

function rename_node() {
		var ref = $(cat_selector).jstree(true),
				sel = ref.get_selected();

		if(!sel.length) {
        return false;
    }

		sel = sel[0];

		ref.edit(sel, null, function(node, status, cancelled) {
        if (cancelled || !status) {
            return;
        }

        $.ajax({
            type: "POST",
            url: Routes.category_path(node.data.categoryId),
            dataType: "json",
            data: {"_method": "patch", "name": node.text},
            success: function () {
            }
        });
    });


    return false;
}

function delete_node() {
		var ref = $(cat_selector).jstree(true),
				sel = ref.get_selected();

		if(!sel.length) {
        return false;
    }

    var node = ref.get_node(sel[0]);

    if (node.parent === '#') {
        return;
    }

    $.ajax({
        type: "POST",
        url: Routes.category_path(node.data.categoryId),
        dataType: "json",
        data: {"_method": "delete"},
        success: function () {
            var ref = $(cat_selector).jstree(true);
            ref.delete_node(node.id);
        }.bind(node)
    });

    return false;
}

function uploadfile() {
    $("#upload_datafile").trigger("click");
}

function undo() {
    $.ajax({
        type: "GET",
        url: Routes.undo_path(),
        dataType: "json",        
        success: function () {
            console.log("success");
        }
    });

}

window.onload = init;
function init() {
    document.onmousemove = getCursorXY;
}
$(document).ready( function(){
    $(window).contextmenu( function( e ){
        var x,y;
        x = (window.Event) ? e.pageX : event.clientX + (document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft);
        y = (window.Event) ? e.pageY : event.clientY + (document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop);


    });
});
$(document).mousedown(function(event) {

});

function edit_save(id){
    var edit_save = document.getElementById("edit_save");
    if (edit_save.innerText == 'SỬA'){
        edit_save.innerText = 'LƯU';
        document.getElementById("icon_edit").className = "fa fa-save";
        document.getElementById("description").style.display = 'none';
        document.getElementById("edit_description").style.display = 'block';
    }else{
        edit_save.innerText = 'SỬA';
        document.getElementById("icon_edit").className = "fa fa-edit";
        document.getElementById("description").style.display = 'block';
        document.getElementById("edit_description").style.display = 'none';
        var description = document.getElementById("description_area").value;
        document.getElementById("description_text").innerHTML = description;
        var arr = [id, description];
        $.ajax({
        url : "/categories/edit_description",
        type : "post",
        data : { data_value: JSON.stringify(arr) }
        });
    }
    
}

function choose_view(id){
    console.log('adada');
    if(id == 1){
        document.getElementById('list_tree').style.display ='block';
        document.getElementById('list_simple').style.display ='none';
        document.getElementById('list_entries').style.display ='none';
    }
    else if (id == 2){
        document.getElementById('list_tree').style.display ='none';
        document.getElementById('list_simple').style.display ='block';
        document.getElementById('list_entries').style.display ='none';
    }else{
        document.getElementById('list_tree').style.display ='none';
        document.getElementById('list_simple').style.display ='none';
        document.getElementById('list_entries').style.display ='block';
    }

}
function create_comment(category_id){
    
    var comment = document.getElementById("comment").value;
    if(comment != ""){
    var arr = [category_id, comment];
    console.log("aaaaaaa");
    $.ajax({
        url : "/categories/create-comment",
        type : "post",
        data : { data_value: JSON.stringify(arr) }, success: function(){
            location.reload();
        }
        });
    } else{
        document.getElementById("requireComment").innerHTML = "Vui lòng nhập comment!"
    }
}

