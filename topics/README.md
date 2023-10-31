## Running Topics Tutorial

To receive all the logs:
```bash
ruby topics/receive_logs_topic.rb "#"
```

To receive all logs from the facility "kern":
```bash
ruby topics/receive_logs_topic.rb "kern.*"
```

Or if you want to hear only about "critical" logs:

```bash
ruby topics/receive_logs_topic.rb "*.critical"
```

You can create multiple bindings:

```bash
ruby topics/receive_logs_topic.rb "kern.*" "*.critical"
```
And to emit a log with a routing key "kern.critical" type:

```bash
ruby topics/emit_log_topic.rb "kern.critical" "A critical kernel error"
```
