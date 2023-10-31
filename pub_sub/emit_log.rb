require_relative '../rabbit_base'

class EmitLog < RabbitBase
  def call
    connection.start

    channel = connection.create_channel

    # an exchange is a message routing component that directs messages
    # from producers to one or more queues. It acts as a message dispatcher,
    # determining how messages should be distributed based on their routing keys
    # and the exchange type, such as direct, topic, fanout, or headers.
    # Exchanges are fundamental for controlling the routing and delivery of messages
    # within the RabbitMQ messaging system.

    # There are a few exchange types available: direct, topic, headers and fanout.
    # Direct Exchange: Routes messages to queues based on exact matching of the message's routing key.
      # * (asterisk): Represents a single word or a single word fragment in a routing key.
      # # (hash or pound sign): Represents one or more words or word fragments in a routing key.
    # Topic Exchange: Routes messages to queues based on wildcard patterns in the message's routing key.
    # Headers Exchange: Routes messages to queues based on header attributes in the message.
    # Fanout Exchange: Broadcasts messages to all queues bound to it, ignoring routing keys.

    exchange = channel.fanout('logs')

    message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

    exchange.publish(message)
    puts " [x] Sent #{message}"

    connection.close
  end
end

EmitLog.new.call
