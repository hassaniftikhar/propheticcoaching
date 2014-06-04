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
    when /question/
      @question = FactoryGirl.create :question
  end
end

When(/^I visit (.+) index page$/) do |klass|
  case klass
    when /ebooks/
      visit ebooks_path
    when /questions/
      visit ebooks_path
      click_link 'Question'
  end
end

When(/^I enter (.+) as keyword for (.+)$/) do |keyword, klass|
  @keyword = keyword
  case klass
    when /ebook/
      fill_in 'ebook_query', with: @keyword
    when /question/
      fill_in 'question_query', with: @keyword
  end
end

When(/^I click (.+) search button$/) do |klass|
  case klass
    when /ebook/
      click_button 'ebook_search'
    when /question/
      click_button 'question_search'
  end
end

Then(/^I should see key word in the matched text$/) do
  page.should have_content @keyword
end

Then(/^keyword should be highlighted in yellow$/) do
  page.has_css?('.highlight').should == true
end
