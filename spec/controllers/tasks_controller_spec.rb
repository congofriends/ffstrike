require 'spec_helper'

describe TasksController do
  let(:movement) { FactoryGirl.create(:movement) }
  let(:event) { FactoryGirl.create(:event, movement: movement)}
  let(:task)  { FactoryGirl.create(:task, event: event)}

  describe "POST #create" do
    context "with valid information" do
      it "creates a task" do
        event.reload
        expect{post :create, event_id: event, task: FactoryGirl.attributes_for(:task)}.to change(Task, :count).by(1)
      end

      it "redirects to the index page" do
        post :create, event_id: event, task: FactoryGirl.attributes_for(:task)
        expect(response).to redirect_to my_events_path(:name => { :id => event.id }, anchor: "tasks")
      end

      it "notifies the user that task was created" do
        post :create, event_id: event, task: FactoryGirl.attributes_for(:task)
        flash[:notice].should == "New task is created"
      end
    end

    context "with invalid information" do
      it "does not save the task" do
        event.reload
        expect{post :create, event_id: event, task: FactoryGirl.attributes_for(:task_without_description)}.not_to change(Task, :count)
      end

      it "re-renders the new method" do
        post :create, event_id: event, task: FactoryGirl.attributes_for(:task_without_description)
        expect(response).to redirect_to my_events_path(:name => { :id => event.id }, anchor: "tasks")
      end

      it "notifies user that task information is missing description field" do
        post :create, event_id: event, task: FactoryGirl.attributes_for(:task_without_description)
        flash[:notice].should == "Description can't be blank"
      end
    end
  end

  describe "PUT #update" do
    new_task_desc = "New description goes here"
    before(:each) {put :update, event_id: event, id: task, task: FactoryGirl.attributes_for(:task, description: new_task_desc)}

    it "loads the requested task" do
      expect(assigns(:task)).to eq(task)
    end

    it "updates the task" do
      task.reload
      expect(task.description).to eq(new_task_desc)
    end

    it "redirects to show" do
      expect(response).to redirect_to movement_path(movement, anchor: "tasks")
    end
  end

  describe "DELETE #destroy" do
    it "should destroy task" do
      task; event
      assert_difference 'Task.count', -1, "Task is deleted" do
        delete :destroy, event_id: event, id: task
      end
      assert_redirected_to movement_path(movement, anchor: "tasks")
    end
  end
end
