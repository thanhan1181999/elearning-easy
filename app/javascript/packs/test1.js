import { textToSpeech } from './textToSpeech'

$(document).ready(function(){
  //contructor
  let length = parseInt($('#carousel-test-1 .carousel-inner .carousel-item:last-child').attr('position'))+1
  let currentrue = 0
  let currentfalse = 0
  let currentMiss = 0
  let answerThisQuestion = false

  function updateView(choiced){
    $('#carousel-test-1 .true').addClass('bg-success')
    if (checkAnswer(choiced)) { 
      currentrue++
    }
    else {
      currentfalse++
      choiced.addClass('bg-danger')
    }
    $('#carousel-test-1 #current-true').text(currentrue+'')
    $('#carousel-test-1 #current-false').text(currentfalse+'')
    textToSpeech(getActiveWord().language,getActiveWord().word)()
    answerThisQuestion=true
  }

  //create carousel
  $('#carousel-test-1').carousel()
  $('#carousel-test-1').carousel('pause')
  $('#carousel-test-1 #current-active').text((getActive())+'')
  clockWaitAnswer(5000)
  //when invoke next slide start , delete background-true-answer, user not see
  $('#carousel-test-1').on('slide.bs.carousel', function () {
    $('#carousel-test-1 .true').removeClass('bg-success');
    $('#pro-test1').attr('style',`width:100%`)
    answerThisQuestion = false
    $('#carousel-test-1 #current-miss').text(currentMiss+'')
  })

  function clockWaitAnswer(time){
    let fix_time=time
    let action = setInterval(function(){
      $('#pro-test1-second').text(`${Math.floor(time/1000)} s`)
      $('#pro-test1').attr('style',`width:${time/fix_time*100}%`)
      $('#pro-test1').attr('aria-valuenow',time)
       //check user choiced
       if (answerThisQuestion) {
        clearInterval(action)
      } else if(time==0){
        currentMiss+=1  
        $('#carousel-test-1 .true').addClass('bg-success')
        clearInterval(action)
        // check end
        if(getActive()==length){
          viewResultByModal()
          return;
        }
        setTimeout(nextQuestion,2000);
      }
      time=time-100
    },100)
  }

  //after next slide call completed, the acitve is correctly
  $('#carousel-test-1').on('slid.bs.carousel', function () {
    $('#carousel-test-1 #current-active').text((getActive())+'');
    clockWaitAnswer(5000)
  })

  function viewResultByModal(){
    $('#myModal').modal('show')
    $('#myModal .modal-body').text(currentfalse +" false/ "+currentrue+" true /"+ currentMiss+" miss")
  }
  
  //handle click
  $('#carousel-test-1 .choices').click(function(){
    if(!answerThisQuestion){
      updateView($(this));
      updateDb($(this));
      if(getActive()==length){
        viewResultByModal()
        return;
      }
      setTimeout(nextQuestion,2000);
    }
  })
})











function getActive(){
  return parseInt($('#carousel-test-1 .carousel-inner .active').attr('position'))+1
}

function getActiveWord(){
  let word=$('#carousel-test-1 .carousel-inner .active .active-word').text();
  let id=$('#carousel-test-1 .carousel-inner .active .active-word').attr('id');
  let language=$('#carousel-test-1 .carousel-inner .active .active-word').attr('language')
  return {language,word,id}
}

function checkAnswer(choiced){
  let answer = choiced.attr('class')
  return (answer.includes('true'))
}

function nextQuestion(){
  $('#carousel-test-1').carousel('next')
}

function updateDb(choiced){
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
  let method = checkAnswer(choiced) ? "POST" : "DELETE"
  let url = checkAnswer(choiced) ? `/studies`: `/studies/delete`
  let data = {
    study:{
      user_id : $('#current_user_id').text(),
      word_id : getActiveWord().id
    }
  }
  $.ajax({
    method, url, data, dataType: 'script'
  });
}





