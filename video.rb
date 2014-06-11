require 'sinatra'
require 'sinatra/reloader'
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
	session[:commentarr] ||= []
	session[:commentarr].push(params[:title])
	session[:commentarr].push(params[:comment])
	erb :sets, :locals => { :commentarr => session[:commentarr]}

end
get '/sets/beyonce' do

end

get '/sets/beyonce/play' do

end

get '/sets/beyonce/edit' do

end

put '/sets/beyonce' do

end

delete '/sets/beyonce' do

end

