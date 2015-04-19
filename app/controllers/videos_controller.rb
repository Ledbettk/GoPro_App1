class VideosController < ApplicationController
    def new
        @video = video.new
    end

    def create
    	@video = video.new(video_params)
    	if @video.save
    		index
    	else
    		puts "something went wrong in creating video"
    end

    def index
    	@videos = Video.all
    end

    def show_video
    	@video = Videos.find(params[:id])
    	render video_page
    end
end
