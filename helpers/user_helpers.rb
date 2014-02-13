module ShowTracker
  module UserHelpers
    def logged?
      not session[:uid].nil?
    end

    def current_user
      return nil unless logged?

      User.find(id: session[:uid])
    end
  end
end
