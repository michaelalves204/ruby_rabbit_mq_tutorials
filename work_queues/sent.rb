require_relative '../rabbit_base'

class Sent < RabbitBase
  def call
    connection.start

    channel = connection.create_channel
    # Create and naming new queue
    # Durable: option is used when declaring an exchange or a queue to specify
    # that the exchange or queue should be durable. This option determines whether the exchange or queue survives server restarts.
    queue = channel.queue('task_queue', durable: true)

    message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')
    # Publish message in task_queue
    queue.publish(message, persistent: true)
    puts " [x] Sent #{message}"

    connection.close
  end
end

Sent.new.call
