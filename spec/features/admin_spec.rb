require "rails_helper"
require 'pry-rails'

Capybara.default_driver = :selenium_chrome

RSpec.feature "admin", type: :feature do
  
  before(:each) do
    @user = FactoryBot.create(:user)
    login(@user.email, @user.password)
    @task = FactoryBot.create(:task, user_id: @user.id)
  end

  scenario '新增使用者' do
    visit admin_users_path
    click_link I18n.t('users.new')
    fill_in 'user[name]', with: 'asdf'
    fill_in 'user[email]', with: 'asdf@example.com'
    fill_in 'user[password]', with: '123456'
    fill_in 'user[password_confirmation]', with: '123456'
    click_button I18n.t('common.submit')

    expect(page).to have_content('asdf')
    expect(page).to have_content('asdf@example.com')
    expect(page).to have_text(I18n.t('users.notice.create'))
  end

  scenario '修改使用者' do
    other_user = FactoryBot.create(:user, :other_user)
    visit admin_users_path
    find('table tr:nth-child(2)').click_link I18n.t('common.edit')
    fill_in 'user[email]', with: 'qaz@example.com'
    click_button I18n.t('common.submit')

    expect(page).to have_content('other')
    expect(page).to have_content('qaz@example.com')
    expect(page).to have_text(I18n.t("users.notice.update"))
  end

  scenario '刪除使用者' do
    other_user = FactoryBot.create(:user, :other_user)
    visit admin_users_path
    find('table tr:nth-child(2)').click_link I18n.t('common.destroy')
    page.accept_alert

    expect(page).to have_selector('.user-list', count: 1)
    expect(page).to have_text(I18n.t("users.alert.destroy"))
  end

  scenario '可看到使用者的任務數量' do
    task = FactoryBot.create(:task, user_id: @user.id)
    visit admin_users_path
    
    expect(find('table tr:nth-child(2)')).to have_content(task.user.name)
    expect(find('table tr:nth-child(2)')).to have_content(task.user.email)
    expect(find('table tr:nth-child(2)')).to have_content(task.user.tasks_count)
  end

  scenario '可看到使用者的任務清單' do
    task_first = FactoryBot.create(:task, user_id: @user.id, end_at: 1.days.from_now)
    task_second = FactoryBot.create(:task, user_id: @user.id, end_at: 2.days.from_now)
    visit admin_users_path
    click_link "#{@user.name}"

    expect(find('table tr:nth-child(2)')).to have_content(task_first.title)
    expect(find('table tr:nth-child(3)')).to have_content(task_second.title)
  end
end