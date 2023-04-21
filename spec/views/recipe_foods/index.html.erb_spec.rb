require 'rails_helper'

RSpec.describe "recipe_foods/index", type: :view do
  before(:each) do
    assign(:recipe_foods, [
      RecipeFood.create!(
        recipe: nil,
        food: nil,
        quantity: "9.99"
      ),
      RecipeFood.create!(
        recipe: nil,
        food: nil,
        quantity: "9.99"
      )
    ])
  end

  it "renders a list of recipe_foods" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("9.99".to_s), count: 2
  end
end
