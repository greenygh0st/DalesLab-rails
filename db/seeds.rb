# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

mateo = User.create(id: 1, first_name: 'John', last_name: 'Doe', email: 'test@test.com', password: '12345', password_confirmation: 'Mateo1', role: 'admin')
firstblog = Blog.create(title: 'This is a test', urllink: 'this-is-a-test', subtitle: 'First post', category: '#testing', firstimage: 'http://thyblackman.com/wp-content/uploads/2014/12/America-2014.png', content: 'This is your very first blog post...you may want to delete this and get a real post! >-:) \n\nhttps://thyblackman.com/wp-content/uploads/2014/12/America-2014.png', kind_of: 'blog', views: 0, user: mateo, top_image: 'http://d35lb3dl296zwu.cloudfront.net/uploads/photo/image/19860/FXT14021.jpg', is_published: true, published_at: Time.now)
