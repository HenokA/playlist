require 'sinatra'
configure do
	enable :session
end

def makeplaylist
	url = ["sJMBd5z9Ki4", 
			"iS1g8G_njx8", 
			"SoJ8s90NLc4", 
			"VJ44m6-3ZLQ"]
	return url[rand(4)]
end
get '/' do
	url = makeplaylist
	url = "https://www.youtube.com/embed/" + url
	erb :index, :locals =>{:url => url}
end
get '/sets/new' do
	erb :newsets
end
get '/sets' do
	erb :sets, :locals => {:commentarr => session[:commentarr] || []}
end
post '/sets' do
	# binding.pry
	if session[:commentarr] == nil
		session[:commentarr] = []
	end

	session[:commentarr] = session[:commentarr] + [params[:comment]]
	erb :sets, :locals => { :commentarr => session[:commentarr]}

end



