## Running Routing Tutorial

If you want to save only 'warning' and 'error' (and not 'info') log messages to a file, just open a console and type:

```bash
ruby routing/receive_logs_direct.rb warning error
````

If you'd like to see all the log messages on your screen, open a new terminal and do:

```bash
ruby routing/receive_logs_direct.rb info warning error
``````
And, for example, to emit an error log message just type:

```bash
ruby routing/emit_log_direct.rb error "Run. Run. Or it will explode."
``````
