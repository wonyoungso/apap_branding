def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
  end

  desc "Upgrade installed packages"
  task :upgrade do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y upgrade"
  end
end

namespace :base do
  desc "Install base package onto the server"
  task :install do
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} apt-get -y install gcc"
    run "#{sudo} apt-get -y update"

    run "#{sudo} apt-get -y install libxml2-dev libxslt1-dev" # Nokogiri
    run "#{sudo} apt-get -y install imagemagick" # CarrierWave
    # Manual bootstrap
    run "#{sudo} apt-get -y install build-essential zlib1g-dev libssl-dev libreadline-gplv2-dev"
  end
  after "deploy:install", "base:install"
end
