require './config/boot'

#===============================================================================
# Map Top Level Controllers
#===============================================================================

controllers = [
  ShowTracker::ActorsController,
  ShowTracker::AuthController,
  ShowTracker::GenresController,
  ShowTracker::MainController,
  ShowTracker::ShowsController,
  ShowTracker::UsersController
]

controllers.each do |controller|
  map (controller::NAMESPACE) { run controller }
end
