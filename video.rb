require 'sinatra'
require 'sinatra/reloader'
configure do
  enable :sessions
end
get '/' do
	redirect 'http://localhost:4567/sets'
end
get '/sets/new' do
  erb :newsets
end
get '/sets' do
  session[:commentarr] ||= []
  erb :sets, :locals => {:commentarr => session[:commentarr]}
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
		url="http://www.youtube.com/v/" + videos[videos.length-1] + "?version=3&loop=1&playlist="+ videos[0].to_s + "," 
		# url="http://www.youtube.com/embed/" + videos[videos.length-1] + "," + videos[0].to_s + "," 
 		count = 1 
 		 puts url
 		puts videos.length-1
 		while count <= videos.length-1 
				url = url + videos[count].to_s + ", " 
				count +=1 
 		end 
 		url = url + '?autoplay=1'
 		# redirect url
			erb :index, :locals => {:title => url}

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