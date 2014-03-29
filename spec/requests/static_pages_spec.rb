require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for "all StaticPages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title), visible: false) }
  end

  describe "Home Page" do
    before(:each) { visit root_path }
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all StaticPages"
    it { should_not have_selector('title', text: '| Home', visible: false) }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end
  end

  describe "Help Page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { 'Help' }

    it_should_behave_like "all StaticPages"
  end

  describe "About Page" do
    before { visit about_path }
    let(:heading) { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all StaticPages"
  end

  describe "Contact Page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { 'Contact' }

    it_should_behave_like "all StaticPages"
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us'), visible: false
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help'), visible: false
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact'), visible: false
    click_link "sample app"
    page.should have_selector 'title', text: full_title(''), visible: false
    click_link "Sign up now!"
    page.should have_selector 'h1', text: 'Sign Up'
  end

end