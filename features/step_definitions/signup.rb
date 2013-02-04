Given /^a user without an account$/ do
  # This condition doesn't require any explicit setup
end

When /^he creates a new account$/ do
  visit "/users/sign_up"
  fill_in('Email address', :with => 'jeremy@octolabs.com')
  fill_in('Password', :with => 'sometestpassword')
  fill_in('Password confirmation', :with => 'sometestpassword')
  click_button('Sign up')
end

Then /^he should see "(.*?)"$/ do |text|
  page.should have_content(text)
end
