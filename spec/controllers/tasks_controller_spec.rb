require 'spec_helper'

describe TasksController do
  describe "POST #create" do
    let(:movement){FactoryGirl.create(:movement)}

    context "with valid information" do
      it "creates a task" do
        expect{post :create, movement_id: movement, task: FactoryGirl.attributes_for(:task)}.to change(Task, :count).by(1)
      end

      it "redirects to the index page" do
        post :create, movement_id: movement, task: FactoryGirl.attributes_for(:task)
        expect(response).to redirect_to movement_tasks_path
      end

      it "notifies the user that task was created" do
        post :create, movement_id: movement, task: FactoryGirl.attributes_for(:task)
        flash[:notice].should == "Task 'I am a valid task for rally' is created"
      end
    end

    context "with invalid information" do
      it "does not save the task" do
        expect{post :create, movement_id: movement, task: FactoryGirl.attributes_for(:task_without_description)}.not_to change(Task, :count)
      end

      it "re-renders the new method" do
        post :create, movement_id: movement, task: FactoryGirl.attributes_for(:task_without_description)
        expect(response).to render_template :index
      end

      it "notifies user that task information is missing description field" do
        post :create, movement_id: movement, task: FactoryGirl.attributes_for(:task_without_description)
        flash[:notice].should == "Description can't be blank"
      end

      it "notifies user that task information is missing rally size field" do
        post :create, movement_id: movement, task: FactoryGirl.attributes_for(:task_without_rally_size)
        flash[:notice].should == "Rally size warning Please choose at least one rally category"
      end
    end 
  end

  describe "PUT #update" do
    before :each do
      @movement = FactoryGirl.create(:movement)
      @task = FactoryGirl.create(:task, movement: @movement)
      put :update, movement_id: @movement, id: @task, task: FactoryGirl.attributes_for(:task, description: "New description goes here") 
    end
    
    it "loads the requested task" do
      expect(assigns(:task)).to eq(@task)
    end

    it "updates the task" do
      @task.reload
      expect(@task.description).to eq("New description goes here")
    end

    it "redirects to show" do
      expect(response).to redirect_to movement_tasks_path
    end
  end

  describe "DELETE #destroy" do
    before :each do
      @movement = FactoryGirl.create(:movement)
      @task = FactoryGirl.create(:task, movement: @movement)
    end
    it "should destroy task" do
      assert_difference 'Task.count', -1, "Task is deleted" do
        delete :destroy, movement_id: @movement, id: @task.id
      end
      assert_redirected_to movement_tasks_path
    end
  end
end
