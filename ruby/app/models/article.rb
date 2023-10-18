class Article < ActiveRecord::Base
  self.table_name = 'articles'


  has_many :comment
end

class Comment < ActiveRecord::Base
  self.table_name = 'comment'

  belongs_to :article,
  foreign_key: "article_id"
end
