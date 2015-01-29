Given /^the following users exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |element|
    User.create(element)
  end
  
end

Given /^the following articles exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |element|
    Article.create(element)
  end
end

Given /^the following comments exist:$/ do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |element|
    Comment.create(element)
  end
end

Given /^I am logged in as "(.*?)" with pass "(.*?)"$/ do |user, pass|
  visit '/accounts/login'
  fill_in 'user_login', :with => user
  fill_in 'user_password', :with => pass
  click_button 'Login'
  assert page.has_content? 'Login successful'
end

Given /^the articles with id "(.*?)" and "(.*?)" were merged$/ do |id1, id2|
  Article.find_by_id(id1).merge_with(id2)
end

Then /^"(.*?)" should be the author of (\d+) articles$/ do |user, articles|
  assert Article.find_all_by_author(User.find_name(user).login).size == Integer(articles)
end
