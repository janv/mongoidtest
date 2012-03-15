class Presentation
  include Mongoid::Document
  embeds_many :slides, :as => :slide_container
  field :title
end