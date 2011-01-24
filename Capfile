load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

load 'config/deploy' # remove this line to skip loading any of the default tasks

after "deploy:update_code", "deploy:update_symlinks"

namespace :deploy do
  task :update_symlinks do

    run "ln -nfs #{shared_path}/public/.htaccess #{release_path}/public/.htaccess"

    %w(environment.rb database.yml).each do |config_file|
      run "ln -nfs #{shared_path}/config/#{config_file} #{release_path}/config/#{config_file}"
    end

    %w(sessions sockets).each do |tmp_dir|
      run "ln -fs #{shared_path}/tmp/#{tmp_dir} #{release_path}/tmp/#{tmp_dir}"
    end
    
  end

end
