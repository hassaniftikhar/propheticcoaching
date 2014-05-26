Given(/^I am signed in$/) do
  @current_user = FactoryGirl.create(:user)
  visit '/users/sign_in'
  fill_in 'user_email', with: @current_user.email
  fill_in 'user_password', with: @current_user.password
  click_button 'LOGIN'
end

Given(/^I have a (.+) resource$/) do |klass|
  case klass
    when /book/
      @book = FactoryGirl.create :ebook
  end
end

When(/^I visit ebooks index page$/) do
  visit ebooks_path
end

When(/^I enter (.+) as keyword$/) do |keyword|
  @keyword = keyword
  fill_in 'ebook_query', with: @keyword
end

When(/^I click search button$/) do
  click_button 'ebook_search'
end

Then(/^I should see key word in the matched text$/) do
  page.should have_content @keyword
end

#Then(/^keyword should be highlighted in yellow$/) do
#  p page.has_css?('.highlight')
#end
