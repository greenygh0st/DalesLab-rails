require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Blog.new
    article.urllink = "blah-blah"
    assert_not article.save
  end

  test "should not save article without urllink" do
    article = Blog.new
    article.title = "blah blah blah"
    assert_not article.save
  end
end
