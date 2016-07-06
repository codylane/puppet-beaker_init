require_relative "helpers"

desc "Starts up the VM, provisions and keeps it running so you can run more tests"
task :create do
  ENV['BEAKER_destroy'] = 'no'

  if ENV['PUPPET_INSTALL_VERSION'].nil?
    ENV['PUPPET_INSTALL_VERSION'] = '1.4.1'
    ENV['PUPPET_INSTALL_TYPE'] = 'agent'
  end

  Rake::Task[:validate].invoke
  Rake::Task[:spec].invoke
  Rake::Task[:beaker].invoke

  File.write($PROVISIONED_FILENAME, '')
end
