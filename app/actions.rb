helpers do 
  def current_user
    User.find_by(id: session[:user_id])
  end
end


def humanized_time_ago(time_ago_in_minutes)
    if time_ago_in_minutes >= 60
      "#{time_ago_in_minutes / 60} hours ago"
    else
      "#{time_ago_in_minutes} minutes ago"
    end
end

get '/' do
    @finstagram_posts = FinstagramPost.order(created_at: :desc)
    erb(:index)
end

get '/signup' do
    @user = User.new
    erb(:signup)
end

post '/signup' do
    # grab user input values from params
    email      = params[:email]
    avatar_url = params[:avatar_url]
    username   = params[:username]
    password   = params[:password]



    # instantiate a User
    @user = User.new({ email: email, avatar_url: avatar_url, username: username, password: password })
    
    if @user.save
      redirect to('/login')

     else 
      erb(:signup)
    end
end

get '/login' do
  erb(:login)
end

post '/login' do 
  username = params[:username]
  password = params[:password]

  #1. find user by username
  user = User.find_by(username: username)

  #2. if that user exists 
  if user && user.password == password

    #check if that user's password matches the password input 
    session[:user_id] = user.id
    redirect to('/')
    #3. if the passwords match

   
      "Success! User with id #{session[:user_id]} is logged in!"
  else
    @error_message = "Login Failed."
    erb(:login)
  end

end 

get '/logout' do
  session[:user_id] = nil
  redirect to('/')
end

get '/finstagram_posts/new' do
  @finstagram_post = FinstagramPost.new
  erb(:"finstagram_posts/new")
end

post '/finstagram_posts' do
  photo_url = params[:photo_url]

  @finstagram_post = FinstagramPost.new({ photo_url: photo_url, user_id: current_user.id })

  if @finstagram_post.save
    redirect(to('/'))
  else
    erb(:"finstagram_posts/new")
  end
end

get '/finstagram_posts/:id' do
    @finstagram_post = FinstagramPost.find(params[:id])
    erb(:"finstagram_posts/show")
end
