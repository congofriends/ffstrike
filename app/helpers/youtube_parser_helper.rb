module YoutubeParserHelper
  URL_Formats = {
        regular: /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=([^&]+)/,
        invalid_chars: /[^a-zA-Z0-9\:\/\?\=\&\$\-\_\.\+\!\*\'\(\)\,]/
        }

  def has_invalid_chars?(youtube_url)
    !URL_Formats[:invalid_chars].match(youtube_url).nil?
  end

  def extract_video_id(youtube_url)
    return nil if has_invalid_chars?(youtube_url)

    if match = URL_Formats[:regular].match(youtube_url)
      return match[4]
    end

    nil
  end

end   
