class VideoValidator < ActiveModel::Validator
  def validate(movement)
    if !movement.video.nil? && has_invalid_chars?(movement.video)
      movement.errors[:video] << "Error!!!"
    end
  end

  URL_Formats = {
        regular: /^(https?:\/\/)?(www\.)?youtube.com\/watch\?(.*\&)?v=([^&]+)/,
        invalid_chars: /[^a-zA-Z0-9\:\/\?\=\&\$\-\_\.\+\!\*\'\(\)\,]/
        }

  def has_invalid_chars?(youtube_url)
    !URL_Formats[:invalid_chars].match(youtube_url).nil?
  end
end
