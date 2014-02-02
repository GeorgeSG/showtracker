require './config/boot'

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
