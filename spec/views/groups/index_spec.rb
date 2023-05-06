require 'rails_helper'

RSpec.describe 'Group index page', type: :feature do
  describe 'Group index page process' do
    before(:each) do
      @group1 = Group.create(name: 'Group 1', icon: 'https://example.com/icon.png')
      @group2 = Group.create(
        name: 'Group 2',
        icon: 'https://exampletipona.com/icon.png'
      )
      @group3 = Group.create(
        name: 'Group 3',
        icon: 'https://example/654s/sdffhsds.com/icon.png'
      )
      @group4 = Group.create(
        name: 'Group 4',
        icon: 'https://example.com/icon.png'
      )
      @group5 = Group.create(
        name: 'Group 5',
        icon: 'https://examplegfggggg.com/icon.png'
      )
      @group6 = Group.create(
        name: 'Group 6',
        icon: 'https://example.com/icon.png'
      )
      @group7 = Group.create(
        name: 'Group 7',
        icon: 'https://exampleexampleexampleexampleexample.com/icon.png'
      )
      @group8 = Group.create(
        name: 'Group 8',
        icon: 'https://ex.com/icon.png'
      )

      visit groups_path
    end
  end
end
