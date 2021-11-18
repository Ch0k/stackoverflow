"use strict";

//document.addEventListener('turbolinks:load', function() {
//  var controls = document.querySelectorAll('.form_inline_link')
//
//  if (controls.length) {
//    for (var i = 0; i < controls.length; i++ ) {
//      controls[i].addEventListener('click', formInlineLinkHandler)
//    }
//  }
$(document).on('turbolinks:load', function () {
  $('.answers').on('click', '.edit-answer-link', function (e) {
    e.preventDefault();
    $(this).hide();
    var answerId = $(this).data('answerId');
    console.log(answerId);
    $('form#edit-answer-' + answerId).removeClass('hidden');
  });
});