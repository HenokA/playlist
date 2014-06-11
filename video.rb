require 'sinatra'
require 'sinatra/reloader'
configure do
	enable :sessions
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
get '/sets/:name' do
	a=session[:commentarr].each_slice(2)
	title = "false"
	videos = "false"
	a.each do |element|	
		if params[:name].downcase.to_s == element[0].downcase.to_s
			title = element[0]
			videos = element[1]
		else
		end
	end
	erb :individual, :locals => {:title => title, :videos => videos}
end
get '/sets/:name/play' do
	a=session[:commentarr].each_slice(2)
		title = "false"
		videos = "false"
		a.each do |element|	
			if params[:name].downcase.to_s == element[0].downcase.to_s
				title = element[0]
				videos = element[1]
			else
			end
		end
		videos = videos.split("\n")
			erb :index, :locals => {:title => title, :videos => videos}

end