
  def signup(name, email, password)
    visit signup_path
    fill_in 'user[name]', with: name
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_button I18n.t("users.signup")
  end

  
  def login(email, password)
    visit login_path
    fill_in 'session[email]', with: email
    fill_in 'session[password]', with: password

    click_button I18n.t('users.login')
  end
  