document.addEventListener("turbolinks: load", function() {
  var options = {
    data: ["John", "Paul", "George", "Ringo"]
  };
  console.log("tuboload")
  $('*[data_behavior="autocomplete"]').easyAutocomplete(options);
});