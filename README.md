## RabbitMQ Features

#### Running bundle install

```
bundle install
```

#### You don't have rabbitmq installed ?
[rabbit install](https://www.rabbitmq.com/download.html)

#### Use Docker for running RabbitMQ

```bash
sudo docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:management
```
#### After install or running in docker
#### Access the rabbit [dashboard](http://localhost:15672)
#### The default username and passowrd is **guest**
