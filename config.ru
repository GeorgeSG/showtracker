require './config/boot'

use Sass::Plugin::Rack

#===============================================================================
# Map Top Level Controllers
#===============================================================================

controllers = [
  ShowTracker::MainController,
  ShowTracker::ShowsController
]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end
