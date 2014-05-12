module YoutubeParserHelper

  REGULAR_URL = /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=([^&]+)/
  EMBED_URL = /^(https?:\/\/)?(www\.)?youtube.com\/embed\/([^?]+)/

  def extract_video_id(youtube_url)
    if match = REGULAR_URL.match(youtube_url)
      return match[4]
    elsif match = EMBED_URL.match(youtube_url)
      return match[3]
    end
    nil
  end

  def youtube_embed_url_for_(youtube_id, width=200)
    %(<iframe src="http://www.youtube.com/embed/#{youtube_id}" id="video" width=#{width}frameborder="0" allowfullscreen></iframe>).html_safe
  end
end   
