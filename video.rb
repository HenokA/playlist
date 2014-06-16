require 'sinatra'
require 'sinatra/reloader'
require 'enumerator'
use Rack::MethodOverride

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
		# videos = videos.split("\n")
		# url="http://www.youtube.com/v/" + videos[videos.length-1] + "?version=3&loop=1&playlist="+ videos[0].to_s + "," 
		# # url="http://www.youtube.com/embed/" + videos[videos.length-1] + "," + videos[0].to_s + "," 
 	# 	count = 1 
 	# 	while count < videos.length-1 
		# 		url = url + videos[count].to_s + "," 
		# 		count +=1 
 	# 	end 
 	# 	url = url + '?autoplay=1'
 			# redirect url
			 erb :index, :locals => {:title => title, :videos => videos}
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
	videos = ""
	mini = []
	count = 0
	while count < session[:commentarr].length
		if params[:title].downcase.to_s == session[:commentarr][count].downcase.to_s
			puts session[:commentarr][count]
			session[:commentarr].delete_at(count) #deletes the title
			session[:commentarr].delete_at(count) #deletes the video sub array
			title = params[:title].strip	#strips the title of all leading whitespace
			mini = params[:comment].split("\n") #separates the videos by new line
			mini.each do |vid|#loop to add each video to the videos variable
				videos=videos + vid + "\n"
			end
			puts "\n"
			puts videos
			puts params[:title]
			session[:commentarr].unshift(videos) #pushes on new video array
			session[:commentarr].unshift(params[:title].capitalize) #pushes on new title
			break 
		end
			count +=1
	end
	erb :individual, :locals => {:title => title, :videos => videos}
end

delete '/sets' do
	title = ""
	count = 0
	while count < session[:commentarr].length
		if params[:title].downcase.to_s == session[:commentarr][count].downcase.to_s
			session[:commentarr].delete_at(count) #deletes the title
			# count +=1
			session[:commentarr].delete_at(count) #deletes the video sub array
			break 
		end
			count +=1
	end
	puts session[:commentarr]
	erb :sets, :locals => { :commentarr => session[:commentarr]}
end		
