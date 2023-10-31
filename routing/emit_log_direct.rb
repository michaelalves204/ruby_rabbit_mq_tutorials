require_relative '../rabbit_base'

class EmitLogDirect < RabbitBase
  def call
    connection.start

    channel = connection.create_channel

    # Direct Exchange: Routes messages to queues based on exact matching of the message's routing key.
      # * (asterisk): Represents a single word or a single word fragment in a routing key.
      # # (hash or pound sign): Represents one or more words or word fragments in a routing key.

    exchange = channel.direct('direct_logs')

    severity = ARGV.shift || 'info'

    message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')
    
    exchange.publish(message, routing_key: severity)

    puts " [x] Sent '#{message}'"
    
    connection.close
  end
end

EmitLogDirect.new.call
