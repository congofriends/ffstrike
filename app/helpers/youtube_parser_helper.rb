module YoutubeParserHelper

  REGULAR = /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=([^&]+)/

  def extract_video_id(youtube_url)
    if match = REGULAR.match(youtube_url)
      return match[4]
    end
    nil
  end

  def youtube_embed_url_for_(youtube_id)
    %(<iframe src="http://www.youtube.com/embed/#{youtube_id}" frameborder="0" allowfullscreen></iframe>).html_safe
  end
end   
