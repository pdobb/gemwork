# frozen_string_literal: true

desc "Run Brakeman"
task(:brakeman, :output_files) do |_task, args|
  require "brakeman"

  files = args[:output_files].split if args[:output_files]
  result =
    Brakeman.run(
      app_path: ".",
      quiet: true,
      output_files: files,
      print_report: false,
      pager: false)

  if result.warnings.empty?
    puts "\e[32m0 warnings\e[0m"
  else
    puts "\e[31mWarnings found\e[0m"
    puts result.report
    exit 1
  end
end
