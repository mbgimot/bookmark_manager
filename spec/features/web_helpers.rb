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
