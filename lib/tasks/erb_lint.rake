# frozen_string_literal: true

desc "Run erb_lint on **/*.html.erb"
task :erb_lint do
  success = system("bundle exec erb_lint --format=compact --lint-all")

  abort unless success
end
