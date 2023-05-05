equire 'rails_helper'

RSpec.describe 'Group index page', type: :feature do
  describe 'Group index page process' do
    before(:each) do
      @group = Group.create(
        name: 'My Group',
        icon: 'https://example.com/icon.png',
        total_expenses: 100,
        created_at: DateTime.now
      )
      visit groups_path
    end

    it 'should have a Group name' do
      expect(page).to have_content(@group.name)
    end
  end
end
