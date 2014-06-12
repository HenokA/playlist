require 'sinatra'
require 'sinatra/reloader'
configure do
	enable :sessions
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
	title = "false"
	if session[:commentarr] != []
			a=session[:commentarr].each_slice(2)
			videos = "false"
			a.each do |element|	
				if params[:name].downcase.to_s == element[0].downcase.to_s
					title = element[0]
					videos = element[1]
				end
			end
	end
	if title != false
		session[:commentarr].delete(title)
		session[:commentarr].delete(videos)
	end
	session[:commentarr].unshift(params[:title])
	session[:commentarr].unshift(params[:comment])

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
		url="http://www.youtube.com/v/" + videos[videos.length-1] + "?version=3&loop=1&playlist="+ videos[0].to_s + "," 
 		count = 1 
 		while count < videos.length-1 
				url = url + videos[count].to_s + ", " 
				count +=1 
 		end 
 		redirect url.to_s
			# erb :index, :locals => {:title => url}

end
get '/sets/:name/edit' do
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
	erb :edit, :locals => {:title => title, :videos => videos}
end