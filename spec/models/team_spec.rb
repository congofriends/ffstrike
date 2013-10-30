require 'spec_helper'

describe Team do
  context 'user' do
    context 'when looking for approved applications' do
      
      team = Team.new
      context 'if the application exists for the given user id' do
        it 'should be true if the application is approved' do
          allow(team).to receive(:role_applications).and_return([double('application', {:user_id => 1, :approved? => true})])
          expect(team.approved_application_exists?(1)).to eq(true)
        end
        it 'should be false if the application is not approved' do
          allow(team).to receive(:role_applications).and_return([double('application', {:user_id => 1, :approved? => false})])
          expect(team.approved_application_exists?(1)).to eq(false)
        end
      end
      context 'if the application does not exist for the given user id' do
        it 'should be false if no approved application exists' do
          allow(team).to receive(:role_applications).and_return([double('application', {:user_id => 1, :approved? => true})])
          expect(team.approved_application_exists?(2)).to eq(false)
        end
      end
    end
  end
end