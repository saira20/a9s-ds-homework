require 'active_record'

DB = ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => ENV['DB_NAME'],
  :host => ENV['DB_HOST'],
  :username => ENV['DB_USER'],
  :password => ENV['DB_PASS'],
)

ActiveRecord::Base.connection.create_table(:articles, primary_key: 'id', force: :cascade) do |t|
    t.string :title
    t.string :content
    t.string :created_at
end

ActiveRecord::Base.connection.create_table(:comment, primary_key: 'id', force: :cascade) do |t|
  t.belongs_to  :article , foreign_key: true
  t.text :content
  t.timestamp :created_at
  t.string :author_name
end

require_relative 'article'

Article.create(:title => 'Title ABC', :content => 'Lorem Ipsum', :created_at => Time.now)
Article.create(:title => 'Title ZFX', :content => 'Some Blog Post', :created_at => Time.now)
Article.create(:title => 'Title YNN', :content => 'O_O_Y_O_O', :created_at => Time.now)

puts "Article count in DB: #{Article.count}"


Comment.create(:article_id => 1, :content => 'This is a comment to article 1', :created_at => Time.now, :author_name => 'Mr. X')
Comment.create(:article_id => 1, :content => 'This is another comment to article 1', :created_at => Time.now, :author_name => 'Mr. X')

# Uncommenting below line should give ForeignKeyViolation if article_id = 0 doesn't exist
# Comment.create(:article_id => 0, :content => 'This is another comment to article 1', :created_at => Time.now, :author_name => 'Mr. X')

puts "Comments count in DB: #{Comment.count}"
