require 'spec_helper'

describe Movement do
  let(:movement)  { FactoryGirl.build(:movement) }

  it "is valid with correct fields" do
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

  it { should respond_to(:tasks) }
  it { should respond_to(:users) }

  describe "task assosiation" do
    before do 
      movement.save
      2.times { FactoryGirl.create(:task, movement: movement) }
    end

    it "should destroy assosiated tasks" do
      tasks = movement.tasks.to_a
      movement.destroy
      expect(tasks).not_to be_empty
      tasks.each { |task| expect(Task.where(id: task.id)).to be_empty }
    end
  end

  describe '.random' do
    before do
      FactoryGirl.create_list(:movement, 10)
    end

    it 'returns an array of 3 movements when n = 3' do
      expect(Movement.random(3).count).to be(3)
    end

    it 'should always return unique results' do
      expect(uniq?(Movement.random(5))).to be(true)
    end
  end

  private

  def uniq?(movements)
    movements.uniq.length == movements.length 
  end
end
