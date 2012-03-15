class Concept
  include Mongoid::Document
  extend HasLanguageProxy
  
  embeds_many_multilang :slides, :as => :slide_container
  field :title
end