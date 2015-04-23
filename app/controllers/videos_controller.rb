class VideosController < ApplicationController
    
    def get_yt_link(in_link)
      return in_link[in_link.index('v=')+2,in_link.length]
    end

    def get_vimeo_link(in_link)
      in_link.split('/').each do |el| 
        if el.to_i.to_s.length == el.length
          return el
        end
      end
    end

=begin
  def get_vimeo_img(vim_id)
      url = "http://www.vimeo.com/" + vim_id
      vimeo_video_id = url.scan(/vimeo.com\/(\d+)\/?/).flatten.to_s               # extract the video id
      vimeo_video_json_url = "http://vimeo.com/api/v2/video/%s.json" % vimeo_video_id   # API call

      # Parse the JSON and extract the thumbnail_large url
      thumbnail_image_location = JSON.parse(open(vimeo_video_json_url).read).first['thumbnail_large'] #rescue nil
      
      return thumbnail_image_location
    end
=end


    def detect_source(in_link) #returns true for vimeo, false for youtube
      if in_link.include? "vimeo"
        return true
      else
        return false
      end
    end

    def new
      @video = Video.new
    end

    def index
      if(current_user == nil)
        redirect_to login_url
      end
      @videos = Video.all
    end
    
    def create
      video_params = {
        title: params[:video][:title],
        author: current_user[:name],
        user_id: current_user[:id],
        vimeo_id: nil,
        youtube_id: nil,
      }
      
      vidlink = params[:video][:link]      

      if detect_source(vidlink)
        video_params[:vimeo_id] = get_vimeo_link(vidlink)
        video_params[:youtube_id] = nil
      else 
        video_params[:youtube_id] = get_yt_link(vidlink)
        video_params[:vimeo_id] = nil
      end

      @video = Video.new(video_params)
      @video.save
      #flash.notice = "Video '#{@video.title}' Updated!"
      redirect_to video_path(@video)
    end
    
    def destroy
      @video = Video.find(params[:id])
      @video.delete
      #flash.notice = "Video '#{@video.title}' Deleted!"
      redirect_to articles_path
    end
    
    def show
      @video = Video.find(params[:id])
      @youtube_id = @video.youtube_id
      @vimeo_id = @video.vimeo_id
    end

    #helper_method :get_vimeo_img
end
