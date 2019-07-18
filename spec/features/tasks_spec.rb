require "rails_helper"
require 'pry-rails'

RSpec.feature "tasks", type: :feature do

  before(:each) do
    @task = FactoryBot.create(:task)
  end

  scenario "新增任務" do
    visit new_task_path
    fill_in 'task[title]', with: 'new title'
    fill_in 'task[content]', with: 'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'

    click_button I18n.t('common.submit')

    expect(page).to have_content('new title')
    expect(page).to have_text(I18n.t("tasks.notice.create"))
  end

  scenario '刪除任務' do
    visit root_path
    
    expect { click_link I18n.t('common.destroy') }.to change(Task, :count).by(-1)
    expect(page).to have_text(I18n.t("tasks.notice.destroy"))
  end

  scenario '設定截止時間' do
    visit edit_task_path(@task)

    select('2019', from: 'task[end_at(1i)]')
    select('九月', from: 'task[end_at(2i)]')
    select('21', from: 'task[end_at(3i)]')

    click_button I18n.t('common.submit')

    expect(page).to have_content('2019-09-21')
    expect(page).to have_text(I18n.t("tasks.notice.update"))
  end

  scenario '設定任務優先順序' do
    visit edit_task_path(@task)
    fill_in 'task[priority]', with: I18n.t('tasks.priority.high')

    click_button I18n.t('common.submit')

    expect(page).to have_content(I18n.t('tasks.priority.high'))
    expect(page).to have_text(I18n.t("tasks.notice.update"))
  end

  scenario '設定任務目前的狀態' do
    visit edit_task_path(@task)
    fill_in 'task[status]', with: I18n.t('tasks.status.doing')

    click_button I18n.t('common.submit')

    expect(page).to have_content(I18n.t('tasks.status.doing'))
    expect(page).to have_text(I18n.t("tasks.notice.update"))
  end

  scenario '任務依建立時間排序' do
    @new_task = FactoryBot.create(:task)
    visit root_path
    tasks = page.all('.task-item')
    # binding.pry
    expect(tasks[0]).to have_content(@new_task.title)
    expect(tasks[1]).to have_content(@task.title)
  end

  scenario '任務依截止時間排序' do
    @earlier_task = FactoryBot.create(:task, end_at: 2.days.from_now)
    @later_task = FactoryBot.create(:task, end_at: 10.days.from_now)
    visit root_path
    click_link I18n.t('tasks.end_at')
    tasks = page.all('.task-item')
    # binding.pry
    expect(tasks[0]).to have_content(@earlier_task.title)
    expect(tasks[1]).to have_content(@task.title)
    expect(tasks[2]).to have_content(@later_task.title)

    click_link I18n.t('tasks.end_at')
    tasks = page.all('.task-item')
    expect(tasks[0]).to have_content(@later_task.title)
    expect(tasks[1]).to have_content(@task.title)
    expect(tasks[2]).to have_content(@earlier_task.title)
  end
end



# 可新增自己的任務
# 使用者登入後，只能看見自己建立的任務
# 可設定任務的開始及結束時間
# 可設定任務的優先順序（高、中、低）
# 可設定任務目前的狀態（待處理、進行中、已完成）
# 可依狀態篩選任務
# 可以任務的標題、內容進行搜尋
# 可為任務加上分類標籤
# 任務列表，並可依優先順序、開始時間及結束時間等進行排序