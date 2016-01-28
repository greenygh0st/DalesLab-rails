require 'test_helper'

class UploadTest < ActiveSupport::TestCase
  test "should not save upload without image" do
    upload = Upload.new
    assert_not upload.save
  end
end
