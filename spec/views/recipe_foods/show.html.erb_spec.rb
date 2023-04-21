require 'rails_helper'

RSpec.describe "recipe_foods/show", type: :view do
  before(:each) do
    assign(:recipe_food, RecipeFood.create!(
      recipe: nil,
      food: nil,
      quantity: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
  end
end
