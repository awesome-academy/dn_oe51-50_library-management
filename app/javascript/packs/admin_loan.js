import $ from "jquery";

var parent = $(".ddlViewBy").parents("tr");

parent.map(function (item) {
  let el = parent[item].querySelector(".ddlViewBy");
  el.value = el.dataset.status;
  if (el.value != 3){
    parent[item].querySelector(".btn-group").style.display = "none";
  }
});
