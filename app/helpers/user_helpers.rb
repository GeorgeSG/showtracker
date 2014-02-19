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

    def login(username, password)
      user = User.find(username: username)

      if user.nil?
        redirect NAMESPACE + '/login', error: t('errors.no_such_user')
      end

      password = hash_password(password, user.salt)
      if password != user.password
        redirect NAMESPACE + '/login', error: t('errors.incorrect_password')
      end

      session[:uid] = user.id
      redirect '/', success: t('successes.welcome', name: user.username)
    end

    def logout
      session[:uid] = nil
      redirect '/', success: t('successes.logout')
    end

    def signup(user, password, confirm_password, email, first_name, last_name)
      unless password == confirm_password
        flash[:error] = 'The two passwords entered do not match!'
        redirect NAMESPACE + '/signup'
      end

      password_salt = hash_salt
      password_hash = hash_password(password, password_salt)

      User.create(
        username: username,
        password: password_hash,
        salt: password_salt,
        email: email,
        first_name: first_name,
        last_name: last_name
      )

      redirect NAMESPACE + '/login', success: t('successes.register')
    end
  end
end
