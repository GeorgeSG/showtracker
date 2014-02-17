module ShowTracker
  module AuthorizationChecker
    def auth(type)
      condition do
        unless send "#{type}?"
          redirect '/users/login', info: t('errors.not_logged_in')
        end
      end
    end
  end
end
