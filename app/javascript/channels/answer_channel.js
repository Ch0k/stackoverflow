import consumer from "./consumer"

$(document).on("turbolinks:load", function(e) {
  const question_id = $("#question-channel-provider").data("question-id");
  if (question_id) {
    consumer.subscriptions.create({ channel: "AnswerChannel", question_id: question_id }, {

      connected() {
        this.perform('follow');
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        //console.log(data)
        //console.log(gon.user_id)
        if (gon.user_id !== data["answer"]["user_id"]) {
          $('.answers').append('<p>' + data["answer"]["body"] + '</p>')
          $('.answers').append('<p>Links:</p>')
          $('.answers').append('<div class="div Answer-' + data["answer"]["id"] + '"><p>Counter</p><div class="count">' + data["count"] + '</div><div class="vote"><a data-type="json" data-remote="true" rel="nofollow" data-method="post" href="/answers/' + data["answer"]["id"] + '/vote">vote</a></div><div class="unvote"><a data-type="json" data-remote="true" rel="nofollow" data-method="post" href="/answers/' + data["answer"]["id"] +'/unvote">unvote</a></div><div class="revote hidden"><a data-type="json" data-remote="true" rel="nofollow" data-method="delete" href="/answers/' + data["answer"]["id"] + '/revote">revote</a></div></div>')
        }
      }
    });
  }
})
