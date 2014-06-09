require 'sinatra'
configure do
	enable :sessions
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
	session[:commentarr] ||= []
	erb :sets, :locals => { :commentarr => session[:commentarr]}
end
post '/sets' do
	# binding.pry
	session[:commentarr] ||= []
	session[:commentarr].push(params[:comment])
	erb :sets, :locals => { :commentarr => session[:commentarr]}

end



