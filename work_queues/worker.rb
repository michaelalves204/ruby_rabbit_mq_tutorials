require_relative '../rabbit_base'

class Worker < RabbitBase
  def call
    connection.start

    channel = connection.create_channel
    queue = channel.queue('task_queue', durable: true)

    # The channel.prefetch(1) method in RabbitMQ is used to control the fair distribution 
    # of messages among multiple consumers. It sets the "prefetch count"
    # for a channel, which specifies how many unacknowledged (unprocessed)
    # messages a consumer can receive at a time.

    puts ' [*] Waiting for messages. To exit press CTRL+C'

    begin
      # option is set to true, which means that manual acknowledgment mode is enabled for the consumer.
      # In manual acknowledgment mode, the consumer is responsible for explicitly
      # acknowledging (or rejecting) messages after processing them.
      # This gives the consumer fine-grained control over message acknowledgment.

      # The consumer will keep running until it's interrupted, such as by
      # a manual termination or by raising an exception.
      # The block: true option is often used in long-running consumer processes.
      queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, body|
        puts "aqui"
        puts " [x] Received '#{body}'"
        # imitate some work
        puts ' [x] Done'
        # is a method that is used to acknowledge the receipt and successful processing
        # of a message by a consumer.
        # This method is part of the acknowledgment mechanism in the Advanced
        # Message Queuing Protocol (AMQP) and is available in client libraries
        # such as Bunny for Ruby.
        channel.ack(delivery_info.delivery_tag)
      end
    rescue Interrupt => _
      connection.close
    end
  end
end

Worker.new.call
