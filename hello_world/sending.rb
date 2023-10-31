require_relative '../rabbit_base'

class Sending < RabbitBase
  def call
    connection.start

    channel = connection.create_channel

    queue = channel.queue('hello')
    # To send, we must declare a queue for us to send to; then we can publish a message to the queue:
    channel.default_exchange.publish('Hello World!', routing_key: queue.name)

    puts " [x] Sent 'Hello World!'"
    # finish connection
    connection.close
  end
end

Sending.new.call
