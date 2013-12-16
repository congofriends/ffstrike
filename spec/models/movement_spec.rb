require 'spec_helper'

describe Movement do
  it "has a working factory" do
    expect(FactoryGirl.build(:movement)).to be_valid
  end

  it "is not valid without a name" do
    expect(FactoryGirl.build(:nameless_movement)).to_not be_valid
  end

	it { should have_attached_file(:image) }
	it { should validate_attachment_content_type(:image).
				allowing('image/png', 'image/gif', 'image/jpg', 'image/jpeg').
				rejecting('text/plain', 'text/xml') }
 	it { should validate_attachment_size(:image).
			                 less_than(2.megabytes) }	 

end
