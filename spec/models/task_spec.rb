require 'rails_helper'

RSpec.describe Task, type: :model do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  it "不能沒有標題及內文" do
    expect(FactoryBot.build(:task, title: nil, content: nil)).not_to be_valid
  end

  it "不能沒有標題" do
    expect(FactoryBot.build(:task, title: nil, content: 'it is content')).not_to be_valid
  end

  it "不能沒有內文" do
    expect(FactoryBot.build(:task, title: 'it is title', content: nil)).not_to be_valid
  end

  it '任務狀態變化' do
    task = FactoryBot.build(:task)
    expect(task).to have_state(:pending)
    expect(task).not_to have_state(:doing)
    expect(task).to allow_event :take
    expect(task).to_not allow_event :drop
    expect(task).to allow_transition_to(:doing)
    expect(task).to_not allow_transition_to(:finish)
    expect(task).to transition_from(:pending).to(:doing).on_event(:take)
    expect(task).not_to transition_from(:pending).to(:finish).on_event(:take)

    expect(task).to have_state(:doing)
    expect(task).not_to have_state(:finish)
    expect(task).to allow_event :drop
    expect(task).to_not allow_event :take
    expect(task).to allow_transition_to(:finish)
    expect(task).to_not allow_transition_to(:pending)
    expect(task).to transition_from(:doing).to(:finish).on_event(:drop)
    expect(task).not_to transition_from(:doing).to(:pending).on_event(:drop)
  end

  it '搜尋任務標題' do
    task_one = FactoryBot.create(:task, title: 'TaskOne', user_id: @user.id)
    task_two = FactoryBot.create(:task, title: 'TaskTwo', user_id: @user.id)
    task_three = FactoryBot.create(:task, title: 'TaskThree', user_id: @user.id)

    @q = Task.ransack({title_cont: 'Task'})
    @tasks = @q.result.order(created_at: :desc)
    expect(@tasks).to eq([task_three, task_two, task_one])
  end
end