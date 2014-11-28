# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  creator     :string(255)
#  url         :string(255)
#  ingredients :string(255)
#  serving     :string(255)
#  notes       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  tags        :string(255)
#  image       :string(255)
#  video_link  :string(255)
#  large_image :string(255)
#  published   :boolean
#

require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
