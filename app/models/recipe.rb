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

class Recipe < ActiveRecord::Base

	# def self.save(upload)
	#     name =  upload.original_filename
	#     directory = "public/data"
	#     # create the file path
	#     path = File.join(directory, name)
	#     # write the file
	#     File.open(path, "wb") { |f| f.write(upload.read) }
	#  end
end
