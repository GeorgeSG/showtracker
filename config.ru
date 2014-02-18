require './app/boot'

#==============================================================================
# Map Top Level Controllers
#==============================================================================

controllers = [
  ShowTracker::ActorsController,
  ShowTracker::GenresController,
  ShowTracker::HomeController,
  ShowTracker::RESTController,
  ShowTracker::ShowsController,
  ShowTracker::UsersController
]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end
