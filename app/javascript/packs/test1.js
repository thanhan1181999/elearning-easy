import $ from 'jquery'
import { lessonSpeaker } from './textToSpeech'
import 'bootstrap'

//contructor
let length = parseInt($('.carousel-inner .carousel-item:last-child').attr('position'))+1
let currentrue = 0
let currentfalse = 0
function getActive(){
  return parseInt($('.carousel-inner .active').attr('position'))+1
}
function getActiveWord(){
  let word=$('.carousel-inner .active .active-word').text();
  let language=$('.carousel-inner .active .active-word').attr('language')
  return {language,word}
}

function checkAnswer(choiced){
  let answer = choiced.attr('class')
  return (answer.includes('true'))
}
function updateView(choiced){
  $('#carouselTestControls .true').addClass('bg-success')
  if (checkAnswer(choiced)) { 
    currentrue++
  }
  else {
    currentfalse++
    choiced.addClass('bg-danger')
  }
  $('#carouselTestControls #current-true').text(currentrue+'');
  $('#carouselTestControls #current-false').text(currentfalse+'');
  lessonSpeaker(getActiveWord().language,getActiveWord().word)
}
//-------------
function nextQuestion(){
  $('#carouselTestControls').carousel('next')
}
//when invoke next slide start , delete background-true-answer, user not see
$('#carouselTestControls').on('slide.bs.carousel', function () {
  $('#carouselTestControls .true').removeClass('bg-success');
})
//after next slide call completed, the acitve is correctly
$('#carouselTestControls').on('slid.bs.carousel', function () {
  $('#carouselTestControls #current-active').text((getActive())+'');
})

//handle click
$('#carouselTestControls .choices').click(function(){
  updateView($(this));
  if(getActive()==length){
    alert(currentfalse +" false/ "+currentrue+" true ")
    return;
  }
  setTimeout(nextQuestion,2000);
})

//create carousel
$('#carouselTestControls').carousel()
$('#carouselTestControls').carousel('pause')
$('#carouselTestControls #current-active').text((getActive())+'')

