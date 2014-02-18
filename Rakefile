task default: :spec
require 'rspec/core'
require 'rspec/core/rake_task'


desc 'Runs all specs in spec directory'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = './spec/**/*_spec.rb'
end

namespace :db do
  require 'sequel'
  require 'yaml'

  # Load config file
  settings = YAML.load(File.open('./app/config/config.yml'))
  Sequel.extension :migration, :core_extensions

  migrator    = Sequel::Migrator
  migrations  = settings['migrations_path']
  environment = ENV['RACK_ENV'] || 'development'
  env_settngs = settings[environment]

  db_host     = env_settngs['db_host']
  db_name     = env_settngs['db_name']
  db_user     = env_settngs['db_user']
  db_password = env_settngs['db_password']

  DB = Sequel.postgres(db_name,
                       host: db_host,
                       user: db_user,
                       password: db_password)

  desc 'Reverts all migrations'
  task :drop do
    puts 'Reverting all migrations...'
    migrator.apply(DB, migrations, 0)
    puts 'Done!'
  end

  desc 'Migrates to given or newest migration (if version not supplied)'
  task :migrate, [:version] do |task, arguments|
    if arguments[:version]
      puts "Migrating to version #{arguments[:version]}"
      migrator.run(DB, migrations, target: arguments[:version].to_i)
    else
      puts 'Migrating to newest migration...'
      migrator.apply(DB, migrations)
    end

    puts 'Done!'
  end

  desc 'Reverts all migrations and applies them again'
  task :reset => [:drop, :migrate]

  desc 'Generates next migration with the name specified'
  task :migration, [:name] do |task, arguments|
    puts 'Generating a new migration...'
    migration_name      = arguments[:name].downcase.gsub(/\s/, '_')
    existing_migrations = Dir.entries(migrations).sort
    migration_index     = existing_migrations.last.split('_').first.to_i + 1

    migration_path = "#{migrations}/#{'%03d' % migration_index}_#{migration_name}.rb"
    initial_content = %Q[
Sequel.migration do
  change do

  end
end].strip.freeze

    File.open(migration_path, "w+") { |file| file.write initial_content }

    puts "Successfully created migration ##{migration_index}: #{migration_path}"
    puts 'Done!'
  end
end
