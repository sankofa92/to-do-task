require "rails_helper"

RSpec.feature "tasks", type: :feature do

  before(:each) do
    @task = FactoryBot.create(:task)
  end

  scenario "新增任務" do
    visit new_task_path
    fill_in 'task[title]', :with => 'new title'
    fill_in 'task[priority]', :with => 'nnn' 
    click_button '送出'

    expect(page).to have_content('new title')
    expect(page).to have_content('nnn')
  end

  scenario '設定開始及結束時間' do
    visit edit_task_path(@task)
    select('2019', from: 'task[start_at(1i)]')
    select('July', from: 'task[start_at(2i)]')
    select('21', from: 'task[start_at(3i)]')

    select('2019', from: 'task[end_at(1i)]')
    select('September', from: 'task[end_at(2i)]')
    select('21', from: 'task[end_at(3i)]')

    click_button '送出'

    expect(page).to have_content('2019-07-21')
    expect(page).to have_content('2019-09-21')
  end

  scenario '設定任務優先順序' do
    visit edit_task_path(@task)
    fill_in 'task[priority]', with: '高'

    click_button '送出'

    expect(page).to have_content('高')
  end

  scenario '設定任務目前的狀態' do
    visit edit_task_path(@task)
    fill_in 'task[status]', with: '進行中'

    click_button '送出'

    expect(page).to have_content('進行中')
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