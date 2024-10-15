require 'rails_helper'

RSpec.feature 'HomePages', type: :feature do
  describe 'Home' do
    it 'should' do
      visit root_path

      expect(page).to have_text('Sign in')
    end
  end
end
