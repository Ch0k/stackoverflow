$(document).on('turbolinks:load', function(){
  $('body').on('ajax:success', '.voting', function(event){
    var response = event.detail[0];
    var id = response.id
    var questionId = '.question-' + id
    var voteId = '.vote-count-question-' + id
    $(questionId + ' .vote').addClass('hidden');
    $(questionId + ' .vote-count').html(response.votes);
    //$(voteId + ' .rating').html('<p>' + 'Rating: ' + response.score + '</p>');
    $(questionId + ' .delete-link').removeClass('hidden');
    $(questionId + ' .add-link').addClass('hidden');
    $(questionId + ' .unvoting').addClass('disabled')
    $(questionId + ' .rating').addClass('hidden')
    $(questionId + ' .new-rating').html(response.rating)


    //$('.flash').html(response.flash)
  })

  $('body').on('ajax:success', '.delete-voting', function(event){
    var response = event.detail[0];
    var id = response.id
    var questionId = '.question-' + id
    var voteId = '.vote-count-question-' + id
    $(questionId + ' .delete-link').addClass('hidden');
    $(questionId + ' .add-link').removeClass('hidden');
    $(questionId + ' .vote-count').html(response.votes);
    $(questionId + ' .unvoting').removeClass('disabled')
    $(questionId + ' .vote').addClass('hidden');
    $(questionId + ' .rating').addClass('hidden')
    $(questionId + ' .new-rating').html(response.rating)

    //$('.flash').html(response.flash)
  })  

  $('body').on('ajax:success', '.unvoting', function(event){
    var response = event.detail[0];
    var id = response.id
    var questionId = '.question-' + id
    $(questionId + ' .unvote').addClass('hidden');
    $(questionId + ' .unvote-count').html(response.unvotes);
    $(questionId + ' .add-unvote-link').addClass('hidden');
    $(questionId + ' .delete-unvote-link').removeClass('hidden');
    $(questionId + ' .voting').addClass('disabled')
    $(questionId + ' .rating').addClass('hidden')
    $(questionId + ' .new-rating').html(response.rating)

  })

  $('body').on('ajax:success','.delete-unvoting', function(event){
    var response = event.detail[0];
    var id = response.id
    var questionId = '.question-' + id
    $(questionId + ' .unvote').addClass('hidden');
    $(questionId + ' .delete-unvote-link').addClass('hidden');
    $(questionId + ' .add-unvote-link').removeClass('hidden');
    $(questionId + ' .unvote-count').html(response.votes);
    $(questionId + ' .voting').removeClass('disabled')
    $(questionId + ' .rating').addClass('hidden')
    $(questionId + ' .new-rating').html(response.rating)
  })
}); 
