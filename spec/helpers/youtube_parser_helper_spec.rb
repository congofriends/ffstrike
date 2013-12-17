require 'spec_helper'

describe YoutubeParserHelper do
  it "checks extract_video_id returns id" do
     expect(helper.extract_video_id("http://www.youtube.com/watch?v=EpnERlsfBFc")).to eql("EpnERlsfBFc")
  end

  it "checks extract_video_id doesn't return id" do
     expect(helper.extract_video_id("http://www.com/watch?v=EpnERlsfBFc")).to be_nil
  end

  describe "checks extract_video_id returns correct youtube id" do
    it "for link starting with www" do
      assert_equal "eiHXASgRTcA", helper.extract_video_id("www.youtube.com/watch?v=eiHXASgRTcA")
    end

    it "for link starting with hhtp" do
      assert_equal "eiHXASgRTcA", helper.extract_video_id("http://www.youtube.com/watch?v=eiHXASgRTcA")
    end

    it "for link starting with https" do
      assert_equal "eiHXASgRTcA", helper.extract_video_id("https://www.youtube.com/watch?v=eiHXASgRTcA")
    end

    it "for link from a playlist" do
      assert_equal "ae35d4EWEnc", helper.extract_video_id("http://www.youtube.com/watch?v=ae35d4EWEnc&list=PL2A2C191E3D22BAF4")
    end

    it "for embed link" do
      assert_equal "ae35d4EWEnc", helper.extract_video_id("www.youtube.com/embed/ae35d4EWEnc")
    end

    it "for embed link from a playlist" do
      assert_equal "ae35d4EWEnc", helper.extract_video_id("www.youtube.com/embed/ae35d4EWEnc?list=PL2A2C191E3D22BAF4")
    end
  end
end
