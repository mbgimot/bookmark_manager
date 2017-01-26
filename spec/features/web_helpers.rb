def add_bubbles_link
  fill_in 'url', with: 'google.com'
  fill_in 'title', with: 'Google'
  fill_in 'tags', with: 'bubbles'
  click_button 'Create Link'
end

def add_random_link
  fill_in 'url', with: 'test'
  fill_in 'title', with: 'test.com'
  fill_in 'tags', with: 'testtag'
  click_button 'Create Link'
end

def sign_up
  email_address = 'test@test.com'
  password = 'test'
  visit ('/')
  fill_in 'email', with: email_address
  fill_in 'password', with: password
  fill_in 'password_conf', with: password
  click_button 'Sign Up'
end

def sign_up_false
  email_address = 'test@test.com'
  password = 'password'
  password2 = 'test'
  visit ('/')
  fill_in 'email', with: email_address
  fill_in 'password', with: password
  fill_in 'password_conf', with: password2
  click_button 'Sign Up'
end
