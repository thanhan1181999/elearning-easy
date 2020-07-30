import { textToSpeech } from './textToSpeech'

  function flashCardSpeaker(){
    let language = $('#carousel-flash-card div.active h2').attr('language')
    let text = $('#carousel-flash-card div.active h2').text()
    return textToSpeech(language,text)
  }

  //set value default for progress = 1
  function setStateProFlashCard(pos){
    let percent = pos/parseInt($('#pro-flashCard').attr('aria-valuemax'))*100 
    $('#pro-flashCard').attr('style',`width:${percent}%`)
    $('#pro-flashCard').attr('aria-valuenow',pos)
  }  

  function createCarousel(interval){
    $('#carousel-flash-card').carousel({interval})
    $('#carousel-flash-card').carousel('pause')
    // catch even of indecator
    $('#carousel-flash-card').on('slid.bs.carousel', function () {
      //get position active to update progress
      let pos = $('#carousel-flash-card div.active').attr('position');
      $('#pos-flashCard').text(pos+'')
      setStateProFlashCard(pos)
      //speaker
      flashCardSpeaker()();
    })
  }

$(document).ready(function(){
  window.speechSynthesis.getVoices();
  // constructor 
  $('#carousel-flash-card .carousel-inner .carousel-item:first-child').addClass('active')
  setStateProFlashCard(1);
  createCarousel(2000)
  
  // change back and front of card
  $('.front-flashcard').click(function(){
    $('.front-flashcard').addClass('fadeout');
    $('.back-flashcard').removeClass('fadeout');
    flashCardSpeaker()();
  })
  $('.back-flashcard').click(function(){
    $('.back-flashcard').addClass('fadeout');
    $('.front-flashcard').removeClass('fadeout');
    flashCardSpeaker()();
  })

  //auto or paused
  $('#flashcard_paused').click(()=>{
    $('.carousel').carousel('pause')
    $('.carousel-control-prev').removeClass('fadeout');
    $('.carousel-control-next').removeClass('fadeout');
  })
  $('#flashcard_auto').click(()=>{
    $('.carousel').carousel('cycle')
    $('.carousel-control-prev').addClass('fadeout');
    $('.carousel-control-next').addClass('fadeout');
  })
  ///click to change state remember or not rememner
  $('.flashcard_remember_active_word').click(function(){
    let flashcard_remember_active_word =$(this)
    let word_id = $(this).attr("word_id")
    let state = $(this).attr("state")
    $.ajaxSetup({
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    });
    let method = state=="true" ? "DELETE" : "POST"
    let url = state=="true" ? `/studies/delete` : `/studies`
    let data = {
      study:{
        user_id : $('#current_user_id').text(),
        word_id
      }
    }
    $.ajax({
      method, url, data, dataType: 'script'
    })
    .done(function(){
      state = state=="true" ? "false" : "true"
      flashcard_remember_active_word.attr("state",state)
      flashcard_remember_active_word.text(state=="true" ? "state : Remembered" : "state : Not remember")
    })
  })
})

