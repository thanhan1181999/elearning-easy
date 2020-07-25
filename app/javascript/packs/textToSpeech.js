import $ from 'jquery';

export function	textToSpeech(language,text) {
		return function(){
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
			window.speechSynthesis.speak(utter);
		}
	}

	// list of languages is probably not loaded, wait for it
	$( document ).ready(function() {
			console.log( "ready!" );
			window.speechSynthesis.getVoices();
			$('.lessonSpeaker').click(function(){
				let text = $(this).attr('word');
				let language = $(this).attr('language');
				textToSpeech(language,text)();
			})
	});

