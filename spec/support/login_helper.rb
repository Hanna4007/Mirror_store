module LoginHelper
  def login(user)
    post '/session', params: { session: { email: user.email, password: user.password } }
  end
end