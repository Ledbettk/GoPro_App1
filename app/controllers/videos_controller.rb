class VideosController < ApplicationController
    def new
        @video = video.new
    end
    
    def index
      @video = Video.all
    end
    
    def show
     @video = Video.find(params[:id])
    end
    
    def create
      @video = Video.new(video_params)
      @video.save
      flash.notice = "Video '#{@video.title}' Updated!"
      redirect_to video_path(@video)
    end
    
    def destroy
      @video = Video.find(params[:id])
      @video.delete
      flash.notice = "Video '#{@video.title}' Deleted!"
      redirect_to articles_path
    end
end
