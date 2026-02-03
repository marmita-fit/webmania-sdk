ExUnit.start()
# Start Plug's logger for Bypass expectations to work nicely in tests
Application.ensure_all_started(:plug)
Application.ensure_all_started(:bypass)
