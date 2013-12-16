require 'spec_helper'

describe YoutubeParserHelper do
  it "checks extract_video_id returns id" do
     expect(helper.extract_video_id("http://www.youtube.com/watch?v=EpnERlsfBFc")).to eql("EpnERlsfBFc")
    end

  it "checks extract_video_id doesn't return id" do
     expect(helper.extract_video_id("http://www.com/watch?v=EpnERlsfBFc")).to be_nil
    end
end
