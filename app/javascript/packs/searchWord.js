$(document).ready(function(){
  document.addEventListener("turbolinks:load", function() {
    var options = {
      getValue: "word",
      url: function(phrase) {
        return "/words/autocomplete?q=" + phrase;
      },
      categories: [
      {
            listLocation: "wordss",
            header: "<strong>Words</strong>",
      }],
      list: {
        match: {
          enabled: true
        }
      }
    };
    console.log("tuboload")
    $('*[data_behavior="autocomplete"]').easyAutocomplete(options);

  })
})