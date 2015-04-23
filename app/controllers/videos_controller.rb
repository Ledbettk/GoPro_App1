class VideosController < ApplicationController
    def new
        @video = Video.new
    end

    def index
      @videos = Video.all
    end
    
    def create
      video_params = {
        link: params[:link],
        title: params[:title],
        author: current_user[:name],
        user_id: current_user[:id]
      }
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
    
    def show
      @video = Video.find(params[:id])
      @youtube_id = @video.youtube_id
      @vimeo_id = @video.vimeo_id
    end
end
