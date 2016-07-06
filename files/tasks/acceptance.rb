require_relative "helpers"

desc "Acceptance tests"
namespace :acceptance do

  task :tests do

    if ENV['PUPPET_INSTALL_VERSION'].nil?
      ENV['PUPPET_INSTALL_VERSION'] = '1.4.1'
      ENV['PUPPET_INSTALL_TYPE'] = 'agent'
      ENV['BEAKER_provision'] = 'yes'
    end

    set_provisioned_env(has_been_provisioned)
    Rake::Task[:beaker].invoke

    File.write($PROVISIONED_FILENAME, '')
  end

end
