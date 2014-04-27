guard 'rspec' do
  # run every updated spec file
  watch(%r{^spec/.+_spec\.rb$})
  # run the lib specs when a file in lib/ changes
  watch(%r{^(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
end
