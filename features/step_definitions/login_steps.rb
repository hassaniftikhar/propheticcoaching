Given(/^I am not signed in$/) do
  page.driver.submit :delete, '/users/sign_out', {}
end

When(/^I visit the root page$/) do
  visit "/"
end

When(/^I click login link$/) do
  click_link 'LOG-IN'
end

Then(/^I should see (.+) field$/) do |field|
  page.should have_selector('#'+field)
end

Then(/^I click on login button$/) do
  click_button 'LOGIN'
end

Then(/^I should be logged in to the site$/) do
  page.should have_content 'Signed in successfully.'
end

Given(/^I am a valid user$/) do
  @user = FactoryGirl.create :user
end

Then(/^I fill login form with (.+) data$/) do |stance|
  fill_in 'user_email', with: @user.email
  if stance =~ /^valid$/
    fill_in 'user_password', with: @user.password
  else
    fill_in 'user_password', with: 'invalid-password'
  end
end

Then(/^I should be redirected to signin page$/) do
  current_path.should == new_user_session_path
end