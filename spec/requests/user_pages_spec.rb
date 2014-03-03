require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "Signup Page" do
    before(:each) { visit signup_path }
    it { should have_selector('h1', text: 'Sign Up') }
    it { should have_selector('title', full_title('Sign Up'), visible: false) }
  end

end