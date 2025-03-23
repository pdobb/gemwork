# frozen_string_literal: true

desc "Run prettier on **/*.{js,yml,md}"
task :prettier do
  success = system("npx prettier . --check")

  abort unless success
end
