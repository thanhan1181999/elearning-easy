import $ from 'jquery'
import { lessonSpeaker } from './textToSpeech'
import "bootstrap"

  function flashCardSpeaker(){
    let language = $('.carousel div.active h2').attr('language');
    let text = $('.carousel div.active h2').text();
    lessonSpeaker(language,text);
  }

  //set value default for progress = 1
  function setStateProFlashCard(pos){
    let percent = pos/parseInt($('#pro-flashCard').attr('aria-valuemax'))*100 
    $('#pro-flashCard').attr('style',`width:${percent}%`)
    $('#pro-flashCard').attr('aria-valuenow',pos)
  }  

  function createCarousel(interval){
    // flashcard not auto run
    $('.carousel').carousel({interval});

    // catch even of indecator
    $('.carousel').on('slid.bs.carousel', function () {
      // update state
      //get position active
      let pos = $('.carousel div.active').attr('position');
      //update progress
      $('#pos-flashCard').text(pos+'')
      setStateProFlashCard(pos)
      //speaker
      let language = $('.carousel div.active h2').attr('language');
      let text = $('.carousel div.active h2').text();
      lessonSpeaker(language,text);
    })
  }
  
  //default run auto 2000
  createCarousel(2000)
  $('.carousel-inner .carousel-item:first-child').addClass('active')
  setStateProFlashCard(1);
  flashCardSpeaker();
  $('.carousel-control-prev').addClass('fadeout');
  $('.carousel-control-next').addClass('fadeout');
  // change back and front of card
  $('.front-flashcard').click(function(){
    $('.front-flashcard').addClass('fadeout');
    $('.back-flashcard').removeClass('fadeout');
    flashCardSpeaker();
  })
  $('.back-flashcard').click(function(){
    $('.back-flashcard').addClass('fadeout');
    $('.front-flashcard').removeClass('fadeout');
    flashCardSpeaker();
  })

  //auto or paused
  $('#flashcard_paused').click(()=>{
    $('.carousel').carousel('dispose')
    createCarousel(0)
    $('.carousel-control-prev').removeClass('fadeout');
    $('.carousel-control-next').removeClass('fadeout');
  })
  $('#flashcard_auto').click(()=>{
    $('.carousel').carousel('dispose')
    createCarousel(2000)
    $('.carousel-control-prev').addClass('fadeout');
    $('.carousel-control-next').addClass('fadeout');
  })

