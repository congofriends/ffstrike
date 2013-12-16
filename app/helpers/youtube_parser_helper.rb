module YoutubeParserHelper

  def extract_video_id(youtube_url)
    if match = /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=([^&]+)/.match(youtube_url)
      return match[4]
    end

    nil
  end

end   
