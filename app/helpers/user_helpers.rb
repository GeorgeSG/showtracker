module ShowTracker
  # User Helpers - helpers for user management and interactions
  module UserHelpers
    def logged?
      !session[:uid].nil?
    end

    def current_user
      return nil unless logged?

      User.find(id: session[:uid])
    end

    def hash_password(password, salt)
      BCrypt::Engine.hash_secret(password, salt)
    end

    def hash_salt
      BCrypt::Engine.generate_salt
    end
  end
end
