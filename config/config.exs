import Config

config :logger, :console,
  max_buffer: 1_000_000,  # Set to a very high number
  discard_threshold: 1_000_000  # Set to a very high number
