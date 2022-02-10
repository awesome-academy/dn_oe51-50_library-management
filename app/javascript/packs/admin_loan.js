import $ from "jquery";

var parent = $(".ddlViewBy").parents("tr");

parent.map(function (item) {
  let el = parent[item].querySelector(".ddlViewBy");
  el.value = el.dataset.status;

  if (el.value != 3){
    parent[item].querySelector(".btn-group").style.display = "none";
  }else{
    parent[item].querySelector(".btn-group").style.display = "block";
  }
});

$(".ddlViewBy").on("change", function() {
  let subparent = $(this).parents("tr");
  var status_loans = this.value;
  var id_loans = subparent[0].dataset.id;

  $.ajax({
    url: "/admin/loaned_books/update_status",
    data: {id: id_loans, status: status_loans},
    type: "PATCH",
    success: function(result){
      check_error_update(result["error"]);
    }
  });
});

$(".btn-reject").click(function(){
  let item = $(this);
  proceed_confirm(4, item);
})


$(".btn-accept").click(function(){
  let item = $(this);
  proceed_confirm(0, item);
})

function proceed_confirm(status, item) {
  let subparent = item.parents("tr");
  var id_loans = subparent[0].dataset.id;

  $.ajax({
    url: "/admin/loaned_books/update_status",
    data: {id: id_loans, status: status},
    type: "PATCH",
    success: function(result){
      check_error_update(result["error"]);
    }
  });
}

function check_error_update(error) {
  if(error != null){
    $("#notice_err1").show();
    $("#notice_err1").text(error);
  }else{
    $("#notice_err1").hide();
  }
}
