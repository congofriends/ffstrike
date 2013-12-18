require 'spec_helper'

describe Rally do
  let(:rally)  { FactoryGirl.build(:rally) }

  it { should respond_to(:tasks) }
end
