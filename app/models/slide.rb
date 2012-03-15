class Slide
  include Mongoid::Document
  embedded_in :slide_container, :polymorphic => true
  field :title
  field :content
end