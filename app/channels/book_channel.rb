class BookChannel < ApplicationCable::Channel
  def subscribed
  	stream_from "book_channel"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)  	  	
      ActionCable.server.broadcast 'book_channel', message: data['message']
  end
end
