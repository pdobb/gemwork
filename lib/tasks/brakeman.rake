# frozen_string_literal: true

desc "Run Brakeman"
task :brakeman do
  require "brakeman"

  result =
    Brakeman.run(
      app_path: ".",
      quiet: true,
      print_report: false,
      pager: false)

  if result.filtered_warnings.empty?
    puts "\e[32m0 warnings\e[0m"
  else
    puts result.report
    abort
  end
end
