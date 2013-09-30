require 'spec_helper'

describe HomeController do
  describe 'The home page' do

    context 'when a person has signed in' do
      let(:user) { double('user', :id => 1) }
      before do
        @controller.stub(:user_signed_in?).and_return(true)
        @controller.stub(:current_user).and_return(user)
      end

      context 'and they are a team coordinator' do
        let(:team) { double('team', :id => 2) }
        let(:team_results) { double('teams', :exists? => true, :first => team) }
        before { Team.stub(:any_in).and_return(team_results) }

        it "is their team's dashboard" do
          get :start
          response.should redirect_to(team_url(:id => team.id))
        end
      end

      context 'and they are on a team' do
        let(:team) { double('team', :id => 3) }
        let(:team_results) { double('teams', :exists? => true, :first => team) }
        before { Team.stub(:any_in).and_return(team_results) }
        it "is their team's dashboard" do
          get :start
          response.should redirect_to(team_url(:id => team.id))
        end
      end

      context 'and they are not on a team' do
        let(:team_results) { double('teams', :exists? => false) }
        before { Team.stub(:any_in).and_return(team_results) }
        it 'is the start page' do
          get :start
          response.should render_template('start')
        end
      end
    end

    context 'when a person is not signed in' do
      before { @controller.stub(:user_signed_in?).and_return(false) }
      it 'is the start page' do
        get :start
        response.should render_template('start')
      end
    end
  end
end
