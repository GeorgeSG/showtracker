module ShowTracker
  class AuthController < Base
    NAMESPACE = '/auth'.freeze

    helpers UserHelpers

    get '/login' do
      erb :'auth/login'
    end

    post '/login' do
      username = params[:login_username]
      password = params[:login_password]

      user = User.find(username: username)

      if user.nil?
        redirect NAMESPACE + '/login', error: 'There is no such user in our database!'
      end

      password = BCrypt::Engine.hash_secret(password, user.salt)
      if password != user.password
        redirect NAMESPACE + '/login', error: 'You\'ve entered an incorrect password!'
      end

      session[:uid] = user.id
      redirect '/', success: "Welcome, #{user.username}! Enjoy your stay!"
    end

    get '/logout' do
      session[:uid] = nil
      redirect '/', success: 'You\'ve logged out successfully! Have a nice day!'
    end

    post '/signup' do
      username         = params[:username]
      password         = params[:password]
      confirm_password = params[:confirm_password]
      email            = params[:email]
      first_name       = params[:first_name]
      last_name        = params[:last_name]

      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)

      user = User.create(username: username,
                         password: password_hash,
                         salt: password_salt,
                         email: email,
                         first_name: first_name,
                         last_name: last_name)

      flash[:success] = 'You have registered succesfully!'
      redirect NAMESPACE + '/login'
    end
  end
end
