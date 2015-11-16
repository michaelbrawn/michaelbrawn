set :stage, :production

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.

role :app, %w{sticksnstonesart.ca}
role :web, %w{sticksnstonesart.ca}
role :db,  %w{sticksnstonesart.ca}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.
server 'sticksnstonesart.ca', user: 'sticksn3_rails', roles: %w{web app}, application: "michaelbrawn"
set :use_sudo, false
set :scm, :git
set :branch, "master"
set :repository, "."
set :deploy_via, :copy
set :deploy_to, "/home/#{user}/rails_apps/#{application}"

server domain, :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  # Touch tmp/restart.txt to tell Phusion Passenger about new version
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end

# Clean-up old releases
after "deploy:restart", "deploy:cleanup"
# you can set custom ssh options
# it's possible to pass any option but you need to keep in mind that net/ssh understand limited list of options
# you can see them in [net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start)
# set it globally
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
# and/or per server
# server 'example.com',
#   user: 'user_name',
#   roles: %w{web app},
#   ssh_options: {
#     user: 'user_name', # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }
# setting per server overrides global ssh_options

# fetch(:default_env).merge!(rails_env: :production)
