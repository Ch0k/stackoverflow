import consumer from "./consumer"

$(document).on("turbolinks:load", function(e) {
  const question_id = $("#question-channel-provider").data("question-id");
  if (question_id) {
    consumer.subscriptions.create({ channel: "CommentChannel", question_id: question_id }, {

      connected() {
        this.perform('follow');
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log(data)
        
        $('.comments').append('<div class="comment-body"><span>' + data["user"]["email"] + '</span><span> commented:</span><span>' + data["comment"]["body"] + '</span></div>')
      }
    });
  }
})
