require_relative '../rabbit_base'

class ReceiveLogsTopic < RabbitBase
  def call
    abort "Usage: #{$PROGRAM_NAME} [binding key]" if ARGV.empty?

    connection.start

    channel = connection.create_channel
    # "topic" is a flexible message routing mechanism that allows messages to be routed based on matching patterns defined by topics
    exchange = channel.topic('topic_logs')
    queue = channel.queue('', exclusive: true)

    ARGV.each do |severity|
      # is used to bind a queue to an exchange with a specified routing key,
      # which determines how messages are routed to that queue based on their severity

      queue.bind(exchange, routing_key: severity)
    end

    puts ' [*] Waiting for logs. To exit press CTRL+C'

    begin
      queue.subscribe(block: true) do |delivery_info, _properties, body|
        puts " [x] #{delivery_info.routing_key}:#{body}"
      end
    rescue Interrupt => _
      channel.close
      connection.close

      exit(0)
    end
  end
end

ReceiveLogsTopic.new.call
