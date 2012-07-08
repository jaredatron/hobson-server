puts "HOBSON SAVE ARTIFACTS HOOK"
root.join('log').children.each{ |path| save_artifact path }
sleep 2
ENV['HOBSON_SAVE_ARTIFACTS_HOOK_RUN'] = "true"
