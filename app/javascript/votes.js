$(document).on('turbolinks:load', function(){
  $('body').on('ajax:success', '.vote', function(event){
    var response = event.detail[0];
    var voteId = '.' + response.klass + '-' + response.id
    $(voteId + ' .count').html( response.score );
    $(voteId + ' .vote').addClass('hidden');
    $(voteId + ' .unvote').addClass('hidden');
    $(voteId + ' .revote').removeClass('hidden');
    $('.flash').html(response.flash)
   })

   $('body').on('ajax:success', '.unvote', function(event){
    var response = event.detail[0];
    var voteId = '.' + response.klass + '-' + response.id
    $(voteId + ' .count').html( response.score );
    $(voteId + ' .vote').addClass('hidden');
    $(voteId + ' .unvote').addClass('hidden');
    $(voteId + ' .revote').removeClass('hidden');
    $('.flash').html(response.flash)
   })

  $('body').on('ajax:success', '.revote', function(event){
    var response = event.detail[0];
    var voteId = '.' + response.klass + '-' + response.id

    $(voteId + ' .count').html(response.score);
    $(voteId + ' .revote').addClass('hidden');
    $(voteId + ' .vote').removeClass('hidden');
    $(voteId + ' .unvote').removeClass('hidden');
    $('.flash').html('')
   })
}); 
