require 'rails_helper'

RSpec.describe Recipe, type: :model do

  # TESTING ONLY

  context "when created" do
    let(:recipe) { Recipe.new }

    it "should have visibility set to true" do
      expect(recipe.visible).to be true
    end

    it "should not have description" do
      expect(recipe.description).to be_nil
    end

  end
end
