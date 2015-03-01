# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary server in each group
# is considered to be the first unless any hosts have the primary
# property set.  Don't declare `role :all`, it's a meta role.

role :app, %w{5.189.135.145}
role :web, %w{5.189.135.145}
role :db,  %w{5.189.135.145}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server definition into the
# server list. The second argument is a, or duck-types, Hash and is
# used to set extended properties on the server.

#server 'server.domain.com', user: 'user_name', port: 22, password: fetch(:password), roles: %w{web app db}


#server '5.189.135.145', user: 'tokhi', roles: %w{web app}

server '5.189.135.145', user: 'tokhi', roles: %w{web app}, my_property: :my_value

set :deploy_to, "/home/tokhi/tokfood"
# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult[net/ssh documentation](http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start).
#
# Global options
# --------------
  set :ssh_options, {
    keys: %w(/home/tokhi/.ssh/id_rsa),
    forward_agent: true,
   # auth_methods: %w(password)
  }
##
# And/or per server (overrides global)
# ------------------------------------
# server 'example.com',
#   user: 'tokhi',
#   roles: %w{web app},
#   ssh_options: {
 #    user: 'tokhi', # overrides user setting above
 #    keys: %w(/home/tokhi/.ssh/id_rsa),
 #    forward_agent: false,
 #    auth_methods: %w(publickey password)
#     # password: 'please use keys'
#   }

# lib/capistrano/tasks/agent_forwarding.rake
desc "Check if agent forwarding is working"
task :forwarding do
  on roles(:all) do |h|
    if test("env | grep SSH_AUTH_SOCK")
      info "Agent forwarding is up to #{h}"
    else
      error "Agent forwarding is NOT up to #{h}"
    end
  end
end
