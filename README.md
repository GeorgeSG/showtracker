showtracker
===========

A simple webapp that helps you track the tv shows you watch.
Future version 2.0 of [showtracker.eu](http://showtracker.eu)

Setup
=====

In order to setup the application for development you need to:
* Install PostgreSQL and create a database
* Clone this repo
* Run `bundle install`
* Modify `app/config/config.yml` with your db settings
* Run `rackup` (or use `rerun rackup` when developing)

Tools
=====

### Rake ###
There are some Rake tasks to help you out. Run `rake -T` for more information.

### DB Console ###
Also, there is a db console, from the project root, run `./bin/console`, a PRY
console with all models required and a DB dataset loaded will start.

Example usage:
`Show.count`, `DB[:shows].delete`, etc.

