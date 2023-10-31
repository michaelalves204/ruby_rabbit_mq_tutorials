require_relative '../rabbit_base'

class Receiving < RabbitBase
  def call
    # start connection
    connection.start
    # create rabbit_channel which is where most of the API for getting things done resides
    channel = connection.create_channel
    # must declare a queue for us to send to; then we can publish a message to the queue:
    queue = channel.queue('hello')
    # We're about to tell the server to deliver us the messages from the queue.
    # Since it will push us messages asynchronously, we provide a callback
    # that will be executed when RabbitMQ pushes messages to our consumer.
    # This is what Bunny::Queue#subscribe does.
    begin
      puts ' [*] Waiting for messages. To exit press CTRL+C'
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        puts " [x] Received #{body}"
      end
    rescue Interrupt => _
      connection.close

      exit(0)
    end    
  end
end

Receiving.new.call
