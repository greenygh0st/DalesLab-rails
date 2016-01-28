class Upload < ActiveRecord::Base
  #http://railscasts.com/episodes/134-paperclip
  #http://josephndungu.com/tutorials/ajax-file-upload-with-dropezonejs-and-paperclip-rails
  has_attached_file :image, :styles => { :thumb => "100x100>" },
                    :url  => "/assets/pictures/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/pictures/:id/:style/:basename.:extension"

	validates_attachment 	:image,
				:presence => true,
				:content_type => { :content_type => /\Aimage\/.*\Z/ },
				:size => { :less_than => 10.megabyte }

end
