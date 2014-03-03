require 'spec_helper'

describe "StaticPages" do

  subject { page }

  describe "Home Page" do
    before(:each) { visit root_path }
    it { should have_selector('h1', text: 'Sample App') }
    it { should have_selector('title', text: full_title(''), visible: false) }
    it { should_not have_selector('title', text: '| Home', visible: false) }
  end

  describe "Help Page" do
    before { visit help_path }
    it { should have_selector('h1', text: 'Help') }
    it { should have_selector('title', text: full_title('Help'), visible: false) }
  end

  describe "About Page" do
    before { visit about_path }
    it { should have_selector('h1', text: 'About') }
    it { should have_selector('title', text: full_title('About'), visible: false) }
  end

  describe "Contact Page" do
    before { visit contact_path }
    it { should have_selector('h1', text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact'), visible: false) }
  end

end