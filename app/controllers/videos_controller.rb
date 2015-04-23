class VideosController < ApplicationController
    def new
      @video = Video.new
      @current_user = User.find_by(id: session[:user_id])

      render 'new'
    end

    def index
      @videos = Video.all
    end
    
    def show
      @video = Video.find(params[:id])
    end
    
    def create
      @video = Video.new(video_params)
      if @video.save
        flash.notice = "Video '#{@video.title}' Updated!"
        redirect_to video_path(@video)
      else
        render 'new'
      end
    end
    
    def destroy
      @video = Video.find(params[:id])
      @video.delete
      flash.notice = "Video '#{@video.title}' Deleted!"
      redirect_to articles_path
    end
    
    def show_video
    	@video = Videos.find(params[:id])
    	render video_page
    end

    private
      def user_params
        params.require(:video).permit(:title, :link)
      end
end
