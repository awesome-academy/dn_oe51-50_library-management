import $ from "jquery";

var idBook = 0;
var quantity = $("input[name=quant]").val();

$(".alert-danger" ).fadeOut(3000);

// Event click quantity block
$(".item .ct-quant").on("click", function (event) {
  var target = event.target,
    index = $(target).index();
  var count = $(this).find("input[name=quant]").val();

  if (index == 0 && count > 0) {
    count = Number(count) - 1;
  } else if (index == 2 && count < 3) {
    count = Number(count) + 1;
  }
  $(this).find("input[name=quant]").val(Number(count));
  quantity = count;
});

// Event click get item block
$(".item").on("click", function (event) {
  idBook = parseInt($(this).index());

  updateQty(idBook, quantity);
});

// Ajax update quantity
function updateQty(id, qty) {
  $.ajax({
    url: "/carts/update",
    data: { id: id + 1, quantity: qty },
    type: "PATCH",
  })
}
