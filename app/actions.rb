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
      "User #{username} saved!"

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
  if user 

    #check if that user's password matches the password input 
    #3. if the passwords match
    if user.password == password
      "Success!"
    else 
      "Password doesn't match"
    end
  else 
    "No User"
  end
  
end 

