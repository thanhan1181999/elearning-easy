$( document ).ready(function() {
  //set value default for progress = 1
  function setStateProFlashCard(pos){
    let percent = pos/parseInt($('#pro-flashCard').attr('aria-valuemax'))*100 
    $('#pro-flashCard').attr('style',`width:${percent}%`)
    $('#pro-flashCard').attr('aria-valuenow',pos)
  }  
  setStateProFlashCard(1);

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
    })
  }
  
  //default run auto 1500
  createCarousel(1500)
  $('.carousel-inner .carousel-item:first-child').addClass('active')
  // change back and front of card
  $('.front-flashcard').click(function(){
    $('.front-flashcard').addClass('fadeout');
    $('.back-flashcard').removeClass('fadeout');
  })
  $('.back-flashcard').click(function(){
    $('.back-flashcard').addClass('fadeout');
    $('.front-flashcard').removeClass('fadeout');
  })

  //auto or paused
  $('#flashcard_paused').click(()=>{
    $('.carousel').carousel('dispose')
    createCarousel(0)
  })
  $('#flashcard_auto').click(()=>{
    $('.carousel').carousel('dispose')
    createCarousel(1500)
  })
});