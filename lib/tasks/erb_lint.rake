# frozen_string_literal: true

desc "Run erb_lint on **/*.html.erb"
task :erb_lint do
  system("bundle exec erb_lint --format=compact --lint-all") ||
    exit($CHILD_STATUS.exitstatus)
end
