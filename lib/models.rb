class Entry < ActiveRecord::Base
  belongs_to :person
end

class Comment < ActiveRecord::Base
  belongs_to :commenter, :class_name => "Person",
                         :foreign_key => "commenter_id"
  belongs_to :commentable, :polymorphic => true
  
end

class Person < ActiveRecord::Base
  has_many :entries
end

def use_main_app_database
  db = File.dirname(__FILE__) + "/../../rails/config/database.yml"
  database_config = YAML.load(ERB.new(IO.read(db)).result)
  env = "production"
  (database_config[env]).symbolize_keys
end

ActiveRecord::Base.establish_connection use_main_app_database

