require 'rubygems'
require 'faker'
require 'sequel'

DB = Sequel.sqlite('../showtracker.db')
Dir.glob('../../models/**/*.rb').each { |model| require model }
