Rack::MethodOverride
require 'sinatra'
require 'sinatra/reloader'
require 'enumerator'
configure do
  enable :sessions
end
#Takes you to the starting page at /sets if you load
#to the normal homepage
get '/' do
	redirect 'http://localhost:4567/sets'
end

get '/sets/new' do
  erb :newsets
end

#Sets
get '/sets' do
  session[:commentarr] ||= []
  # puts "get"
  erb :sets, :locals => {:commentarr => session[:commentarr]}
end
post '/sets' do
  session[:commentarr] ||= []
  # puts 'post'
	session[:commentarr].push(params[:title])
	session[:commentarr].push(params[:comment])
	erb :sets, :locals => { :commentarr => session[:commentarr]}
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
 		while count < videos.length-1 
				url = url + videos[count].to_s + "," 
				count +=1 
 		end 
 		url = url + '?autoplay=1'
 	
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
		name = params[:name]
		videos = videos.split("\n")
	erb :edit, :locals => {:title => title, :videos => videos, :name => name}
end

get '/sets/:name' do
	a=session[:commentarr].each_slice(2)
	  title = "false"
	  videos = "false"
	  puts 'ass'
	a.each do |element|	
		if params[:name].downcase.to_s == element[0].downcase.to_s
			title = element[0]
			videos = element[1]
		else
		end
	end
	erb :individual, :locals => {:title => title, :videos => videos}
end

post '/sets/:name' do 
	# a=session[:commentarr].each_slice(2)
	title = "false"
	videos = []
	mini = []
	# puts session[:commentarr]
	puts"found"
	count = 0
	while count < session[:commentarr].length
		if params[:title].downcase.to_s == session[:commentarr][count].downcase.to_s
			session[:commentarr].delete_at(count) #deletes the title
			count +=1
			session[:commentarr].delete_at(count) #deletes the video sub array
			session[:commentarr].unshift(params[:title]) #pushes on new title
			title = params[:title].strip	#strips the title of all leading whitespace
			mini = params[:comment].split("\n") #separates the videos by new line
			mini.each do |vid|#loop to add each video to the videos variable
				videos.push(vid.to_s.strip)
			end
			session[:commentarr].unshift(videos) #pushes on new video array

			break 
		end
			count +=1
	end
	# session[:commentarr].each do |element|	
	# 	if params[:title].downcase.to_s == element.downcase.to_s
	# 		session[:commentarr].delete(element)
	# 		session[:commentarr].unshift(params[:title], params[:comment])
	# 		title = params[:title]
	# 		videos = params[:videos]	
	# 	end
	# end

	erb :individual, :locals => {:title => title, :videos => videos}
end

# delete 'sets/:name' do
# a=session[:commentarr].each_slice(2)
# 	  title = "false"
# 	  videos = "false"
# 	a.each do |element|	
# 		if params[:name].downcase.to_s == element[0].downcase.to_s
# 			a.delete_at(0)
# 			videos = element[1]
		
# 		end
# 	end
# 	erb :individual, :locals => {:title => title, :videos => videos}
# end		

	