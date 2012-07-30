class User
  include Dynamoid::Document
  field :name
  field :rating
  has_many :notes
end

class Note
  include Dynamoid::Document
  field :body, :default => "made by orm"
  belongs_to :owner, :class => User
end
