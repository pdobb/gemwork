# frozen_string_literal: true

desc "Run eslint on app/javascript"
task :eslint do
  command = "npx eslint app/javascript"
  success = system(command)

  if success
    puts "\e[32m0 errors\e[0m"
  else
    abort
  end
end
