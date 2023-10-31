require 'bunny'

class RabbitBase
  def initialize
    @username = "guest"
    @password = "guest"
  end

  def connection
    @connection ||= Bunny.new(
      username: username,
      password: password,
      ## In RabbitMQ, the automatically_recover option is a parameter that can be set when
      # establishing a connection. This option determines whether the connection should
      # automatically attempt to recover in case of network issues, connection failures,
      # or other unexpected events
      automatically_recover: false
    )
  end

  private

  attr_reader :username, :password
end

RabbitBase.new.connection