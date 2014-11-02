# == Schema Information
#
# Table name: data_files
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

class DataFile < ActiveRecord::Base

	def self.save(upload)
	    name =  upload['image'].original_filename
	    directory = "public/data"
	    # create the file path
	    path = File.join(directory, name)
	    # write the file
	    File.open(path, "wb") { |f| f.write(upload['image'].read) }
  	end
end
