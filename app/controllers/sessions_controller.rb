get '/sessions/new' do
  erb :'users/login'
end

post '/sessions' do
  @user = User.authenticate(params[:username], params[:password])
  if @user
    session[:user_id] = @user.id
    redirect "/users/#{@user.id}"
  else
    @errors = ["Username and/or password does not match our records"]
    erb :'users/login'
  end
end

delete '/sessions' do
  session.clear
  erb :'index'
  #change if no index created
end
