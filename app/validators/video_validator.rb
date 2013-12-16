class VideoValidator < ActiveModel::Validator
  def validate(movement)
    if !movement.video.nil? && has_invalid_chars?(movement.video)
      movement.errors[:video] << "Error!!!"
    end
  end

  INVALID_CHARS = /[^a-zA-Z0-9\:\/\?\=\&\$\-\_\.\+\!\*\'\(\)\,]/

  def has_invalid_chars?(youtube_url)
    !INVALID_CHARS.match(youtube_url).nil?
  end
end
