module ShowTracker
  module UserHelpers
    def logged?
      not session[:uid].nil?
    end

    def current_user
      return nil unless logged?

      User.find(id: session[:uid])
    end

    def hash_pasword(password, salt)
      BCrypt::Engine.hash_secret(password, user.salt)
    end

    def hash_salt
      BCrypt::Engine.generate_salt
    end
  end
end
