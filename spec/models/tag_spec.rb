require 'rails_helper'

RSpec.describe Tag, type: :model do
  before(:each) do
    @task = FactoryBot.create(:tag)
  end

  it "類別不能重複" do
    expect(FactoryBot.build(:tag, sort: 'New')).not_to be_valid
  end
  
end
