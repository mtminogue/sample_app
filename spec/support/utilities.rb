include ApplicationHelper

def valid_signin(user)
	fill_in "Email", with: user.email 
	fill_in "Password", with: user.password 
	click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
	match do |page|
		expect(page).to have_selector('div.alert.alert-error', text: message)
	end
end

def visit_signin_page
	before { visit signin_path }
end

def user_signup
	before do
		fill_in "Name", with: "Example User"
		fill_in "Email", with: "user@example.com"
		fill_in "Password", with: "foobar"
		fill_in "Confirm Password", with: "foobar"
	end
end

def visit_signup_page
	before { visit signup_path }
end

RSpec::Matchers.define :have_success_message do |message|
	match do |page|
		expect(page).to have_selector('div.alert.alert-success', text: message)
	end
end

def visit_user_page
	before { visit user_path(user) }
end

def sign_in(user, options={})
	if options[:no_capybara]
		#Sign in when not using Capybara.
		remember_token = User.new_remember_token
		cookies[:remember_token] = remember_token
		user.update_attribute(:remember_token, User.hash(remember_token))
	else
		visit signin_path
		fill_in "Email", with: user.email
		fill_in "Password", with: user.password
		click_button "Sign in"
	end
end