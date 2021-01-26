# frozen_string_literal: true

# vars
app_dir = File.expand_path('..', __dir__)
shared_dir = "#{app_dir}/shared"

# Specifies the `environment` that Puma will run in.
environment ENV.fetch('RAILS_ENV') { 'development' }

# pidfile and state
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"

# Threads for serving requests
threads ENV.fetch('PUMA_STARTING_THREADS') { 1 }, ENV.fetch('PUMA_MAX_THREADS') { 1 }

# Workers (cpu cores)
workers ENV.fetch('PUMA_WEB_CONCURRENCY') { 1 }
preload_app!

# Port
port 5000

# Debugging
debug

activate_control_app