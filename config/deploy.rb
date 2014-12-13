lock '3.3.5'

set :application, 'goodsdb'
set :repo_url, 'git@github.com:HackathonMonster/goodsdb-api.git'

set :deploy_to, '/home/goodsdb/goodsdb-api'

# Default value for :format is :pretty
# set :format, :pretty

set :log_level, :debug

# Default value for :pty is false
# set :pty, true

set :linked_files, %w()

set :linked_dirs, %w(bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/assets)

set :rails_env, 'production'

set :default_env,
    gem_home: '$HOME/.gem',
    gem_path: '$HOME/.gem',
    rbenv_root: '/usr/local/rbenv',
    path: '$HOME/.gem/bin:$RBENV_ROOT/shims:$PATH'

set :rbenv_type, :system
set :rbenv_ruby, '2.1.5'
set :rbenv_map_bins, %w(gem ruby)

set :bundle_flags, '--deployment'
set :bundle_without, %w(development debug test deployment).join(' ')

set :puma_init_active_record, true
set :puma_threads, [4, 16]
set :puma_workers, 3

set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:app), in: :sequence do
      within release_path do
        execute :rake, 'tmp:cache:clear'
      end
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'
end
