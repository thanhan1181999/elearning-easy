$('document').ready(function(){
  var words = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/words/autocomplete?q=%QUERY',
      wildcard: '%QUERY'
    }
  });
  $('*[data_behavior="autocomplete"]').typeahead(null, {
    source: words
  });
})