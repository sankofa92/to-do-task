require 'rails_helper'

RSpec.describe Task, type: :model do

  it "不能沒有標題及內文" do
    expect(FactoryBot.build(:task, title: nil, content: nil)).not_to be_valid
  end

  it "不能沒有標題" do
    expect(FactoryBot.build(:task, title: nil, content: 'it is content')).not_to be_valid
  end

  it "不能沒有內文" do
    expect(FactoryBot.build(:task, title: 'it is title', content: nil)).not_to be_valid
  end
end
