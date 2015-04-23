class VideosController < ApplicationController
    
    def get_link(in_link)
      return in_link[in_link.index('v=')+2,in_link.length]
    end

    def new
      @video = Video.new
    end

    def index
      @videos = Video.all
    end
    
    def create
      yt_link = get_link(params[:video][:link])

      video_params = {
        link: yt_link,
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
