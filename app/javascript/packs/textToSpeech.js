import $ from 'jquery';

	window.speechSynthesis.getVoices();

	function textToSpeech(language,text) {
		if(language=="English") language='en-US'; else language='ja-JP'
	
		// get all voices that browser offers
		var available_voices = window.speechSynthesis.getVoices();
		// this will hold an english voice
		var voice = '';
		// find voice by language locale "en-US"
		// if not then select the first voice
		for(var i=0; i<available_voices.length; i++) {
			if(available_voices[i].lang === language) {
				voice = available_voices[i];
				break;
			}
		}
		if(voice === '') voice = available_voices[0];
	
		// new SpeechSynthesisUtterance object
		var utter = new SpeechSynthesisUtterance();
		utter.rate = 1;
		utter.pitch = 0.5;
		utter.text = text ;
		utter.voice = voice;
	
		// event after text has been spoken
		utter.onend = function() {
			// alert('Speech has finished');
		}
	
		// speak
		window.speechSynthesis.speak(utter);
	}
	
	// list of languages is probably not loaded, wait for it
export function lessonSpeaker(language,text){
		if(window.speechSynthesis.getVoices().length == 0) {
			window.speechSynthesis.addEventListener('voiceschanged', function() {
				textToSpeech(language,text);
			});
		}
		else {
			// languages list available, no need to wait
			textToSpeech(language,text)
		}
	}

	$('.lessonSpeaker').click(function(){
		let text = $(this).attr('word');
		let language = $(this).attr('language');
		lessonSpeaker(language,text);
	})

