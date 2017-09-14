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
        "plugins" : [ "wholerow", "dnd", "sort", "state", "types" ]
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
