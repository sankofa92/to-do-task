require "rails_helper"
require 'pry-rails'

Capybara.default_driver = :selenium_chrome

RSpec.feature "users", type: :feature do

  before(:each) do
    @user = FactoryBot.create(:user)
  end

  scenario '註冊使用者' do
    visit root_path
    signup('foo', 'foo@example.com', '123456')

    expect(page).to have_content(I18n.t('users.login'))
  end

  scenario '使用者登入' do
    visit root_path
    login(@user.email, @user.password)

    expect(page).to have_content(I18n.t('common.task_list'))
  end

  scenario '未登入時不能進入任務列表' do
    visit tasks_path
    expect(page).to have_content(I18n.t('users.login'))
  end

  scenario '只能看到當前使用者的任務' do
    user_task = FactoryBot.create(:task, user_id: @user.id)
    other_user = FactoryBot.create(:user, :other_user)
    other_user_task = FactoryBot.create(:task, user_id: other_user.id)
    visit root_path
    login(@user.email, @user.password)
    
    expect(page).to have_content(user_task.title)
    expect(page).to_not have_content(other_user_task.title)
  end
end