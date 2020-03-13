class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(book)  	  	
    ActionCable.server.broadcast 'book_channel', message: render_message(book), entity: book  #message: message.title
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end
