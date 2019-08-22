require 'rails_helper'

RSpec.describe User, type: :model do

  it "不能沒有名字及email" do
    expect(FactoryBot.build(:user, name: nil, email: nil)).not_to be_valid
  end
  it '不能沒有名字' do
    expect(FactoryBot.build(:user, name: nil, email: 'fff@example.com')).not_to be_valid
  end
  it '不能沒有email' do
    expect(FactoryBot.build(:user, name: '1450', email: nil)).not_to be_valid
  end
  it 'email格式錯誤' do
    expect(FactoryBot.build(:user, name: '1450', email: 'fff#example.com')).not_to be_valid
  end
  it '密碼過短' do
    expect(FactoryBot.build(:user, name: '1450', email: 'fff@example.com', password: '12345')).not_to be_valid
  end
  it '刪除使用者同時刪除其任務' do
    user = FactoryBot.create(:user)
    task = FactoryBot.create(:task, user_id: user.id)
    
    expect{user.destroy}.to change{Task.count}.by(-1)
  end
end
