module YoutubeParserHelper

  REGULAR = /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=([^&]+)/

  def extract_video_id(youtube_url)
    if match = REGULAR.match(youtube_url)
      return match[4]
    end

    nil
  end

end   
