puts "HOBSON SETUP HOOK"
sleep 3
ENV['HOBSON_SETUP_HOOK_RUN'] = "true"

Hobson.logger.info "RUBY_VERSION: #{RUBY_VERSION}"

execute "which ruby"
execute "ruby --version"
