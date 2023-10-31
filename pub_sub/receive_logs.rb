require_relative '../rabbit_base'

class ReceiveLogs < RabbitBase
  def call
    connection.start

    channel = connection.create_channel
    exchange = channel.fanout('logs')
    # exclusive: true in RabbitMQ declares a queue that can only be accessed by the connection that created it, and it's deleted when the connection is closed.
    queue = channel.queue('', exclusive: true)

    queue.bind(exchange)

    puts ' [*] Waiting for logs. To exit press CTRL+C'

    begin
      queue.subscribe(block: true) do |_delivery_info, _properties, body|
        puts " [x] #{body}"
      end
    rescue Interrupt => _
      channel.close
      connection.close
    end
  end
end

ReceiveLogs.new.call
