module RalliesHelper

  def extract_zip(zip)
    /\d{5}/.match(zip)[0]
  end

  def valid_zip(zip)
    /\d{5}/ =~ zip
  end

end
