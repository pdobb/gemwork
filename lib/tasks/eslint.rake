# frozen_string_literal: true

desc "Run eslint on app/javascript"
task :eslint do
  command = "npx eslint app/javascript"
  success = system(command)

  if success
    puts "\e[32m0 errors, 0 warnings\e[0m"
  else
    exit 1
  end
end
