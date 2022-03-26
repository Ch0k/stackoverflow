// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `bin/rails generate channel` command.

import { createConsumer } from "@rails/actioncable"

export default createConsumer()

//var App = App || {};
////App.cable = ActionCable.createConsumer();
//consumer.subscriptions.create('QuestionsChannel', {
//  connected: console.log('connected')
//})
