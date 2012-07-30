require 'spec_helper'
require 'example_app_shared'
require 'models'

if !defined?(Dynamoid)
  puts "** require 'dynamoid' to run the specs in #{__FILE__}"
  exit 1
end
  
Dynamoid.configure do |config|
  config.adapter   = 'local'
  config.namespace = "orm_adapter-dynamoid_test"
  config.logger    = Logger.new($stdout)
  config.logger.level = Logger::ERROR
end

module DynamoidOrmSpec
  # here be the specs!
  describe Dynamoid::Document::OrmAdapter do
    before do
#      User.each{|u| u.destroy}
#      Note.each{|n| n.destroy}
      Dynamoid::Adapter.create_table(User.table_name, User.hash_key, :range_key => User.range_key)
      Dynamoid::Adapter.create_table(Note.table_name, Note.hash_key, :range_key => Note.range_key)
    end
  
    it_should_behave_like "example app with orm_adapter" do
      let(:user_class) { User }
      let(:note_class) { Note }
    end
  end
end
